class InstrumentationLibrary {
  final String name;
  final String version;

  InstrumentationLibrary(this.name, {String version}) : version = version ?? '*';
}
