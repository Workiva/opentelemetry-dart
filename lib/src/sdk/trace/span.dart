import 'package:opentelemetry/src/api/trace/span.dart' as span_api;
import 'package:opentelemetry/src/api/trace/span_context.dart';
import 'package:opentelemetry/src/api/trace/span_status.dart';

/// A representation of a single operation within a trace.
class Span implements span_api.Span {
  int _startTime;
  int _endTime;
  final String _name;
  final String _parentSpanId;
  final SpanContext _spanContext;
  final SpanStatus _status = SpanStatus();

  /// Construct a [Span].
  Span(this._name, this._spanContext, this._parentSpanId) {
    _startTime = DateTime.now().toUtc().microsecondsSinceEpoch;
    print(
        '--- $_name START $_startTime ---\ntraceId: ${_spanContext.traceId}\nparent: $_parentSpanId\nspanId: ${_spanContext.spanId}');
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
    print(
        '--- $_name END $_endTime ---\ntraceId: ${_spanContext.traceId}\nparent: $_parentSpanId\nspanId: ${_spanContext.spanId}');
  }

  @override
  void setStatus(StatusCode status, {String description}) {
    // A status cannot be Unset after being set, and cannot be set to any other
    // status after being marked "Ok".
    if (status == StatusCode.UNSET || _status.code == StatusCode.OK) {
      return;
    }

    _status.code = status;

    // Description is ignored for statuses other than "Error".
    if (status == StatusCode.ERROR && description != null) {
      _status.description = description;
    }
  }

  @override
  SpanStatus get status => _status;
}
