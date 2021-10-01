/// A class which controls tracing flags for sampling, trace level, and so forth.
/// See https://www.w3.org/TR/trace-context/#trace-flags for full specification.
abstract class TraceFlags {
  static const int SIZE = 2;
  static const int NONE = 0x00;
  static const int SAMPLED_FLAG = 0x01;
  static const int INVALID = 0xff;
}
