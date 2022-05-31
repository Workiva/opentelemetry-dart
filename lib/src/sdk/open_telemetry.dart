// Copyright 2021-2022 Workiva Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import '../../api.dart' as api;
import '../../sdk.dart' as sdk;

final api.TracerProvider _noopTracerProvider = sdk.TracerProviderBase();
api.TracerProvider _tracerProvider = _noopTracerProvider;
api.TextMapPropagator _textMapPropagator;

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
  if (_textMapPropagator != null) {
    throw StateError('A global TextMapPropagator has already been created. '
        'registerGlobalTextMapPropagator must be called only once before any '
        'calls to the getter globalTextMapPropagator.');
  }

  _textMapPropagator = textMapPropagator;
}

/// Records a span of the given [name] for the given function with a given
/// [api.Tracer] and marks the span as errored if an exception occurs.
Future<T> trace<T>(String name, Future<T> Function() fn,
    {api.Context context, api.Tracer tracer}) async {
  context ??= api.Context.current;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  final span = tracer.startSpan(name, context: context);

  try {
    return await context.withSpan(span).execute(fn);
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, description: e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}

/// Use [traceSync] instead of [trace] when [fn] is not an async function.
R traceSync<R>(String name, R Function() fn,
    {api.Context context, api.Tracer tracer}) {
  context ??= api.Context.current;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  final span = tracer.startSpan(name, context: context);

  try {
    final r = context.withSpan(span).execute(fn);

    if (r is Future) {
      throw ArgumentError.value(fn, 'fn', 'Use traceSync to trace functions that do not return a [Future].');
    }

    return r;
  } catch (e, s) {
    span
      ..setStatus(api.StatusCode.error, description: e.toString())
      ..recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}
