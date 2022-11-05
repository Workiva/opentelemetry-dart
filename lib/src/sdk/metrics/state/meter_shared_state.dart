import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class MeterSharedState {
  // ignore: unused_field
  final sdk.MeterProviderSharedState _meterProviderSharedState;
  // ignore: unused_field
  final InstrumentationScope _instrumentationScope;
  sdk.Meter meter;

  MeterSharedState(this._meterProviderSharedState, this._instrumentationScope) {
    meter = sdk.Meter(this);
  }
}
