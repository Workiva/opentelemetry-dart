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
  // Counter createCounter(String name, MetricOptions options);

  // /// Creates a new `UpDownCounter` metric. UpDownCounter is a synchronous
  // /// instrument and very similar to Counter except that Add(increment)
  // /// supports negative increments. It is generally useful for capturing changes
  // /// in an amount of resources used, or any quantity that rises and falls
  // /// during a request.
  // /// Example uses for UpDownCounter:
  // /// <ol>
  // ///   <li> count the number of active requests. </li>
  // ///   <li> count memory in use by instrumenting new and delete. </li>
  // ///   <li> count queue size by instrumenting enqueue and dequeue. </li>
  // ///   <li> count semaphore up and down operations. </li>
  // /// </ol>
  // ///
  // /// @param name the name of the metric.
  // /// @param [options] the metric options.
  // UpDownCounter createUpDownCounter(String name, MetricOptions options);
}
