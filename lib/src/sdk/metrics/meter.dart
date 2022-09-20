import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;

class Meter implements api.Meter {
  @override
  api.Counter<T> createCounter<T extends num>(String name,
      {String description, String unit}) {
    final valueType = T is int ? ValueType.int : ValueType.double;
    final descriptor = InstrumentDescriptor(name, description,
        unit: unit,
        instrumentType: InstrumentType.counter,
        valuetype: valueType);
//     const storage = this._meterSharedState.registerMetricStorage(descriptor);
//     return new CounterInstrument(storage, descriptor);

    return sdk.Counter<T>(name, description: description, units: unit);
  }
}
