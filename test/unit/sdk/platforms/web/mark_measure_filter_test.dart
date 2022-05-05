@TestOn('chrome')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

import 'package:opentelemetry/src/sdk/platforms/web/user_timing_filters/mark_measure_filter.dart';

void main() {
  group('MarkMeasureFilter', () {
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
        attributes: testSpanAttributes);

    bool passingNameTest(api.Span span) => span.name == testSpanName;
    bool failingNameTest(api.Span span) => span.name == 'something_else';
    bool passingAttributeTest(api.Span span) =>
        (span as sdk.Span).attributes.get(testSpanAttributeKey) != null;
    bool failingAttributeTest(api.Span span) =>
        (span as sdk.Span).attributes.get('something_else') != null;

    tearDown(() {
      MarkMeasureFilter.clearFilters();
      assert(MarkMeasureFilter.rules.isEmpty,
          'Filter rules must be cleared between tests');
    });

    group('with FilterMode.allFilter', () {
      setUp(() {
        MarkMeasureFilter.filterMode = MarkMeasureFilterMode.allFilters;
      });

      test('with no rules always passes', () {
        expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
      });

      group('with one test', () {
        test('passes if the test passes', () {
          MarkMeasureFilter.addFilter(passingNameTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
        });

        test('fails if the test fails', () {
          MarkMeasureFilter.addFilter(failingNameTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
        });
      });

      group('with several tests', () {
        test('passes if all tests pass', () {
          MarkMeasureFilter.addFilter(passingNameTest);
          MarkMeasureFilter.addFilter(passingAttributeTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
        });

        test('fails if one test fails', () {
          MarkMeasureFilter.addFilter(passingNameTest);
          MarkMeasureFilter.addFilter(failingAttributeTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
        });

        test('fails if all tests fail', () {
          MarkMeasureFilter.addFilter(failingNameTest);
          MarkMeasureFilter.addFilter(failingAttributeTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
        });
      });
    });

    group('with FilterMode.anyFilter', () {
      setUp(() {
        MarkMeasureFilter.filterMode = MarkMeasureFilterMode.anyFilters;
      });

      test('with no rules always fails', () {
        expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
      });

      group('with one test', () {
        test('passes if the test passes', () {
          MarkMeasureFilter.addFilter(passingNameTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
        });

        test('fails if the test fails', () {
          MarkMeasureFilter.addFilter(failingNameTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
        });
      });

      group('with several tests', () {
        test('passes if all tests pass', () {
          MarkMeasureFilter.addFilter(passingNameTest);
          MarkMeasureFilter.addFilter(passingAttributeTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
        });

        test('passes if one test passes', () {
          MarkMeasureFilter.addFilter(failingNameTest);
          MarkMeasureFilter.addFilter(passingAttributeTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isTrue);
        });

        test('fails if all tests fail', () {
          MarkMeasureFilter.addFilter(failingNameTest);
          MarkMeasureFilter.addFilter(failingAttributeTest);

          expect(MarkMeasureFilter.doesSpanPassFilters(testSpan), isFalse);
        });
      });
    });
  });
}
