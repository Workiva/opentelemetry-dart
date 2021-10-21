import 'span.dart';

/// Class representing an ID for a single [Span].
/// See https://www.w3.org/TR/trace-context/#parent-id for full specification.
abstract class SpanId {
  static const sizeBits = 16;
  static const sizeBytes = 8;
  static final List<int> invalid =
      List<int>.filled(sizeBytes, 0); // 0000000000000000
  static final List<int> root = [];

  /// Retrieve this SpanId as a list of byte values.
  List<int> get();

  /// Whether this ID represents a valid [Span].
  bool get isValid;

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString();
}
