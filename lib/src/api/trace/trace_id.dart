/// Class representing an ID for a single Trace.
/// See https://www.w3.org/TR/trace-context/#trace-id for full specification.
abstract class TraceId {
  static const SIZE_BITS = 32;
  static const SIZE_BYTES = 16;
  static final List<int> INVALID =
      List<int>.filled(SIZE_BYTES, 0); // 00000000000000000000000000000000

  /// Retrieve this TraceId as a list of byte values.
  List<int> get();

  /// Whether this ID represents a valid Trace.
  bool get isValid;

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString();
}
