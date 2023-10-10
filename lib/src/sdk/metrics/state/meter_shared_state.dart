// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

import 'meter_provider_shared_state.dart';

class MeterSharedState {
  // ignore: unused_field
  final MeterProviderSharedState _meterProviderSharedState;
  // ignore: unused_field
  final InstrumentationScope _instrumentationScope;
  late sdk.Meter meter;

  MeterSharedState(this._meterProviderSharedState, this._instrumentationScope) {
    meter = sdk.Meter(this);
  }
}
