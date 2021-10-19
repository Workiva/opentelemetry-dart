import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/sampling_result.dart';
import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/samplers/parent_based_sampler.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  final onSampler = AlwaysOnSampler();
  final offSampler = AlwaysOffSampler();
  final testSampler = ParentBasedSampler(onSampler,
      remoteParentSampled: onSampler,
      remoteParentNotSampled: offSampler,
      localParentSampled: onSampler,
      localParentNotSampled: offSampler);
  final traceId = TraceId([1, 2, 3]);

  test('Invalid parent span context', () {
    final testSpan = Span(
        'test',
        SpanContext.invalid(),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('parent_sampler_test', 'sampler_test_version'));

    final testContext = Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.recordAndSample));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState.isEmpty, isTrue);
  });

  test('Missing parent span context', () {
    final testSpan = Span(
        'test',
        SpanContext.invalid(),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('parent_sampler_test', 'sampler_test_version'));

    final result = testSampler.shouldSample(
        Context.root, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.recordAndSample));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState.isEmpty, isTrue);
  });

  test('with sampled, remote Span', () {
    final traceId = TraceId([1, 2, 3]);
    final traceState = TraceState.fromString('test=onetwo');
    final testSpan = Span(
        'foo',
        SpanContext.remote(traceId, SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.sampledFlag), traceState),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('parent_sampler_test', 'sampler_test_version'));
    final testContext = Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.recordAndSample));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState, same(traceState));
  });

  test('with non-sampled, remote Span', () {
    final traceId = TraceId([1, 2, 3]);
    final traceState = TraceState.fromString('test=onetwo');
    final testSpan = Span(
        'foo',
        SpanContext.remote(traceId, SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.none), traceState),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('parent_sampler_test', 'sampler_test_version'));
    final testContext = Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.drop));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState, same(traceState));
  });

  test('with sampled, local Span', () {
    final traceId = TraceId([1, 2, 3]);
    final traceState = TraceState.fromString('test=onetwo');
    final testSpan = Span(
        'foo',
        SpanContext(traceId, SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.sampledFlag), traceState),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('parent_sampler_test', 'sampler_test_version'));
    final testContext = Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.recordAndSample));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState, same(traceState));
  });

  test('with non-sampled, local Span', () {
    final traceId = TraceId([1, 2, 3]);
    final traceState = TraceState.fromString('test=onetwo');
    final testSpan = Span(
        'foo',
        SpanContext(traceId, SpanId([7, 8, 9]), TraceFlags(api.TraceFlags.none),
            traceState),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('parent_sampler_test', 'sampler_test_version'));
    final testContext = Context.current.withSpan(testSpan);

    final result = testSampler.shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.drop));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState, same(traceState));
  });
}
