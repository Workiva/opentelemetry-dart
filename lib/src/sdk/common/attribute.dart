import '../../api/common/attribute.dart' as api;

class Attribute implements api.Attribute {
  @override
  final String key;
  @override
  final Object value;

  Attribute.fromString(this.key, String this.value);

  // ignore: avoid_positional_boolean_parameters
  Attribute.fromBoolean(this.key, bool this.value);

  Attribute.fromDouble(this.key, double this.value);

  Attribute.fromInt(this.key, int this.value);

  Attribute.fromStringList(this.key, List<String> this.value);

  Attribute.fromBooleanList(this.key, List<bool> this.value);

  Attribute.fromDoubleList(this.key, List<double> this.value);

  Attribute.fromIntList(this.key, List<int> this.value);
}
