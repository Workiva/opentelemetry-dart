import 'package:opentelemetry/api.dart';

/// Builder class for creating {@link Meter} instances.
///
/// @since 1.10.0
abstract class MeterBuilder {
  /// Assigns an OpenTelemetry schema URL to the resulting Meter.
  ///
  /// @param schemaUrl The URL of the OpenTelemetry schema being used by this instrumentation scope.
  /// @return this
  void setSchemaUrl(String schemaUrl);

  /// Assigns a version to the instrumentation scope that is using the resulting Meter.
  ///
  /// @param instrumentationScopeVersion The version of the instrumentation scope.
  /// @return this
  void setInstrumentationVersion(String instrumentationScopeVersion);

  /// Gets or creates a {@link Meter} instance.
  ///
  /// @return a {@link Meter} instance configured with the provided options.
  Meter build();
}
