import 'package:opentelemetry/api.dart' as api;

class SyncInstrument {
  final _writableMetricStorage;
  final _descriptor;

  SyncInstrument(this._writableMetricStorage, this._descriptor);
  void _record(num value,
      {List<api.Attribute> attribute = const [], api.Context context}) {}
}
