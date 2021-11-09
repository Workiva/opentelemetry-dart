import 'package:opentelemetry/sdk.dart';

class OpenTelemetrySdk {
  static final OpenTelemetrySdk _globalOpenTelemetry =
      OpenTelemetrySdk._global();
  TracerProvider _tracerProvider;

  OpenTelemetrySdk._global();

  /// Returns a new [OpenTelemetrySdk] and registers it as the global
  /// [OpenTelemetrySdk]. Future calls to getter globalOpenTelemetry will return
  /// the registered [OpenTelemetrySdk] instance.
  ///
  /// This should be called once as early as possible in your application
  /// initialization logic.  A [StateError] will be thrown if this method is
  /// attempted to be called multiple times in the lifecycle of an
  /// application - ensure you have only one for use as the global instance.
  factory OpenTelemetrySdk.global(TracerProvider tracerProvider) {
    if (_globalOpenTelemetry._tracerProvider != null) {
      throw StateError(
          'A global instance of OpenTelemetry has already been created. '
          'OpenTelemetry.global must be called only once before any calls '
          'to getter globalOpenTelemetry.');
    }

    _globalOpenTelemetry._tracerProvider = tracerProvider;

    return _globalOpenTelemetry;
  }

  OpenTelemetrySdk(this._tracerProvider);

  static OpenTelemetrySdk get globalOpenTelemetry => _globalOpenTelemetry;
  TracerProvider get tracerProvider => _tracerProvider;
}
