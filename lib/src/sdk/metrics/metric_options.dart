import 'package:opentelemetry/api.dart' as api;

class MetricOptions implements api.MetricOptions {
  @override
  void setDescription(String description) {
    // TODO: implement setDescription https://github.com/Workiva/opentelemetry-dart/issues/76
  }

  @override
  void setUnits(String units) {
    // TODO: implement setUnits https://github.com/Workiva/opentelemetry-dart/issues/77
  }
}
