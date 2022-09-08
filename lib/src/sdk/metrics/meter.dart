import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;

class Meter implements api.Meter {
  static const invalidMeterNameMessage = 'Invalid Meter Name';

  @override
  api.Counter createCounter<T>(String name, {api.MetricOptions options}) {
    return sdk.Counter<T>();
  }
}
