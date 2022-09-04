import 'package:opentelemetry/api.dart';

/// A no-op instance of a [Meter]]
class NoopMeter implements Meter {
  static final _noopCounter = NoopCounter<int>();

  @override
  Counter createCounter<t>(String name, {MetricOptions options}) {
    return _noopCounter;
  }
}
