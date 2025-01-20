// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../api.dart' hide Logger;
import '../trace/nonrecording_span.dart' show NonRecordingSpan;

final Logger _log = Logger('opentelemetry');

/// A key used to set and get values from a [Context].
///
/// Note: This class is not intended to be extended or implemented. The class
/// will be marked as sealed in 0.19.0.
// TODO: @sealed
class ContextKey {}

final ContextKey _spanKey = ContextKey();

@sealed
class ContextToken {}

class ContextStackEntry {
  final Context context;
  final ContextToken token;

  ContextStackEntry(this.context) : token = ContextToken();
}

final _rootContext = Context._empty();
final _stacks = <Zone, List<ContextStackEntry>>{
  Zone.root: [],
};

Context contextWithSpan(Context parent, Span span) {
  return parent.setValue(_spanKey, span);
}

Context contextWithSpanContext(Context parent, SpanContext spanContext) {
  return contextWithSpan(parent, NonRecordingSpan(spanContext));
}

Span spanFromContext(Context context) {
  return context.getValue(_spanKey) ?? NonRecordingSpan(SpanContext.invalid());
}

SpanContext spanContextFromContext(Context context) {
  return spanFromContext(context).spanContext;
}

/// Returns a new [Zone] such that the given context will be automatically
/// attached and detached for any function that runs within the zone.
@experimental
Zone zone([Context? context]) => Zone.current.fork(
        specification: ZoneSpecification(run: <R>(self, parent, zone, fn) {
      // Only attach the context when delegating this zone's run, not any
      // potential child. Otherwise, the child zone's current context would
      // end up being the outermost zone attached context.
      if (self == zone) {
        final token = Context.attach(context ?? _currentContext(zone), zone);
        final result = parent.run(zone, fn);
        if (result is Future) {
          result.whenComplete(() {
            Context.detach(token, zone);
          });
        } else {
          Context.detach(token, zone);
        }
        return result;
      }
      return parent.run(zone, fn);
    }));

/// Returns the latest non-empty context stack, or the root stack if no context
/// stack is found.
List<ContextStackEntry> _currentContextStack(Zone zone) {
  var stack = _stacks[zone];
  while (stack == null || stack.isEmpty) {
    // walk up the zone tree to find the first non-null, non-empty context stack
    final parent = zone.parent;
    if (parent == null) {
      return _stacks[Zone.root] ?? [];
    }
    zone = parent;
    stack = _stacks[zone];
  }
  return stack;
}

Context _currentContext([Zone? zone]) =>
    _currentContextStack(zone ?? Zone.current).lastOrNull?.context ??
    _rootContext;

class Context {
  final Context? _parent;
  final ContextKey _key;
  final Object _value;

  Context._empty()
      : _parent = null,
        _key = ContextKey(),
        _value = Object();

  Context._(this._parent, this._key, this._value);

  /// The active context.
  ///
  /// The current context is the latest attached context, if one exists.
  /// Otherwise, it is the root context.
  static Context get current => _currentContext();

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [Context] directly -
  /// instead, use [Context.current] to operate on the current [Context].
  /// Only use this context if you are certain you need to disregard the
  /// current [Context].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [Context] is "current".
  static Context get root => _rootContext;

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [ContextKey] instead.')
  static ContextKey createKey(String name) => ContextKey();

  /// Attaches the given [Context] making it the active [Context] for the current
  /// [Zone] and all child [Zone]s and returns a [ContextToken] that must be used
  /// to detach the [Context].
  ///
  /// When a [Context] is attached, it becomes active and overrides any [Context]
  /// that may otherwise be visible within that [Zone]. The [Context] will not
  /// be visible to any parent or sibling [Zone]. The [Context] will only be
  /// visible for the current [Zone] and any child [Zone].
  @experimental
  static ContextToken attach(Context context, [Zone? zone]) {
    final entry = ContextStackEntry(context);
    _stacks.update(zone ?? Zone.current, (stack) => stack..add(entry),
        ifAbsent: () => [entry]);
    return entry.token;
  }

  /// Detaches the [Context] associated with the given [ContextToken] from their
  /// associated [Zone].
  ///
  /// Returns `true` if the given [ContextToken] is associated with the latest,
  /// expected, attached [Context], `false` otherwise.
  ///
  /// If the [ContextToken] is not found in the latest stack, detach will walk up
  /// the [Zone] tree attempting to find and detach the associated [Context].
  ///
  /// Regardless of whether the [Context] is found, if the given [ContextToken] is
  /// not expected, a warning will be logged.
  @experimental
  static bool detach(ContextToken token, [Zone? zone]) {
    final stack = _currentContextStack(zone ?? Zone.current);

    final index = stack.indexWhere((c) => c.token == token);

    // the expected context to detach is the latest entry of the latest stack
    final match = index != -1 && index == stack.length - 1;
    if (!match) {
      _log.warning('unexpected (mismatched) token given to detach');
    }

    if (index != -1) {
      // context found in the latest stack, possibly the latest entry
      stack.removeAt(index);
      return match;
    }

    // at this point, the token was not in the latest stack, but it might be in a
    // stack held by a parent zone

    // walk up the zone tree checking for the token in each zone's context stack
    zone ??= Zone.current;
    do {
      final stack = _stacks[zone!];
      final index = stack?.indexWhere((c) => c.token == token);
      if (index != null && index != -1) {
        // token found, remove it, but return false since it wasn't expected
        stack!.removeAt(index);
        return false;
      }
      zone = zone.parent;
    } while (zone != null);

    // the token was nowhere to be found, a context was not detached
    _log.warning('failed to detach context');
    return false;
  }

  /// Returns the value identified by [key], or null if no such value exists.
  T? getValue<T>(ContextKey key) {
    // check this context version or its previous versions
    final value = _key == key ? _value : _parent?._getValue(key);
    if (value != null) {
      return value as T;
    }

    // check other contexts within the current zone or a parent zone
    Zone? zone = Zone.current;
    while (zone != null) {
      final stack = _stacks[zone];
      if (stack != null && stack.isNotEmpty) {
        for (final entry in stack.reversed) {
          final value = entry.context._getValue(key);
          if (value != null) {
            return value as T;
          }
        }
      }
      zone = zone.parent;
    }
    return null;
  }

  T? _getValue<T>(ContextKey key) =>
      _key == key ? _value as T : _parent?._getValue(key);

  /// Returns a new child context containing the given key/value.
  Context setValue(ContextKey key, Object value) => Context._(this, key, value);

  /// Returns a new [Context] created from this one with the given [Span]
  /// set.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [contextWithSpan] instead.')
  Context withSpan(Span span) => contextWithSpan(this, span);

  /// Execute a function [fn] within this [Context] and return its result.
  @Deprecated('This method will be removed in 0.19.0. Use [zone] instead.')
  R execute<R>(R Function() fn) => zone(this).run(fn);

  /// Get the [Span] attached to this [Context], or a [NonRecordingSpan] if no
  /// such [Span] exists.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [spanFromContext] instead.')
  Span get span => spanFromContext(this);

  /// Get the [SpanContext] from this [Context], or an invalid [SpanContext] if
  /// no such [SpanContext] exists.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [spanContextFromContext] '
      'instead.')
  SpanContext get spanContext => spanContextFromContext(this);
}
