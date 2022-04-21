import '../../../api.dart' as api;
import '../common/attributes.dart';

class Resource {
  final Attributes _attributes = Attributes.empty();

  Resource(List<api.Attribute> attributes) {
    for (final attribute in attributes) {
      if (attribute.value is! String) {
        throw ArgumentError('Attributes value must be String.');
      }
    }
    _attributes.addAll(attributes);
  }

  Attributes get attributes => _attributes;
}
