// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

/// Common OpenTelemetry attribute keys for resource information.
///
/// Keys should follow OpenTelemetry's attribute semantic conventions:
/// https://github.com/open-telemetry/opentelemetry-specification/tree/main/specification/resource/semantic_conventions
class ResourceAttributes {
  /// Name of the deployment environment or tier.
  static const String deploymentEnvironment = 'deployment.environment';

  /// Logical name of the service.
  static const String serviceName = 'service.name';

  /// A namespace for `service.name`.
  static const String serviceNamespace = 'service.namespace';

  /// The string ID of the service instance.
  static const String serviceInstanceId = 'service.instance.id';

  /// The version string of the service API or implementation.
  static const String serviceVersion = 'service.version';
}
