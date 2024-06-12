// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:meta/meta.dart';

import 'propagation/noop_text_map_propagator.dart';
import 'trace/noop_tracer_provider.dart';

import '../../api.dart' as api;
import '../experimental_api.dart' show globalContextManager;

final api.TracerProvider _noopTracerProvider = NoopTracerProvider();
final api.TextMapPropagator _noopTextMapPropagator = NoopTextMapPropagator();
api.TracerProvider _tracerProvider = _noopTracerProvider;
api.TextMapPropagator _textMapPropagator = _noopTextMapPropagator;

api.TracerProvider get globalTracerProvider => _tracerProvider;

api.TextMapPropagator get globalTextMapPropagator => _textMapPropagator;

void registerGlobalTracerProvider(api.TracerProvider tracerProvider) {
  if (_tracerProvider != _noopTracerProvider) {
    throw StateError('A global TracerProvider has already been created. '
        'registerGlobalTracerProvider must be called only once before any '
        'calls to the getter globalTracerProvider.');
  }

  _tracerProvider = tracerProvider;
}

void registerGlobalTextMapPropagator(api.TextMapPropagator textMapPropagator) {
  if (_textMapPropagator != _noopTextMapPropagator) {
    throw StateError('A global TextMapPropagator has already been created. '
        'registerGlobalTextMapPropagator must be called only once before any '
        'calls to the getter globalTextMapPropagator.');
  }

  _textMapPropagator = textMapPropagator;
}

/// Records a span of the given [name] for the given function with a given
/// [api.Tracer] and marks the span as errored if an exception occurs.
@Deprecated(
    'This method will be removed in 0.19.0. Use [traceContext] instead.')
Future<T> trace<T>(String name, Future<T> Function() fn,
    {api.Context? context, api.Tracer? tracer}) async {
  context ??= globalContextManager.active;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  final span = tracer.startSpan(name, context: context);
  try {
    return await api.contextWithSpan(context, span).execute(fn);
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}

/// Records a span of the given [name] for the given function with a given
/// [api.Tracer] and marks the span as errored if an exception occurs.
@experimental
Future<T> traceContext<T>(String name, Future<T> Function(api.Context) fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal}) async {
  context ??= globalContextManager.active;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  // TODO: use start span option `newRoot` instead
  if (newRoot) {
    context = api.contextWithSpanContext(context, api.SpanContext.invalid());
  }

  final span = tracer.startSpan(name, context: context);
  try {
    return await fn(api.contextWithSpan(context, span));
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}

/// Use [traceSync] instead of [trace] when [fn] is not an async function.
@Deprecated(
    'This method will be removed in 0.19.0. Use [traceSyncContext] instead.')
R traceSync<R>(String name, R Function() fn,
    {api.Context? context, api.Tracer? tracer}) {
  context ??= globalContextManager.active;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  final span = tracer.startSpan(name, context: context);

  try {
    final r = api.contextWithSpan(context, span).execute(fn);

    if (r is Future) {
      throw ArgumentError.value(fn, 'fn',
          'Use traceSync to trace functions that do not return a [Future].');
    }

    return r;
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}

/// Use [traceSyncContext] instead of [traceContext] when [fn] is not an async function.
@experimental
R traceSyncContext<R>(String name, R Function(api.Context) fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal}) {
  context ??= globalContextManager.active;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  // TODO: use start span option `newRoot` instead
  if (newRoot) {
    context = api.contextWithSpanContext(context, api.SpanContext.invalid());
  }

  final span = tracer.startSpan(name, context: context);
  try {
    final r = fn(api.contextWithSpan(context, span));

    if (r is Future) {
      throw ArgumentError.value(fn, 'fn',
          'Use traceSyncContext to trace functions that do not return a [Future].');
    }

    return r;
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}
