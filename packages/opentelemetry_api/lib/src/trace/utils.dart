import 'span_context.dart';

const invalidSpanId = '0000000000000000';
const invalidTraceId = '00000000000000000000000000000000';
const invalidSpanContext = SpanContext.create(
  invalidTraceId,
  invalidSpanId,
  traceFlags: TraceFlags.NONE);

class TraceFlags {
  static const num none = 0x0;
}
