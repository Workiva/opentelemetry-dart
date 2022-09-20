import 'package:logging/logging.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_api.dart' as api;

import 'instruments/sync_instrument.dart';

const invalidCounterValueMessage = 'Invalid Meter Name';

class Counter<T extends num> extends SyncInstrument implements api.Counter<T> {
  final _logger = Logger('opentelemetry.sdk.metrics.counter');

  String name;
  String description;
  String units;

  Counter(this.name, {this.description = '', this.units = ''})
      : super(null, null);

  @override
  void add(T value, {List<api.Attribute> attributes, api.Context context}) {
    if (value < 0) {
      _logger.warning(
          'Counters can only increase. Instrument $name  has recorded a negative value.',
          '',
          StackTrace.current);
      return;
    }
  }
}
