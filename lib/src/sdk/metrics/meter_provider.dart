import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/api/metrics/meter_key.dart';

const invalidMeterNameMessage = 'Invalid Meter Name';

class MeterProvider implements api.MeterProvider {
  final _meters = <MeterKey, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');

  @override
  sdk.Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}}) {
    if (name == null || name == '') {
      name = '';
      _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    }
    version ??= '';
    schemaUrl ??= '';
    attributes ??= const {};
    final key = MeterKey(name, version, schemaUrl, attributes);

    return _meters.putIfAbsent(key, () => sdk.Meter());
  }
}
