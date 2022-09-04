import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:logging/logging.dart';

class MeterProvider implements api.MeterProvider {
  final _meters = <String, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');

  @override
  sdk.Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      Map<String, String> attributes = const {}}) {
    if (instrumentationScopeName == null || instrumentationScopeName == '') {
      instrumentationScopeName = '';
      //throw and catch Argument error so that we capture a stacktrace,
      //identifying the caller
      try {
        throw ArgumentError(sdk.invalidMeterNameMessage);
      } catch (e, stacktrace) {
        _logger.warning(sdk.invalidMeterNameMessage, e, stacktrace);
      }
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
