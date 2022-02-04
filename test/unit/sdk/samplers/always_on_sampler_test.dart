import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('Context contains a Span', () {
    final traceId = sdk.TraceId([1, 2, 3]);
    final traceState = sdk.TraceState.fromString('test=onetwo');
    final testSpan = sdk.Span(
        'foo',
        sdk.SpanContext(
            traceId, sdk.SpanId([7, 8, 9]), api.TraceFlags.none, traceState),
        sdk.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'always_on_sampler_test', 'sampler_test_version'));
    final testContext = api.Context.current.withSpan(testSpan);

    final result = sdk.AlwaysOnSampler().shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(api.Decision.recordAndSample));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState, same(traceState));
  });
  test('Context does not contain a Span', () {
    final traceId = sdk.TraceId([1, 2, 3]);
    final testSpan = sdk.Span(
        'foo',
        sdk.SpanContext(traceId, sdk.SpanId([7, 8, 9]), api.TraceFlags.none,
            sdk.TraceState.empty()),
        sdk.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'always_on_sampler_test', 'sampler_test_version'));

    final result = sdk.AlwaysOnSampler().shouldSample(
        api.Context.root, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(api.Decision.recordAndSample));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState.isEmpty, isTrue);
  });
}
