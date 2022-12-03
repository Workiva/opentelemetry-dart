import 'package:opentelemetry/api.dart' as api;

class InstrumentationScope {
  final String _name;
  final String _version;
  final String _schemaUrl;
  final List<api.Attribute> _attributes;

  InstrumentationScope(
      this._name, this._version, this._schemaUrl, this._attributes);

  String get name {
    return _name;
  }

  String get version {
    return _version;
  }

  String get schemaUrl {
    return _schemaUrl;
  }

  List<api.Attribute> get attributes {
    return _attributes;
  }
}
