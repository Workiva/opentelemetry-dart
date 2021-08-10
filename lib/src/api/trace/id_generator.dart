/// Generator capable of creating OTel compliant IDs.
abstract class IdGenerator {
  /// Generate an ID for a Span.
  String generateSpanId();

  /// Generate an ID for a trace.
  String generateTraceId();
}
