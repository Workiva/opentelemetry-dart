import 'span.dart';

/// Class representing an ID for a single [Span].
/// See https://www.w3.org/TR/trace-context/#parent-id for full specification.
abstract class SpanId {
  static const SIZE_BITS = 16;
  static const SIZE_BYTES = 8;
  static final List<int> INVALID =
      List<int>.filled(SIZE_BYTES, 0); // 0000000000000000
  static final List<int> ROOT = [];

  /// Retrieve this SpanId as a list of byte values.
  List<int> get();

  /// Whether this ID represents a valid [Span].
  bool get isValid;

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString();
}
