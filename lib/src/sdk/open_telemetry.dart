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
R trace<R>(String name, R Function() fn,
    {api.Context context, api.Tracer tracer}) {
  context ??= api.Context.current;
  tracer ??= _tracerProvider.getTracer('opentelemetry-dart');

  final span = tracer.startSpan(name, context: context);

  if (R is! Future) {
    try {
      return context.withSpan(span).execute(fn);
    } catch (e, s) {
      span
        ..setStatus(api.StatusCode.error, description: e.toString())
        ..recordException(e, stackTrace: s);
      rethrow;
    } finally {
      span.end();
    }
  }

  // NOTE: When [R] is a [Future] then wrap the call to [fn] to avoid
  //       unhandled synchronous errors from leaking out of this function.
  //       This allows all errors to be handled and logged by the
  //       [Future.catchError] below.
  //
  // From https://www.dartlang.org/guides/libraries/futures-error-handling#solution-using-futuresync-to-wrap-your-code
  //   >
  //   > A common pattern for ensuring that no synchronous error is
  //   > accidentally thrown from a function is to wrap the function body
  //   > inside a new Future.sync() callback
  return Future
      .sync(() => context.withSpan(span).execute(fn))
      .then((value) => value)
      .catchError((e, s) {
    // Since [fn] is wrapped in a [Future.sync], this error handler
    // will also catch errors thrown from the synchronous portion of [fn].
    // If [fn] is an async function and/or returns a [Future] then errors
    // thrown by the returned future will also be handled here.
    span
      ..setStatus(api.StatusCode.error, description: e.toString())
      ..recordException(e, stackTrace: s);

    // Throwing the original error from within the [Future.catchError] handler
    // is equivalent to a [rethrow] from within a regular `catch (e) {...}` handler.
    // In this way, the originating [StackTrace] is preserved.
    throw e;
  })
      .whenComplete(span.end) as R;
}
