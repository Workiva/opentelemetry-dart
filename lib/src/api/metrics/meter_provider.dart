import 'package:opentelemetry/api.dart';

/// A registry for creating named {@link Meter}s.
///
/// <p>The name <i>Provider</i> is for consistency with other languages and it is <b>NOT</b> loaded
/// using reflection.
///
/// @see Meter
/// @since 1.10.0
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
      List attributes = const []});

  /// Creates a MeterBuilder for a named Meter instance.
  ///
  /// @param instrumentationScopeName A name uniquely identifying the instrumentation scope, such as
  ///     the instrumentation library, package, or fully qualified class name. Must not be null.
  /// @return a MeterBuilder instance.
  MeterBuilder meterBuilder(String instrumentationScopeName);

  /// Returns a no-op {@link MeterProvider} which provides meters which do not record or emit. */
  static MeterProvider noop() {
    return NoopMeterProvider();
  }
}

class NoopMeterProvider implements MeterProvider {
  final Meter _meter = NoopMeter();

  @override
  Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      List attributes = const []}) {
    return _meter;
  }

  @override
  MeterBuilder meterBuilder(String instrumentationScopeName) {
    return null;
  }
}

class NoopMeter implements Meter {}

class NoopMeterBuilder implements MeterBuilder {
  final Meter _meter = NoopMeter();
  @override
  Meter build() {
    return _meter;
  }

  @override
  void setInstrumentationVersion(String instrumentationVersion) {}

  @override
  void setSchemaUrl(String schemaUrl) {}
}
