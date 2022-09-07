import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/metrics/noop/noop_counter.dart';

/// A no-op instance of a [Meter]]
class NoopMeter implements Meter {
  static final _noopCounter = NoopCounter();

  @override
  Counter createCounter<t>(String name, {MetricOptions options}) {
    return _noopCounter;
  }
}
