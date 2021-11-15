import '../../api/common/attributes.dart' as attributes_api;
import '../../api/resource/resource.dart' as api;

class Resource implements api.Resource {
  final attributes_api.Attributes _attributes;

  Resource(this._attributes);

  @override
  attributes_api.Attributes get attributes => _attributes;
}
