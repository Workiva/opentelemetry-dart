import 'package:opentelemetry/api.dart';

/// A noop registry for creating named [Meter]s.
class NoopMeterProvider implements MeterProvider {
  static final _noopMeter = NoopMeter();

  @override
  Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}}) {
    return _noopMeter;
  }
}
