@JS()
library window_measure_filter;

import 'dart:js_util';

import 'package:js/js.dart';

import '../../../../../api.dart' as api;
import '../../../../../sdk.dart' as sdk;
import 'mark_measure_filter.dart';

typedef CustomFilter = bool Function(dynamic span);

@anonymous
@JS()
class MarkMeasureFilterJS {
  external factory MarkMeasureFilterJS({
    Function addCustomFilter,
    Function addNameFilter,
    Function addAttributeFilter,
    Function addAttributeKeyFilter,
    Function clearFilters,
    Function showMeasuresMatchingAnyFilters,
    Function showMeasuresMatchingAllFilters,
  });

  external void addCustomFilter(CustomFilter filter);
  external void addNameFilter(String rule);
  external void addAttributeFilter(String key, String value);
  external void addAttributeKeyFilter(String key);

  external void clearFilters();

  external void showMeasuresMatchingAnyFilters();
  external void showMeasuresMatchingAllFilters();
}

@JS()
external set $spanFilter(MarkMeasureFilterJS v);
@JS()
external MarkMeasureFilterJS get $spanFilter;

Map jsonifyContext(api.SpanContext context) => {
      'spanId': context.spanId.toString(),
      'traceId': context.traceId.toString(),
      'traceFlags': context.traceFlags,
      'traceState': context.traceState,
      'isValid': context.isValid,
      'isRemote': context.isRemote,
    };

Map jsonifyInstrumentationLibrary(
        api.InstrumentationLibrary instrumentationLibrary) =>
    {
      'name': instrumentationLibrary.name,
      'version': instrumentationLibrary.version,
    };

Map jsonifySpan(sdk.Span span) => {
      'spanContext':
          span.spanContext != null ? jsonifyContext(span.spanContext) : null,
      'parentSpanId': span.parentSpanId?.toString(),
      'name': span.name,
      'startTime': span.startTime,
      'endTime': span.endTime,
      'attributes': span.attributes,
      'isRecording': span.isRecording,
      'kind': span.kind,
      'status': span.status,
      'resource': span.resource,
      'instrumentationLibrary': span.instrumentationLibrary != null
          ? jsonifyInstrumentationLibrary(span.instrumentationLibrary)
          : null,
    };

void initSpanFilter() {
  $spanFilter ??= MarkMeasureFilterJS(
    addCustomFilter: allowInterop((customFilter) {
      MarkMeasureFilter.addFilter(
          (span) => customFilter(jsify(jsonifySpan(span as sdk.Span))));
      print('Added custom filter');
    }),
    addNameFilter: allowInterop((rule) {
      MarkMeasureFilter.addFilter((span) => span.name.contains(rule));
      print('Added rule: `span.name.contains($rule)`');
    }),
    addAttributeKeyFilter: allowInterop((key) {
      MarkMeasureFilter.addFilter(
          (span) => (span as sdk.Span).attributes.get(key) != null);
      print('Added rule: `span.attributes.containsKey($key)`');
    }),
    addAttributeFilter: allowInterop((key, value) {
      MarkMeasureFilter.addFilter((span) =>
          (span as sdk.Span).attributes.get(key).toString().contains(value));
      print(
          'Added rule: `span.attributes.get(`$key`).toString().contains(`$value`)');
    }),
    showMeasuresMatchingAllFilters: allowInterop(() {
      MarkMeasureFilter.filterMode = MarkMeasureFilterMode.allFilters;
      print('Filtering spans that match all filters');
    }),
    showMeasuresMatchingAnyFilters: allowInterop(() {
      MarkMeasureFilter.filterMode = MarkMeasureFilterMode.anyFilters;
      print('Filtering spans that match any filters');
    }),
    clearFilters: allowInterop(MarkMeasureFilter.clearFilters),
  );
}
