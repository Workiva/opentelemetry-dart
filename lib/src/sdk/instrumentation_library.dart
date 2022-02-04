import '../../api.dart' as api;

// Represents the instrumentation library.
class InstrumentationLibrary implements api.InstrumentationLibrary {
  final String _name;
  final String _version;

  InstrumentationLibrary(this._name, this._version);

  @override
  String get name => _name;

  @override
  String get version => _version;
}
