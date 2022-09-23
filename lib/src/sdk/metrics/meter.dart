import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/sdk/metrics/meter_shared_state.dart';

import 'instruments/counter_instrument.dart';

class Meter implements api.Meter {
  /// Inspiration: https://github.com/open-telemetry/opentelemetry-js/blob/6807deff5a966aadbf5404f3e32564b07205d611/experimental/packages/opentelemetry-sdk-metrics/src/Meter.ts#L47

  final _state = MeterSharedState();

  @override
  api.Counter<T> createCounter<T extends num>(String name,
      {String description, String unit}) {
    final valueType = T is int ? ValueType.int : ValueType.double;
    final descriptor = InstrumentDescriptor(name, description,
        unit: unit,
        instrumentType: InstrumentType.counter,
        valuetype: valueType);  
     final storage = _state.registerMetricStorage(descriptor);
    return CounterInstrument<T>(storage, descriptor);

    //return sdk.Counter<T>(name, description: description, units: unit);
  }
}
