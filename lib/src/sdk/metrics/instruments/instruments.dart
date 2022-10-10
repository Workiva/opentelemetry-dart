import 'package:logging/logging.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/common/attribute.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
// import 'package:opentelemetry/src/sdk/metrics/instruments/sync_instrument.dart';
import 'package:opentelemetry/src/sdk/metrics/state/writable_metric_storage.dart';

import '../../../experimental_api.dart';

class SyncInstrument {
  final _writableMetricStorage;
  final _descriptor;

  SyncInstrument(this._writableMetricStorage, this._descriptor);
  void _record(num value, {List<Attribute> attributes, Context context}) {}
}

class CounterInstrument<T extends num> extends SyncInstrument
    implements Counter<T> {
  final _logger =
      Logger('opentelemetry.sdk.metrics.instruments.counterinstrument');

  CounterInstrument(
      WritableMetricStorage metricStorage, InstrumentDescriptor descriptor)
      : super(metricStorage, descriptor);

  @override
  void add(num value, {List<Attribute> attributes, Context context}) {
    if (value < 0) {
      _logger.warning(
          'negative value provided to counter ${_descriptor.name}: $value',
          '',
          StackTrace.current);
      return;
    }

    _record(value, attributes: attributes, context: context);
  }
}
