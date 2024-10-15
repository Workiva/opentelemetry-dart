// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:meta/meta.dart';

import '../../api.dart' as api;
import 'propagation/noop_text_map_propagator.dart';
import 'trace/noop_tracer_provider.dart';

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
// TODO: @Deprecated('Will be removed in v0.20.0. Use [trace] instead')
@experimental
Future<T> traceContext<T>(String name, Future<T> Function(api.Context) fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) async {
  return trace(name, () => fn(api.contextFromZone()),
      context: context,
      tracer: tracer,
      newRoot: newRoot,
      spanKind: spanKind,
      spanLinks: spanLinks);
}

/// Use [traceContextSync] instead of [traceContext] when [fn] is not an async function.
// TODO: @Deprecated('Will be removed in v0.20.0. Use [traceSync] instead')
@experimental
T traceContextSync<T>(String name, T Function(api.Context) fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) {
  return traceSync(name, () => fn(api.contextFromZone()),
      context: context,
      tracer: tracer,
      newRoot: newRoot,
      spanKind: spanKind,
      spanLinks: spanLinks);
}

/// Records a span of the given [name] for the given function with a given
/// [api.Tracer] and marks the span as errored if an exception occurs.
@experimental
@Deprecated('Will be removed in v0.19.0. Use [traceContext] instead.')
Future<T> trace<T>(String name, Future<T> Function() fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) async {
  context ??= api.active;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  // TODO: use start span option `newRoot` instead
  if (newRoot) {
    context = api.contextWithSpanContext(context, api.SpanContext.invalid());
  }

  final span = tracer.startSpan(name,
      context: context, kind: spanKind, links: spanLinks);
  context = api.contextWithSpan(context, span);
  try {
    return await api.zoneWithContext(context).run(fn);
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
@experimental
@Deprecated('Will be removed in v0.19.0. Use [traceContextSync] instead.')
T traceSync<T>(String name, T Function() fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) {
  context ??= api.active;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  // TODO: use start span option `newRoot` instead
  if (newRoot) {
    context = api.contextWithSpanContext(context, api.SpanContext.invalid());
  }

  final span = tracer.startSpan(name,
      context: context, kind: spanKind, links: spanLinks);
  context = api.contextWithSpan(context, span);
  try {
    final r = api.zoneWithContext(context).run(fn);
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
