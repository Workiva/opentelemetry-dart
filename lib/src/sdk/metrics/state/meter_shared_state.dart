import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_provider_shared_state.dart';
import 'package:opentelemetry/src/sdk/metrics/state/writable_metric_storage.dart';

import '../../../experimental_sdk.dart';
import 'MetricStorageRegistry.dart';

class MeterSharedState {
  final metricStorageRegistry = MetricStorageRegistry();
  //final observableRegistry = new ObservableRegistry();
  final MeterProviderSharedState _meterProviderSharedState;
  final InstrumentationScope _instrumentationScope;
  Meter meter;

  MeterSharedState(this._meterProviderSharedState, this._instrumentationScope) {
    meter = Meter(this);
  }

  WritableMetricStorage registerMetricStorage(InstrumentDescriptor descriptor) {
    // const storages = this._registerMetricStorage(descriptor, SyncMetricStorage);

    // if (storages.length === 1)  {
    //   return storages[0];
    // }
    // return new MultiMetricStorage(storages);
  }
}
