import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

class MeterProvider implements api.MeterProvider {
  final _meters = <String, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');

  @visibleForTesting
  static const invalidMeterNameMessage = 'Invalid Meter Name';

  @override
  sdk.Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}}) {
    if (instrumentationScopeName == null || instrumentationScopeName == '') {
      instrumentationScopeName = '';
      _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    }
    final key = instrumentationScopeName +
        instrumentationVersion +
        schemaUrl +
        attributes.toString();

    if (!_meters.containsKey(key)) {
      _meters[key] = sdk.Meter();
    }
    return _meters[key];
  }
}
