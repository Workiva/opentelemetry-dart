/// A class which controls tracing flags for sampling, trace level, and so forth.
/// See https://www.w3.org/TR/trace-context/#trace-flags for full specification.
abstract class TraceFlags {
  static const int size = 2;
  static const int none = 0x00;
  static const int sampledFlag = 0x01;
  static const int invalid = 0xff;
}
