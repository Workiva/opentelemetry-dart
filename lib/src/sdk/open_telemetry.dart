import 'dart:async';

import '../../api.dart' as api;
import '../../sdk.dart' as sdk;

final api.TracerProvider _noopTracerProvider = sdk.TracerProvider();
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
FutureOr<R> trace<R>(String name, FutureOr<R> Function() fn, api.Tracer tracer,
    {api.Context context}) async {
  context ??= api.Context.current;

  final span = tracer.startSpan(name, context: context);
  try {
    var result = context.withSpan(span).execute(fn);
    if (result is Future) {
      // Operation must be awaited here to ensure the catch block intercepts
      // errors thrown by [fn].
      result = await result;
    }
    return result;
  } catch (e, s) {
    span.recordException(e, stackTrace: s);
    rethrow;
  } finally {
    span.end();
  }
}
