import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/common/hr_time.dart';
import 'package:opentelemetry/src/sdk/metrics/state/writable_metric_storage.dart';

/// This class acts as a container for a collection of WritableMetricStorage instances
class MultiMetricStorage implements WritableMetricStorage {
  final List<WritableMetricStorage> _backingStorages = [];

  // Records a measurement.
  @override
  void record(num value, List<Attribute> attributes, Context context,
      HrTime recordTime) {
        for (final storage in _backingStorages) {
      storage.record(value, attributes, context, recordTime);
    }
  }
}
