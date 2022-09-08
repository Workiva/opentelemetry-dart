import 'package:opentelemetry/api.dart' as api;

class Counter<T> implements api.Counter<num> {
  @override
  void add(num value, {List<api.Attribute> attributes, api.Context context}) {
    // TODO: implement add https://github.com/Workiva/opentelemetry-dart/issues/75
  }
}
