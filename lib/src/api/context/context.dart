// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:meta/meta.dart';

import '../../../api.dart';
import '../trace/nonrecording_span.dart' show NonRecordingSpan;

typedef ContextKey = Object;

final ContextKey contextKey = ContextKey();
final ContextKey contextStackKey = ContextKey();
final ContextKey spanKey = ContextKey();

typedef ContextToken = Object;

class ContextStackEntry {
  final Context context;
  final ContextToken token;

  ContextStackEntry(this.context) : token = ContextToken();
}

final _rootContext = Context._empty();
final rootStack = <ContextStackEntry>[];

Context contextWithSpan(Context parent, Span span) {
  return parent.setValue(spanKey, span);
}

Context contextWithSpanContext(Context parent, SpanContext spanContext) {
  return contextWithSpan(parent, NonRecordingSpan(spanContext));
}

Span spanFromContext(Context context) {
  return context.getValue(spanKey) ?? NonRecordingSpan(SpanContext.invalid());
}

SpanContext spanContextFromContext(Context context) {
  return spanFromContext(context).spanContext;
}

@experimental
Zone zoneWithContext(Context context) {
  return Zone.current.fork(zoneValues: {contextKey: context});
}

@experimental
Context get root {
  return _rootContext;
}

@experimental
Context get active {
  return _activeAttachedContext ?? _activeZoneContext ?? _rootContext;
}

Context? get _activeAttachedContext {
  final List<ContextStackEntry> stack =
      Zone.current[contextStackKey] ?? rootStack;
  return stack.isEmpty ? null : stack.last.context;
}

Context? get _activeZoneContext {
  return Zone.current[contextKey];
}

ContextToken attach(Context context) {
  final entry = ContextStackEntry(context);
  (Zone.current[contextStackKey] ?? rootStack).add(entry);
  return entry.token;
}

bool detach(ContextToken token) {
  final List<ContextStackEntry> stack =
      Zone.current[contextStackKey] ?? rootStack;

  final index = stack.indexWhere((c) => c.token == token);
  final success = index == stack.length - 1;
  if (index != -1) {
    stack.removeAt(index);
  }

  // TODO: log attach/detach mismatch warning
  return success;
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
