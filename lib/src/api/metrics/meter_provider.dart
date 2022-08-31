import 'package:opentelemetry/api.dart';

/// A registry for creating named [Meter]s.
///
/// <p>The name <i>Provider</i> is for consistency with other languages and it is <b>NOT</b> loaded
/// using reflection.
abstract class MeterProvider {
  ///
  /// Gets or creates a named [Meter] instance.
  ///
  ///  @param instrumentationScopeName A name uniquely identifying the instrumentation scope, such as
  ///      the instrumentation library, package, or fully qualified class name. Must not be null.
  /// @return a Meter instance.
  Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}});
}
