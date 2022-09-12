import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/metrics/noop/noop_meter.dart';

/// A noop registry for creating named [Meter]s.
class NoopMeterProvider implements MeterProvider {
  static final _noopMeter = NoopMeter();

  @override
  Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}}) {
    return _noopMeter;
  }
}
