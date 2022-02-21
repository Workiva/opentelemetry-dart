import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('spanContext getters', () {
    final spanId = api.SpanId([4, 5, 6]);
    final traceId = api.TraceId([1, 2, 3]);
    const traceFlags = api.TraceFlags.none;
    final traceState = sdk.TraceState.empty();

    final spanContext =
        sdk.SpanContext(traceId, spanId, traceFlags, traceState);

    expect(spanContext.traceId, same(traceId));
    expect(spanContext.spanId, same(spanId));
    expect(spanContext.traceFlags, same(traceFlags));
    expect(spanContext.traceState, same(traceState));
  });
}
