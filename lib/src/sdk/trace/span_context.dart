import '../../../src/api/trace/span_context.dart' as span_context_api;
import '../../../src/api/trace/trace_state.dart';

/// Representation of the context of the context of an individual span.
class SpanContext implements span_context_api.SpanContext {
  final List<int> _spanId;
  final List<int> _traceId;
  final TraceState _traceState;

  @override
  List<int> get spanId => _spanId;

  @override
  List<int> get traceId => _traceId;

  @override
  TraceState get traceState => _traceState;

  /// Construct a [SpanContext].
  SpanContext(this._traceId, this._spanId, this._traceState);
}
