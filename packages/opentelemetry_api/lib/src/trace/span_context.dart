import 'package:meta/meta.dart';

import 'trace_state.dart';

class SpanContext {
  static SpanContext create(String traceId, String spanId, num traceFlags, TraceState traceState)
    => SpanContext._(traceId, spanId, traceFlags, traceState, isRemote: false);

  static SpanContext createFromRemoteParent(String traceId, String spanId, num traceFlags, TraceState traceState)
    => SpanContext._(traceId, spanId, traceFlags, traceState, isRemote: true);

  final bool isRemote;

  final String spanId;

  final num traceFlags;

  final String traceId;

  final TraceState traceState;

  SpanContext._(this.traceId, this.spanId, this.traceFlags, this.traceState, {@required this.isRemote})
}
