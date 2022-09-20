enum InstrumentType { counter }
enum ValueType { int, double }

class InstrumentDescriptor {
  String name;
  String description;
  String unit;
  InstrumentType instrumentType;
  ValueType valuetype;

  InstrumentDescriptor(this.name, this.description,
      {this.unit, this.instrumentType, this.valuetype});
}
