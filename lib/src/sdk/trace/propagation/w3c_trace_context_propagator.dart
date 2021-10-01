import '../../../../api.dart' as api;
import '../../../api/trace/nonrecording_span.dart';
import '../span_context.dart';
import '../span_id.dart';
import '../trace_flags.dart';
import '../trace_id.dart';
import '../trace_state.dart';

class W3CTraceContextPropagator implements api.TextMapPropagator {
  static const String _TRACE_VERSION = '00';
  static const String _TRACE_PARENT_HEADER_KEY = 'traceparent';
  static const String _TRACE_STATE_HEADER_KEY = 'tracestate';
  // See https://www.w3.org/TR/trace-context/#traceparent-header-field-values
  // for trace parent header specification.
  static final RegExp traceParentHeaderRegEx =
      RegExp('^(?<version>[0-9a-f]{2})-'
          '(?<traceid>[0-9a-f]{${api.TraceId.SIZE_BITS}})-'
          '(?<parentid>[0-9a-f]{${api.SpanId.SIZE_BITS}})-'
          '(?<traceflags>[0-9a-f]{${api.TraceFlags.SIZE}})\$');

  @override
  api.Context extract(
      api.Context context, dynamic carrier, api.TextMapGetter getter) {
    final traceParentHeader = getter.get(carrier, _TRACE_PARENT_HEADER_KEY);
    if (traceParentHeader == null) {
      // Carrier did not contain a trace header.  Do nothing.
      return context;
    }
    if (!traceParentHeaderRegEx.hasMatch(traceParentHeader)) {
      // Encountered a malformed or unknown trace header.  Do nothing.
      return context;
    }

    final parentHeaderMatch =
        traceParentHeaderRegEx.firstMatch(traceParentHeader);
    final parentHeaderFields = Map<String, String>.fromIterable(
        parentHeaderMatch.groupNames,
        key: (element) => element.toString(),
        value: (element) => parentHeaderMatch.namedGroup(element));

    final TraceId traceId = TraceId.fromString(parentHeaderFields['traceid']) ??
        api.TraceId.INVALID;
    final SpanId parentId =
        SpanId.fromString(parentHeaderFields['parentid']) ?? api.SpanId.INVALID;
    final TraceFlags traceFlags =
        TraceFlags.fromString(parentHeaderFields['traceflags']) ??
            api.TraceFlags.NONE;

    final traceStateHeader = getter.get(carrier, _TRACE_STATE_HEADER_KEY);
    final traceState = (traceStateHeader != null)
        ? TraceState.fromString(traceStateHeader)
        : TraceState.empty();

    return context.withSpan(NonRecordingSpan(
        SpanContext(traceId, parentId, traceFlags, traceState)));
  }

  @override
  void inject(api.Context context, dynamic carrier, api.TextMapSetter setter) {
    final spanContext = context.getSpanContext();

    setter
      ..set(carrier, _TRACE_PARENT_HEADER_KEY,
          '$_TRACE_VERSION-${spanContext.traceId.toString()}-${spanContext.spanId.toString()}-${spanContext.traceFlags.toString()}')
      ..set(
          carrier, _TRACE_STATE_HEADER_KEY, spanContext.traceState.toString());
  }
}
