/// Common OpenTelemetry attribute keys for resource information.
///
/// Keys should follow OpenTelemetry's attribute semantic conventions:
/// https://github.com/open-telemetry/opentelemetry-specification/tree/main/specification/resource/semantic_conventions
class ResourceAttributes {
  /// Logical name of the service.
  static const String serviceName = 'service.name';

  /// A namespace for `service.name`.
  static const String serviceNamespace = 'service.namespace';

  /// The string ID of the service instance.
  static const String serviceInstanceId = 'service.instance.id';

  /// The version string of the service API or implementation.
  static const String serviceVersion = 'service.version';
}
