import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;

class Meter implements api.Meter {
  @override
  api.Counter createCounter<t>(String name, {api.MetricOptions options}) {
    return sdk.Counter<t>();
  }
}
