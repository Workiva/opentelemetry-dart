// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:meta/meta.dart';

import '../../api.dart' as api;
import '../../src/sdk/trace/tracer.dart' as sdk show Tracer;
import '../experimental_api.dart';
import 'propagation/noop_text_map_propagator.dart';
import 'trace/noop_tracer_provider.dart';

final api.TracerProvider _noopTracerProvider = NoopTracerProvider();
final api.TextMapPropagator _noopTextMapPropagator = NoopTextMapPropagator();
final api.LoggerProvider _noopLoggerProvider = api.NoopLoggerProvider();
api.LoggerProvider _logProvider = _noopLoggerProvider;
api.TracerProvider _tracerProvider = _noopTracerProvider;
api.TextMapPropagator _textMapPropagator = _noopTextMapPropagator;

api.TracerProvider get globalTracerProvider => _tracerProvider;

api.LoggerProvider get globalLogProvider => _logProvider;

api.TextMapPropagator get globalTextMapPropagator => _textMapPropagator;

void registerGlobalTracerProvider(api.TracerProvider tracerProvider) {
  if (_tracerProvider != _noopTracerProvider) {
    throw StateError('A global TracerProvider has already been created. '
        'registerGlobalTracerProvider must be called only once before any '
        'calls to the getter globalTracerProvider.');
  }

  _tracerProvider = tracerProvider;
}

void registerGlobalLogProvider(api.LoggerProvider logProvider) {
  if (_logProvider != _noopLoggerProvider) {
    throw StateError('A global LoggerProvider has already been created. '
        'registerGlobalLoggerProvider must be called only once before any '
        'calls to the getter globalLoggerProvider.');
  }

  _logProvider = logProvider;
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
@Deprecated('Will be removed in v0.19.0. Use [trace] instead')
@experimental
Future<T> traceContext<T>(String name, Future<T> Function(api.Context) fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) async {
  return trace(name, () => fn(api.Context.current),
      context: context,
      tracer: tracer,
      newRoot: newRoot,
      spanKind: spanKind,
      spanLinks: spanLinks);
}

/// Use [traceContextSync] instead of [traceContext] when [fn] is not an async
/// function.
@Deprecated('Will be removed in v0.19.0. Use [traceSync] instead')
@experimental
T traceContextSync<T>(String name, T Function(api.Context) fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) {
  return traceSync(name, () => fn(api.Context.current),
      context: context,
      tracer: tracer,
      newRoot: newRoot,
      spanKind: spanKind,
      spanLinks: spanLinks);
}

/// Records a span of the given [name] for the given function with a given
/// [api.Tracer] and marks the span as errored if an exception occurs.
@experimental
Future<T> trace<T>(String name, Future<T> Function() fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    List<api.Attribute> spanAttributes = const [],
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) async {
  context ??= api.Context.current;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  // TODO: use start span option `newRoot` instead
  var span;
  if (tracer is sdk.Tracer) {
    span = tracer.startSpan(name,
        context: context,
        attributes: spanAttributes,
        kind: spanKind,
        links: spanLinks,
        newRoot: newRoot);
  } else {
    span = tracer.startSpan(name,
        context: newRoot ? api.Context.root : context,
        attributes: spanAttributes,
        kind: spanKind,
        links: spanLinks);
  }

  try {
    return await Zone.current.fork().run(() {
      final token = api.Context.attach(api.contextWithSpan(context!, span));
      return fn().whenComplete(() {
        if (!api.Context.detach(token)) {
          span.addEvent('unexpected (mismatched) token given to detach');
        }
      });
    });
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
T traceSync<T>(String name, T Function() fn,
    {api.Context? context,
    api.Tracer? tracer,
    bool newRoot = false,
    List<api.Attribute> spanAttributes = const [],
    api.SpanKind spanKind = api.SpanKind.internal,
    List<api.SpanLink> spanLinks = const []}) {
  context ??= api.Context.current;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  // TODO: use start span option `newRoot` instead
  var span;
  if (tracer is sdk.Tracer) {
    span = tracer.startSpan(name,
        context: context,
        attributes: spanAttributes,
        kind: spanKind,
        links: spanLinks,
        newRoot: newRoot);
  } else {
    span = tracer.startSpan(name,
        context: newRoot ? api.Context.root : context,
        attributes: spanAttributes,
        kind: spanKind,
        links: spanLinks);
  }

  try {
    return Zone.current.fork().run(() {
      final token = api.Context.attach(api.contextWithSpan(context!, span));

      final r = fn();

      if (!api.Context.detach(token)) {
        span.addEvent('unexpected (mismatched) token given to detach');
      }

      if (r is Future) {
        throw ArgumentError.value(fn, 'fn',
            'Use traceSync to trace functions that do not return a [Future].');
      }
      return r;
    });
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}
