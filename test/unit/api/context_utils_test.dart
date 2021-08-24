import 'package:mockito/mockito.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/api/trace/context_utils.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  final testSpanContext = SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
      TraceFlags(api.TraceFlags.NONE), TraceState.empty());
  final testSpan = Span('foo', testSpanContext, SpanId([4, 5, 6]), [],
      Tracer('bar', [], IdGenerator(), InstrumentationLibrary()));

  group('getSpan', () {
    test('returns Span when exists', () {
      final parentContext = api.Context.current;
      final childContext = parentContext.setValue(spanKey, testSpan);

      expect(api.getSpan(childContext), same(testSpan));
    });

    test('returns null when not exists', () {
      final context = api.Context.current;

      expect(api.getSpan(context), isNull);
    });
  });

  group('context_utils', () {
    api.Context mockContext;

    setUpAll(() {
      mockContext = MockContext();
    });

    tearDown(() {
      reset(mockContext);
    });

    test('getSpanContext returns Span when exists', () {
      when(mockContext.getValue(spanKey)).thenReturn(testSpan);

      expect(api.getSpanContext(mockContext), same(testSpanContext));

      verify(mockContext.getValue(spanKey)).called(1);
    });

    test('getSpanContext returns Span when not exists', () {
      when(mockContext.getValue(spanKey)).thenReturn(null);

      expect(api.getSpanContext(mockContext), isNull);

      verify(mockContext.getValue(spanKey)).called(1);
    });

    test('setSpan sets', () {
      api.setSpan(mockContext, testSpan);

      verify(mockContext.setValue(spanKey, testSpan)).called(1);
    });
  });
}
