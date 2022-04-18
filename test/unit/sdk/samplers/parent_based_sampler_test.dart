import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  final onSampler = sdk.AlwaysOnSampler();
  final offSampler = sdk.AlwaysOffSampler();
  final testSampler = sdk.ParentBasedSampler(onSampler,
      remoteParentSampled: onSampler,
      remoteParentNotSampled: offSampler,
      localParentSampled: onSampler,
      localParentNotSampled: offSampler);
  final traceId = api.TraceId([1, 2, 3]);

  test('Invalid parent span context', () {
    final testSpan = sdk.Span(
        'test',
        sdk.SpanContext.invalid(),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'parent_sampler_test', 'sampler_test_version'));

    final testContext = api.Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(testContext, traceId, testSpan.name,
        api.SpanKind.internal, false, null, []);

    expect(result.decision, equals(api.Decision.recordAndSample));
    expect(result.spanAttributes, equals(null));
    expect(result.traceState.isEmpty, isTrue);
  });

  test('Missing parent span context', () {
    final testSpan = sdk.Span(
        'test',
        sdk.SpanContext.invalid(),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'parent_sampler_test', 'sampler_test_version'));

    final result = testSampler.shouldSample(api.Context.root, traceId,
        testSpan.name, api.SpanKind.internal, false, null, []);

    expect(result.decision, equals(api.Decision.recordAndSample));
    expect(result.spanAttributes, equals(null));
    expect(result.traceState.isEmpty, isTrue);
  });

  test('with sampled, remote sdk.Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final traceState = sdk.TraceState.fromString('test=onetwo');
    final testSpan = sdk.Span(
        'foo',
        sdk.SpanContext.remote(
            traceId, api.SpanId([7, 8, 9]), api.TraceFlags.sampled, traceState),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'parent_sampler_test', 'sampler_test_version'));
    final testContext = api.Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(testContext, traceId, testSpan.name,
        api.SpanKind.internal, false, null, []);

    expect(result.decision, equals(api.Decision.recordAndSample));
    expect(result.spanAttributes, equals(null));
    expect(result.traceState, same(traceState));
  });

  test('with non-sampled, remote sdk.Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final traceState = sdk.TraceState.fromString('test=onetwo');
    final testSpan = sdk.Span(
        'foo',
        sdk.SpanContext.remote(
            traceId, api.SpanId([7, 8, 9]), api.TraceFlags.none, traceState),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'parent_sampler_test', 'sampler_test_version'));
    final testContext = api.Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(testContext, traceId, testSpan.name,
        api.SpanKind.internal, false, [], []);

    expect(result.decision, equals(api.Decision.drop));
    expect(result.spanAttributes, equals([]));
    expect(result.traceState, same(traceState));
  });

  test('with sampled, local sdk.Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final traceState = sdk.TraceState.fromString('test=onetwo');
    final testSpan = sdk.Span(
        'foo',
        sdk.SpanContext(
            traceId, api.SpanId([7, 8, 9]), api.TraceFlags.sampled, traceState),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'parent_sampler_test', 'sampler_test_version'));
    final testContext = api.Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(testContext, traceId, testSpan.name,
        api.SpanKind.internal, false, [], []);

    expect(result.decision, equals(api.Decision.recordAndSample));
    expect(result.spanAttributes, equals([]));
    expect(result.traceState, same(traceState));
  });

  test('with non-sampled, local sdk.Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final traceState = sdk.TraceState.fromString('test=onetwo');
    final testSpan = sdk.Span(
        'foo',
        sdk.SpanContext(
            traceId, api.SpanId([7, 8, 9]), api.TraceFlags.none, traceState),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary(
            'parent_sampler_test', 'sampler_test_version'));
    final testContext = api.Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(testContext, traceId, testSpan.name,
        api.SpanKind.internal, false, [], []);

    expect(result.decision, equals(api.Decision.drop));
    expect(result.spanAttributes, equals([]));
    expect(result.traceState, same(traceState));
  });
}
