import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/api/metrics/meter_key.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_provider_shared_state.dart';
import 'package:opentelemetry/src/sdk/metrics/view/view.dart';

const invalidMeterNameMessage = 'Invalid Meter Name';

class MeterProvider implements api.MeterProvider {
  final _meters = <MeterKey, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');
  Resource _resource;
  MeterProviderSharedState _sharedState;

  MeterProvider({Resource resource, List<View> views}) {
    _resource = resource;
    _sharedState = MeterProviderSharedState(resource ?? Resource.empty());
    // if(options?.views != null && options.views.length > 0){
    //   for(const view of options.views){
    //     this._sharedState.viewRegistry.addView(view);
    //   }
    // }
  }

  @override
  sdk.Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    if (name == null || name == '') {
      name = '';
      _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    }
    version ??= '';
    schemaUrl ??= '';
    attributes ??= const [];
    final key = MeterKey(name, version, schemaUrl, attributes);

    return _meters.putIfAbsent(key, () => sdk.Meter());
  }
}
