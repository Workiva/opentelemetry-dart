import 'trace_state.dart';

/// Representation of the context of the context of an individual span.
abstract class SpanContext {
  /// Get the ID of the span.
  List<int> get spanId;

  /// Get the ID of the trace the span is a part of.
  List<int> get traceId;

  /// Get the state of the entire trace.
  TraceState get traceState;
}
