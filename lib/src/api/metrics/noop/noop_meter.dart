import 'package:opentelemetry/api.dart';

class NoopMeter implements Meter {
  static final _noopCounter = NoopCounter<int>();

  @override
  Counter createCounter<t>(String name, MetricOptions options) {
    return _noopCounter;
  }
}
