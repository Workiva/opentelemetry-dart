class InstrumentationScope {
  final String _name;
  final String _version;
  final String _schemaUrl;

  InstrumentationScope(this._name, this._version, this._schemaUrl);

  String get name {
    return _name;
  }

  String get version {
    return _version;
  }

  String get schemaUrl {
    return _schemaUrl;
  }
}
