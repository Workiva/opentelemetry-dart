import '../../../api.dart' as api;
import 'span_id.dart';
import 'trace_flags.dart';
import 'trace_id.dart';
import 'trace_state.dart';

/// Representation of the context of the context of an individual span.
class SpanContext implements api.SpanContext {
  final SpanId _spanId;
  final TraceId _traceId;
  final TraceFlags _traceFlags;
  final TraceState _traceState;

  @override
  TraceId get traceId => _traceId;

  @override
  SpanId get spanId => _spanId;

  @override
  TraceFlags get traceFlags => _traceFlags;

  @override
  TraceState get traceState => _traceState;

  @override
  bool get isValid => spanId.isValid && traceId.isValid;

  /// Construct a [SpanContext].
  SpanContext(this._traceId, this._spanId, this._traceFlags, this._traceState);

  factory SpanContext.invalid() => SpanContext(TraceId.invalid(),
      SpanId.invalid(), TraceFlags.invalid(), TraceState.empty());
}
