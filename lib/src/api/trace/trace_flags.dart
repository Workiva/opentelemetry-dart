/// A class which controls tracing flags for sampling, trace level, and so forth.
/// See https://www.w3.org/TR/trace-context/#trace-flags for full specification.
abstract class TraceFlags {
  static const int none = 0x0;
  static const int sampled = 0x1 << 0;
}
