// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../../api.dart';
import '../trace/nonrecording_span.dart' show NonRecordingSpan;

final Logger _log = Logger('opentelemetry');

@sealed
class ContextKey {}

final ContextKey _contextKey = ContextKey();
final ContextKey _contextStackKey = ContextKey();
final ContextKey _spanKey = ContextKey();

@sealed
class ContextToken {}

class ContextStackEntry {
  final Context context;
  final ContextToken token;

  ContextStackEntry(this.context) : token = ContextToken();
}

final _rootContext = Context._empty();
final _rootStack = <ContextStackEntry>[];

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

@experimental
Zone zoneWithContext(Context context) {
  return Zone.current.fork(zoneValues: {
    _contextKey: context,
    _contextStackKey: <ContextStackEntry>[],
  });
}

@experimental
Context contextFromZone({Zone? zone}) {
  return (zone ?? Zone.current)[_contextKey] ?? _rootContext;
}

/// The root context which all other contexts are derived from.
///
/// Generally, the root [Context] should not be used directly. Instead, use
/// [active] to operate on the current [Context].
@experimental
Context get root {
  return _rootContext;
}

/// The active context.
///
/// The active context is the latest attached context, if one exists, otherwise
/// the latest zone context, if one exists, otherwise the root context.
@experimental
Context get active {
  return _activeAttachedContext ?? _activeZoneContext ?? _rootContext;
}

/// Returns the latest non-empty context stack, or the root stack if no context
/// stack is found.
List<ContextStackEntry> get _activeAttachedContextStack {
  var zone = Zone.current;
  List<ContextStackEntry>? stack = zone[_contextStackKey];

  // walk up the zone tree to find the first non-empty context stack
  while (stack != null && stack.isEmpty) {
    if (zone.parent == null) {
      return _rootStack;
    }

    zone = zone.parent!;
    stack = zone[_contextStackKey];
  }

  // return the stack if found, else return the root stack
  return stack ?? _rootStack;
}

Context? get _activeAttachedContext {
  final stack = _activeAttachedContextStack;
  return stack.isEmpty ? null : stack.last.context;
}

Context? get _activeZoneContext {
  return Zone.current[_contextKey];
}

/// Attaches the given [Context] making it the active [Context] for the current
/// [Zone] and all child [Zone]s and returns a [ContextToken] that must be used
/// to detach the [Context].
///
/// When a [Context] is attached, it becomes active and overrides any [Context]
/// that may otherwise be visible within a [Zone]. For example, if a [Context]
/// is attached while [active] is called within a [Zone] created by
/// [zoneWithContext], [active] will return the attached [Context] and not the
/// [Context] given to [zoneWithContext]. Once the attached [Context] is
/// detached, [active] will return the [Context] given to [zoneWithContext].
@experimental
ContextToken attach(Context context) {
  final entry = ContextStackEntry(context);
  (Zone.current[_contextStackKey] ?? _rootStack).add(entry);
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
bool detach(ContextToken token) {
  final stack = _activeAttachedContextStack;

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
  Zone? zone = Zone.current;
  do {
    final stack = zone?[_contextStackKey] as List<ContextStackEntry>?;
    final index = stack?.indexWhere((c) => c.token == token);
    if (index != null && index != -1) {
      // token found, remove it, but return false since it wasn't expected
      stack!.removeAt(index);
      return false;
    }
    zone = zone?.parent;
  } while (zone != null);

  // the token was nowhere to be found, a context was not detached
  return false;
}

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
  @Deprecated(
      'This method will be removed in 0.19.0. Use the API global function '
      '[active] instead.')
  static Context get current => active;

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [Context] directly -
  /// instead, use [Context.current] to operate on the current [Context].
  /// Only use this context if you are certain you need to disregard the
  /// current [Context].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [Context] is "current".
  @Deprecated(
      'This method will be removed in 0.19.0. Use the API global function '
      '[root] instead.')
  static Context get root => _rootContext;

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [ContextKey] instead.')
  static ContextKey createKey(String name) => ContextKey();

  /// Returns the value identified by [key], or null if no such value exists.
  T? getValue<T>(ContextKey key) =>
      _key == key ? _value as T : _parent?.getValue(key);

  /// Returns a new child context containing the given key/value.
  Context setValue(ContextKey key, Object value) => Context._(this, key, value);

  /// Returns a new [Context] created from this one with the given [Span]
  /// set.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [contextWithSpan] instead.')
  Context withSpan(Span span) => contextWithSpan(this, span);

  /// Execute a function [fn] within this [Context] and return its result.
  @Deprecated('This method will be removed in 0.19.0. Use [zoneWithContext] '
      'instead.')
  R execute<R>(R Function() fn) => zoneWithContext(this).run(fn);

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
