import '../../../sdk.dart' as sdk;

class Resource {
  final sdk.Attributes _attributes;

  Resource(this._attributes);

  sdk.Attributes get attributes => _attributes;
}
