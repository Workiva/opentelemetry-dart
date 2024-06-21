// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart';
import '../../experimental_api.dart' show globalContextManager;
import '../trace/nonrecording_span.dart' show NonRecordingSpan;

class ContextKey {}

final ContextKey spanKey = ContextKey();

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

abstract class Context {
  /// The active context.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [globalContextManager.active] instead.')
  static Context get current => globalContextManager.active;

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [Context] directly -
  /// instead, use [Context.current] to operate on the current [Context].
  /// Only use this context if you are certain you need to disregard the
  /// current [Context].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [Context] is "current".
  @Deprecated(
      'This method will be removed in 0.19.0. Use [contextWithSpanContext(globalContextManager.active, SpanContext.invalid())] instead.')
  static Context get root => contextWithSpanContext(
      globalContextManager.active, SpanContext.invalid());

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [ContextKey] instead.')
  static ContextKey createKey(String name) => ContextKey();

  /// Returns the value from this context identified by [key], or null if no
  /// such value is set.
  T? getValue<T>(ContextKey key);

  /// Returns a new context created from this one with the given key/value pair
  /// set.
  ///
  /// If [key] was already set in this context, it will be overridden. The rest
  /// of the context values will be inherited.
  Context setValue(ContextKey key, Object value);

  /// Returns a new [Context] created from this one with the given [Span]
  /// set.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [contextWithSpan] instead.')
  Context withSpan(Span span);

  /// Execute a function [fn] within this [Context] and return its result.
  @Deprecated(
      'This method will be removed in 0.19.0. Propagate [Context] as an '
      'argument to [fn] and call [fn] directly or use '
      '[(context as ZoneContext).run((_) => fn(this))] instead.')
  R execute<R>(R Function() fn);

  /// Get the [Span] attached to this [Context], or an invalid, [Span] if no such
  /// [Span] exists.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [spanFromContext] instead.')
  Span get span;

  /// Get the [SpanContext] from this [Context], or an invalid [SpanContext] if no such
  /// [SpanContext] exists.
  @Deprecated(
      'This method will be removed in 0.19.0. Use [spanContextFromContext] instead.')
  SpanContext get spanContext;
}
