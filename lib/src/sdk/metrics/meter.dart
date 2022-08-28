import 'package:opentelemetry/api.dart' as api;

class Meter implements api.Meter {
  @override
  api.Counter createCounter<t>(String name, api.MetricOptions options) {
    return api.Counter();
  }
}
