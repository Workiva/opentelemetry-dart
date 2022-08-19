import 'package:opentelemetry/api.dart';

/// A registry for creating named [Meter]s.
abstract class MeterProvider {
  ///
  /// Gets or creates a named [Meter] instance.
  ///
  /// [instrumentationScopeName] A name uniquely identifying the instrumentation scope, such as
  /// the instrumentation library, package, or fully qualified class name. Must not be null.
  /// Please see https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/glossary.md#instrumentation-scope for more details
  /// [instrumentationVersion] A version associated with the [instrumentationScopeName]
  /// [schemaUrl] The URL of the OpenTelemetry schema being used by this instrumentation library.
  /// [attributes] Specifies the instrumentation scope attributes to associate with emitted telemetry.
  Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}});
}
