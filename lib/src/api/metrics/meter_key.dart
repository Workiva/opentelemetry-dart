import 'package:collection/collection.dart';
import 'package:quiver/core.dart';
import 'package:opentelemetry/api.dart';

/// A class that acts as a unique key for a given Meter configuration.
class MeterKey {
  final String name;
  final String version;
  final String schemaUrl;
  final List<Attribute> attributes;

  MeterKey(this.name, this.version, this.schemaUrl, this.attributes);

  @override
  bool operator ==(Object other) =>
      other is MeterKey &&
      name == other.name &&
      version == other.version &&
      schemaUrl == other.schemaUrl &&
      const ListEquality().equals(attributes, other.attributes);

  @override
  int get hashCode => hash4(name, version, schemaUrl, attributes);
}
