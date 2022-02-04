import 'span_id.dart';
import 'trace_id.dart';
import 'trace_state.dart';

/// Representation of the context of the context of an individual span.
abstract class SpanContext {
  /// Get the ID of the span.
  SpanId get spanId;

  /// Get the ID of the trace the span is a part of.
  TraceId get traceId;

  /// Get W3C trace context flags used in propagation represented by a one byte bitmap.
  int get traceFlags;

  /// Get the state of the entire trace.
  TraceState get traceState;

  bool get isValid;

  /// Whether this SpanContext represents an operation which originated
  /// from a remote source.
  bool get isRemote;
}
