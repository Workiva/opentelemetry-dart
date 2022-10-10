import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_shared_state.dart';

String instrumentationScopeId(InstrumentationScope instrumentationScope) {
  return "${instrumentationScope.name}:${instrumentationScope.version ?? ''}:${instrumentationScope.schemaUrl ?? ''}";
}

class MeterProviderSharedState {
  Resource resource;
  // var viewRegistry = new ViewRegistry ( ) ;
  // List < MetricCollector > metricCollectors = [ ] ;
  Map<String, MeterSharedState> meterSharedStates = {};

  MeterProviderSharedState(this.resource);

  MeterSharedState getMeterSharedState(
      InstrumentationScope instrumentationScope) {
    final id = instrumentationScopeId(instrumentationScope);
    var meterSharedState = meterSharedStates[id];
    if (meterSharedState == null) {
      meterSharedState = MeterSharedState(this, instrumentationScope);
      meterSharedStates[id] = meterSharedState;
    }
    return meterSharedState;
  }

  void selectAggregations(InstrumentType instrumentType) {
    // const result: [MetricCollectorHandle, Aggregation][] = [];
    // for (const collector of this.metricCollectors) {
    //   result.push([collector, collector.selectAggregation(instrumentType)]);
    // }
    // return result;
  }
}
