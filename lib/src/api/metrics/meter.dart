import 'package:opentelemetry/api.dart';

abstract class Meter {
  //
  // Creates a new `Counter` metric. Generally, this kind of metric when the
  // value is a quantity, the sum is of primary interest, and the event count
  // and value distribution are not of primary interest.
  //
  // @see <a
  //     href="https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-naming-rule">Instrument
  //     Naming Rule</a>
  Counter createCounter<t>(String name, MetricOptions options);
}
