import '../../api/common/attribute.dart';
import '../../api/common/attributes.dart' as api;

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
  Object get(String key) => _attributes[key];

  @override
  Iterable<String> get keys => _attributes.keys;

  @override
  void add(Attribute attribute) {
    _attributes[attribute.key] = attribute.value;
  }

  @override
  void addAll(List<Attribute> attributes) {
    attributes.forEach(add);
  }
}
