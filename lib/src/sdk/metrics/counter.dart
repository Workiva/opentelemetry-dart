import 'package:opentelemetry/api.dart' as api;

class Counter<t> implements api.Counter {
  @override
  void add(dynamic value,
      {List<api.Attribute> attributes, api.Context context}) {
    // TODO: implement add https://github.com/Workiva/opentelemetry-dart/issues/75
  }
}
