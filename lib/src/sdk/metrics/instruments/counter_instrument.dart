import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/common/attribute.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/sync_instrument.dart';

import '../../../experimental_api.dart';

class CounterInstrument<T extends num> extends SyncInstrument
    implements Counter<T> {
  CounterInstrument(  InstrumentDescriptor descriptor) : super(null, descriptor);
  
  @override
  void add(num value, {List<Attribute> attributes, Context context}) {
    // TODO: implement add
  }
}
