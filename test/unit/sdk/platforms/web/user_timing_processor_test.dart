@TestOn('chrome')
import 'dart:html' show PerformanceEntry, window;
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/exporters/span_exporter.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/platforms/web/trace/user_timing_processor.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  SpanExporter exporter;
  UserTimingSpanProcessor processor;
  Span span;
  const testSpanName = 'test_span';
  const testSpanAttributeKey = 'test_attribute';
  const testSpanAttributeValue = 'test_attribute_value';
  final testSpanAttributes = [
    api.Attribute.fromString(testSpanAttributeKey, testSpanAttributeValue)
  ];

  setUp(() {
    exporter = MockSpanExporter();
    processor = UserTimingSpanProcessor(exporter);
    span = sdk.Span(
        testSpanName,
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        <api.SpanProcessor>[processor],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary('library_name', 'library_version'),
        attributes: testSpanAttributes);
  });

  test('sets marks and measure', () {
    var marks = List<PerformanceEntry>.from(
        window.performance.getEntriesByType('mark'));
    var measures = List<PerformanceEntry>.from(
        window.performance.getEntriesByType('measure'));
    expect(marks, hasLength(1));
    expect(marks[0].name, 'test_span[070809].start');
    expect(measures, hasLength(0));

    processor.onEnd(span);

    marks = List<PerformanceEntry>.from(
        window.performance.getEntriesByType('mark'));
    measures = List<PerformanceEntry>.from(
        window.performance.getEntriesByType('measure'));
    expect(marks, hasLength(2));
    expect(marks[1].name, 'test_span[070809].end');
    expect(measures, hasLength(1));
    expect(measures[0].name, 'test_span - 809[childOf:506]');
  });

  test('devMeasureName changes measure name', () {
    span.setAttribute(
        api.Attribute.fromString('wk.dev.measure_name', 'devMeasureNameTest'));
    processor.onEnd(span);

    final measures = List<PerformanceEntry>.from(window.performance
        .getEntriesByName('devMeasureNameTest - 809[childOf:506]', 'measure'));
    expect(measures, hasLength(1));
  });

  test('executes export', () {
    processor.onEnd(span);

    verify(exporter.export([span])).called(1);
  });

  test('does not export if shutdown', () {
    processor
      ..shutdown()
      ..onEnd(span);

    verify(exporter.shutdown()).called(1);
    verifyNever(exporter.export([span]));
  });
}
