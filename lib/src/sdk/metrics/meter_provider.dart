import 'package:opentelemetry/api.dart' as api;

class MeterProvider implements api.MeterProvider {
  @override
  api.MeterBuilder meterBuilder(String instrumentationScopeName) {
    // TODO: implement meterBuilder
    throw UnimplementedError();
  }

  @override
  api.Meter get(String instrumentationScopeName,
      {String instrumentationVersion = '',
      String schemaUrl = '',
      List attributes = const []}) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
