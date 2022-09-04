import 'package:opentelemetry/api.dart';

abstract class Meter {
  /// Creates a new [Counter] metric. Generally, this kind of metric is used
  /// when the value is a quantity, the sum is of primary interest, and the
  /// event count and value distribution are not of primary interest.
  ///
  /// [name] The name of the [Counter] See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-naming-rule"
  /// [options] Options needed for metric creation. Pattern borrowed from
  /// opentelemetry-js. This is optional.
  ///
  Counter createCounter<t>(String name, {MetricOptions options});
}
