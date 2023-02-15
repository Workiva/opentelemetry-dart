// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_shared_state.dart';
import 'package:quiver/core.dart';

int instrumentationScopeId(InstrumentationScope instrumentationScope) {
  return hash3(instrumentationScope.name, instrumentationScope.version,
      instrumentationScope.schemaUrl);
}

class MeterProviderSharedState {
  Resource? resource;
  final Map<int, MeterSharedState> _meterSharedStates = {};

  MeterProviderSharedState(this.resource);

  MeterSharedState getMeterSharedState(
      InstrumentationScope instrumentationScope) {
    final id = instrumentationScopeId(instrumentationScope);
    var meterSharedState = _meterSharedStates[id];
    if (meterSharedState == null) {
      meterSharedState = MeterSharedState(this, instrumentationScope);
      _meterSharedStates[id] = meterSharedState;
    }
    return meterSharedState;
  }
}
