import 'package:opentelemetry/src/sdk/common/attributes.dart';

import '../../../api.dart' as api;

class Resource {
  final Attributes _attributes = Attributes.empty();

  Resource(List<api.Attribute> attributes) {
    for (final attribute in attributes) {
      if (attribute.value is! String || attribute.key is! String) {
        throw ArgumentError(
            'Both resource attributes key and value must be String.');
      }
    }
    _attributes.addAll(attributes);
  }

  Attributes get attributes => _attributes;
}
