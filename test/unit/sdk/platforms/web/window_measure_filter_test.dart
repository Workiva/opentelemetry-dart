@TestOn('chrome')
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:test/test.dart';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/platforms/web/user_timing_filters/mark_measure_filter.dart';
import 'package:opentelemetry/src/sdk/platforms/web/user_timing_filters/window_measure_filter.dart';

void main() {
  group('MarkMeasureFilterJS', () {
    const testSpanName = 'test_span';
    const testSpanAttributeKey = 'test_attribute';
    const testSpanAttributeValue = 'test_attribute_value';
    final testSpanAttributes = [
      api.Attribute.fromString(testSpanAttributeKey, testSpanAttributeValue)
    ];

    final testSpan = sdk.Span(
        testSpanName,
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        <api.SpanProcessor>[],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary('library_name', 'library_version'),
        attributes: testSpanAttributes)
      ..end();

    setUp(() {
      initSpanFilter();

      // Set to any because this fails if there are no rules
      // This makes it much easer to test that individual rules are being added
      MarkMeasureFilter.filterMode = MarkMeasureFilterMode.anyFilters;
    });

    tearDown(() {
      MarkMeasureFilter.clearFilters();
      assert(MarkMeasureFilter.rules.isEmpty,
          'Filter rules must be cleared between tests');
    });

    test('addNameFilter adds filter', () {
      $spanFilter.addNameFilter(testSpanName);
      expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
    });

    test('addAttributeKeyFilter adds filter', () {
      $spanFilter.addAttributeKeyFilter(testSpanAttributeKey);
      expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
    });

    test('addAttributeFilter adds filter', () {
      $spanFilter.addAttributeFilter(
          testSpanAttributeKey, testSpanAttributeValue);
      expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
    });

    test('addCustomFilter adds filter', () {
      $spanFilter.addCustomFilter(
        allowInterop((span) => getProperty(span, 'name') != testSpanName),
      );
      expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
    });

    test('clearFilters clears filters', () {
      $spanFilter.addNameFilter(testSpanName);
      expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);

      $spanFilter.clearFilters();
      expect(MarkMeasureFilter.rules.isEmpty, isTrue);
    });

    test('showMeasuresMatching***Filters sets FilterMode', () {
      expect(MarkMeasureFilter.filterMode, MarkMeasureFilterMode.anyFilters);
      $spanFilter.showMeasuresMatchingAllFilters();
      expect(MarkMeasureFilter.filterMode, MarkMeasureFilterMode.allFilters);
      $spanFilter.showMeasuresMatchingAnyFilters();
      expect(MarkMeasureFilter.filterMode, MarkMeasureFilterMode.anyFilters);
    });
  });
}
