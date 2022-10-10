import 'dart:collection';

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/common/hr_time.dart';

/// Internal interface. Stores measurements and allows synchronous writes of
/// measurements.
/// An interface representing SyncMetricStorage with type parameters removed.
abstract class WritableMetricStorage {
  // Records a measurement.
  void record(num value, List<Attribute> attributes, Context context,
      HrTime recordTime);
}

/// Internal interface. Stores measurements and allows asynchronous writes of
/// measurements.
/// An interface representing AsyncMetricStorage with type parameters removed.
abstract class AsyncWritableMetricStorage {
  // Records a batch of measurements.
  void record(HashMap<Attribute, num> measurements, HrTime observationTime);
}
