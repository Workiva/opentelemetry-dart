import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_shared_state.dart';
import 'package:quiver/core.dart';

int instrumentationScopeId(InstrumentationScope instrumentationScope) {
  return hash4(
      instrumentationScope.name,
      instrumentationScope.version,
      instrumentationScope.schemaUrl,
      instrumentationScope.attributes.isEmpty
          ? const []
          : instrumentationScope.attributes);
}

class MeterProviderSharedState {
  Resource resource;
  Map<int, MeterSharedState> meterSharedStates = {};

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
}
