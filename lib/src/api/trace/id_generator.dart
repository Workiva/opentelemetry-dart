/// Generator capable of creating OTel compliant IDs.
abstract class IdGenerator {
  /// Generate an ID for a Span.
  List<int> generateSpanId();

  /// Generate an ID for a trace.
  List<int> generateTraceId();
}
