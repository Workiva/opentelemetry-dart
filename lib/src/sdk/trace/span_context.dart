import '../../../src/api/trace/span_context.dart' as span_context_api;
import '../../../src/api/trace/trace_state.dart';

/// Representation of the context of the context of an individual span.
class SpanContext implements span_context_api.SpanContext {
  final String _spanId;
  final String _traceId;
  final TraceState _traceState;

  @override
  String get spanId => _spanId;

  @override
  String get traceId => _traceId;

  @override
  TraceState get traceState => _traceState;

  /// Construct a [SpanContext].
  SpanContext(this._traceId, this._spanId, this._traceState);
}
