import '../../sdk.dart';

final TracerProvider _noopTracerProvider = TracerProvider();
TracerProvider _tracerProvider = _noopTracerProvider;

void registerGlobalTracerProvider(TracerProvider tracerProvider) {
  if (_tracerProvider != _noopTracerProvider) {
    throw StateError('A global TracerProvider has already been created. '
        'registerGlobalTracerProvider must be called only once before any '
        'calls to getter globalTracerProvider.');
  }

  _tracerProvider = tracerProvider;
}

TracerProvider get globalTracerProvider => _tracerProvider;
