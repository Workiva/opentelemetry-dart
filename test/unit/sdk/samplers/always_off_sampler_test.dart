import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/sampling_result.dart';
import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('Context contains a Span', () {
    final traceId = TraceId([1, 2, 3]);
    final traceState = TraceState.fromString('test=onetwo');
    final testSpan = Span(
        'foo',
        SpanContext(traceId, SpanId([7, 8, 9]), TraceFlags(api.TraceFlags.none),
            traceState),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary(
            'always_off_sampler_test', 'sampler_test_version'));
    final testContext = Context.current.withSpan(testSpan);

    final result = AlwaysOffSampler().shouldSample(
        testContext, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.drop));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState, same(traceState));
  });
  test('Context does not contain a Span', () {
    final traceId = TraceId([1, 2, 3]);
    final testSpan = Span(
        'foo',
        SpanContext(traceId, SpanId([7, 8, 9]), TraceFlags(api.TraceFlags.none),
            TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary(
            'always_off_sampler_test', 'sampler_test_version'));

    final result = AlwaysOffSampler().shouldSample(
        Context.root, traceId, testSpan.name, false, testSpan.attributes);

    expect(result.decision, equals(Decision.drop));
    expect(result.spanAttributes, same(testSpan.attributes));
    expect(result.traceState.isEmpty, isTrue);
  });
}
