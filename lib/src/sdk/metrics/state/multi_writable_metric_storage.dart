import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/common/hr_time.dart';
import 'package:opentelemetry/src/sdk/metrics/state/writable_metric_storage.dart';

class MultiMetricStorage implements WritableMetricStorage {
  List<WritableMetricStorage> _backingStorages = [];

  // Records a measurement.
  record(num value, List<Attribute> attributes, Context context,
      HrTime recordTime) {
    _backingStorages
        .forEach((it) => it.record(value, attributes, context, recordTime));
  }
}
