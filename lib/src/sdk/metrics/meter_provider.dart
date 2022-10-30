import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/api/metrics/meter_key.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_provider_shared_state.dart';

const invalidMeterNameMessage = 'Invalid Meter Name';

class MeterProvider implements api.MeterProvider {
  final _meters = <MeterKey, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');
  var _shutdown = false;
  final MeterProviderSharedState _sharedState;

  MeterProvider({sdk.Resource resource, List<View> views})
      : _sharedState = MeterProviderSharedState(resource) {}

  @override
  api.Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    // if (name == null || name == '') {
    //   name = '';
    //   _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    // }
    // version ??= '';
    // schemaUrl ??= '';
    // attributes ??= const [];
    // final key = MeterKey(name, version, schemaUrl, attributes);

    // return _meters.putIfAbsent(key, sdk.Meter());

    if (_shutdown) {
      _logger.warning('A shutdown MeterProvider cannot provide a Meter', '',
          StackTrace.current);
      return api.NoopMeter();
    }

  }
}
