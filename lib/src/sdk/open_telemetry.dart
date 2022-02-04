import '../../api.dart' as api;
import '../../sdk.dart' as sdk;

final api.TracerProvider _noopTracerProvider = sdk.TracerProvider();
api.TracerProvider _tracerProvider = _noopTracerProvider;

void registerGlobalTracerProvider(api.TracerProvider tracerProvider) {
  if (_tracerProvider != _noopTracerProvider) {
    throw StateError('A global TracerProvider has already been created. '
        'registerGlobalTracerProvider must be called only once before any '
        'calls to getter globalTracerProvider.');
  }

  _tracerProvider = tracerProvider;
}

api.TracerProvider get globalTracerProvider => _tracerProvider;
