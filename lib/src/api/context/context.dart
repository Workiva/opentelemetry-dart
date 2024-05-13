// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information
import '../../../api.dart' as api;

abstract class Context {
  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  static ContextKey createKey(String name) => ContextKey(name);

  /// Returns the value from this context identified by [key], or null if no
  /// such value is set.
  T? getValue<T>(ContextKey key);

  /// Returns a new context created from this one with the given key/value pair
  /// set.
  ///
  /// If [key] was already set in this context, it will be overridden. The rest
  /// of the context values will be inherited.
  Context setValue(ContextKey key, Object value);

  /// Returns a new [Context] created from this one with the given [api.Span]
  /// set.
  Context withSpan(api.Span span);

  /// Execute a function [fn] within this [Context] and return its result.
  R execute<R>(R Function() fn);

  /// Get the [api.Span] attached to this [Context], or an invalid, [api.Span] if no such
  /// [api.Span] exists.
  api.Span get span;

  /// Get the [api.SpanContext] from this [Context], or an invalid [api.SpanContext] if no such
  /// [api.SpanContext] exists.
  api.SpanContext get spanContext;
}

class ContextKey {
  /// Name of the context key.
  final String name;

  /// Construct a [ContextKey] with a given [name].
  ContextKey(this.name);
}
