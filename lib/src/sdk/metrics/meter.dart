import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;

class Meter implements api.Meter {
  @override
  api.Counter<T> createCounter<T extends num>(String name,
      {String description, String units}) {
    return sdk.Counter<T>();
  }
}
