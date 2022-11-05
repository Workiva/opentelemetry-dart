import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/api/metrics/meter_key.dart';
import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_provider_shared_state.dart';

const invalidMeterNameMessage = 'Invalid Meter Name';

class MeterProvider implements api.MeterProvider {
  final _meters = <MeterKey, api.Meter>{};
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');
  var _shutdown = false;
  final MeterProviderSharedState _sharedState;

  MeterProvider({sdk.Resource resource})
      : _sharedState = MeterProviderSharedState(resource);
    
  
  @override
  api.Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    if (name == null || name == '') {
      name = '';
      _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    }
    

    if (_shutdown) {
      _logger.warning('A shutdown MeterProvider cannot provide a Meter', '',
          StackTrace.current);
      return api.NoopMeter();
    }

    return _sharedState
      .getMeterSharedState(InstrumentationScope(name, version, schemaUrl))
      .meter;

  }

  /// Flush all buffered data and shut down the MeterProvider and all registered
  /// MetricReaders.
  /// Returns a future which is resolved when all flushes are complete.
  async shutdown(options?: ShutdownOptions): Promise<void> {
    if (this._shutdown) {
      api.diag.warn('shutdown may only be called once per MeterProvider');
      return;
    }

    this._shutdown = true;

    await Promise.all(this._sharedState.metricCollectors.map(collector => {
      return collector.shutdown(options);
    }));
  }
}
