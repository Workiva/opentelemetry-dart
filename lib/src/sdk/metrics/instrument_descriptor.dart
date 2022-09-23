enum ValueType {
  INT,
  DOUBLE,
}

enum InstrumentType {
  COUNTER,
  HISTOGRAM,
  UP_DOWN_COUNTER,
  OBSERVABLE_COUNTER,
  OBSERVABLE_GAUGE,
  OBSERVABLE_UP_DOWN_COUNTER
}

class InstrumentDescriptor {
  String name;
  String description;
  String unit;
  InstrumentType type;
  ValueType valueType;
}
