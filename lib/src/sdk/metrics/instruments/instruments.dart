import 'package:logging/logging.dart';
import 'package:opentelemetry/src/api/common/hr_time.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/common/attribute.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';
// import 'package:opentelemetry/src/sdk/metrics/instruments/sync_instrument.dart';
import 'package:opentelemetry/src/sdk/metrics/state/writable_metric_storage.dart';

import '../../../experimental_api.dart';

class SyncInstrument {
  final _writableMetricStorage;
  final _descriptor;
  final _logger =
      Logger('opentelemetry.sdk.metrics.instruments.syncinstrument');

  SyncInstrument(WritableMetricStorage this._writableMetricStorage,
      InstrumentDescriptor this._descriptor);

  void _record(num value, {List<Attribute> attributes, Context context}) {
    if (_descriptor.valueType == ValueType.int && !(value is int)) {
      _logger.warning(
          'INT value type cannot accept a floating-point value for ${_descriptor.name}, ignoring the fractional digits.',
          '',
          StackTrace.current);

      value = value.truncate();
    }
    _writableMetricStorage.record(value, attributes, context, HrTime());
  }
}

class CounterInstrument<T extends num> extends SyncInstrument
    implements Counter<T> {
  

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
