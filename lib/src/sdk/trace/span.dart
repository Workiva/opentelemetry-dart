import '../../../src/api/trace/span.dart' as span_api;
import '../../../src/api/trace/span_context.dart';

/// A representation of a single operation within a trace.
class Span implements span_api.Span {
  int _endTime;
  final String _name;
  final String _parentSpanId;
  final SpanContext _spanContext;
  int _startTime;

  /// Construct a [Span].
  Span(
    this._name, 
    this._spanContext, 
    this._parentSpanId
  ) {
    _startTime = DateTime.now().toUtc().microsecondsSinceEpoch;
    print('--- $_name START $_startTime ---\ntraceId: ${_spanContext.traceId}\nparent: $_parentSpanId\nspanId: ${_spanContext.spanId}');
  }

  @override
  SpanContext get spanContext => _spanContext;

    @override
  int get endTime => _endTime;

  @override
  int get startTime => _startTime;

  @override
  void end() {
    _endTime = DateTime.now().toUtc().microsecondsSinceEpoch;
    print('--- $_name END $_endTime ---\ntraceId: ${_spanContext.traceId}\nparent: $_parentSpanId\nspanId: ${_spanContext.spanId}');
  }
}
