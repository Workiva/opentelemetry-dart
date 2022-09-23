// import "package:@opentelemetry/api.dart" show HrTime;
// import "../export/MetricData.dart" show MetricData;
// import "../utils.dart" show Maybe;
import 'MetricCollector.dart' show MetricCollectorHandle;
import '../instruments/instrument_descriptor.dart' show InstrumentDescriptor;

/// Represents a storage from which we can collect metrics.
abstract class MetricStorage {
  InstrumentDescriptor _instrumentDescriptor;
  MetricStorage(this._instrumentDescriptor);

  /// Collects the metrics from this storage.
  /// Note: This is a stateful operation and may reset any interval-related
  /// state for the MetricCollector.
  MetricData collect(MetricCollectorHandle collector,
      List<MetricCollectorHandle> collectors, HrTime collectionTime);

  InstrumentDescriptor getInstrumentDescriptor() {
    return _instrumentDescriptor;
  }

  void updateDescription(String description) {
    _instrumentDescriptor = InstrumentDescriptor(
        _instrumentDescriptor.name, description,
        instrumentType: _instrumentDescriptor.instrumentType,
        valuetype: _instrumentDescriptor.valuetype,
        unit: _instrumentDescriptor.unit);
  }
}
