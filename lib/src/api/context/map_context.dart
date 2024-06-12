// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';

import '../../../api.dart';

class MapContext implements Context {
  final Map<ContextKey, Object> _contextMap = {};

  @protected
  MapContext();

  /// Returns the value from this context identified by [key], or null if no
  /// such value is set.
  @override
  T? getValue<T>(ContextKey key) => _contextMap[key] as T?;

  /// Returns a new context created from this one with the given key/value pair
  /// set.
  ///
  /// If [key] was already set in this context, it will be overridden. The rest
  /// of the context values will be inherited.
  @override
  MapContext setValue(ContextKey key, Object value) {
    final newContext = MapContext();
    newContext._contextMap.addAll(_contextMap);
    newContext._contextMap[key] = value;
    return newContext;
  }

  /// Returns a new [MapContext] created from this one with the given [Span]
  /// set.
  @override
  Context withSpan(Span span) => contextWithSpan(this, span);

  /// Execute a function, this is a no-op for [MapContext].
  @override
  R execute<R>(R Function() fn) => fn();

  /// Get the [Span] attached to this [MapContext], or an invalid, [Span] if no such
  /// [Span] exists.
  @override
  Span get span => spanFromContext(this);

  /// Get the [SpanContext] from this [MapContext], or an invalid [SpanContext] if no such
  /// [SpanContext] exists.
  @override
  SpanContext get spanContext => spanContextFromContext(this);
}
