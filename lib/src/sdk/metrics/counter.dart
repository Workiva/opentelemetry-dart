import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_api.dart' as api;

class Counter<T extends num> implements api.Counter<T> {
  @override
  void add(T value, {List<api.Attribute>? attributes, api.Context? context}) {
    // ignore: todo
    // TODO: implement add https://github.com/Workiva/opentelemetry-dart/issues/75
  }
}
