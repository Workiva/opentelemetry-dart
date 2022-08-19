/// Options needed for metric creation. Pattern borrowed from opentelemetry-js
abstract class MetricOptions {
  /// Sets the description. See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-description
  void setDescription(String description);

  /// Sets the units. See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-unit
  void setUnits(String units);
}
