import '../../../api.dart' as api;

class Resource implements api.Resource {
  final api.Attributes _attributes;

  Resource(this._attributes);

  @override
  api.Attributes get attributes => _attributes;
}
