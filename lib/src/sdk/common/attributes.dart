import 'package:opentelemetry/src/api/common/attribute.dart';
import 'package:opentelemetry/src/api/common/attributes.dart' as api;

class Attributes implements api.Attributes {
  Map<String, Object> _attributes = {};

  Attributes.empty() {
    _attributes = {};
  }

  @override
  int get length => _attributes.length;

  @override
  bool get isEmpty => _attributes.isEmpty;

  @override
  void add(Attribute attribute) {
    _attributes[attribute.key] = attribute.value;
  }

  @override
  void addAll(List<Attribute> attributes) {
    attributes.forEach(add);
  }

  @override
  Object get(String key) => _attributes[key];
}
