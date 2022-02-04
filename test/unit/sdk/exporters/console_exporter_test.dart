import 'dart:async';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

List<String> printLogs = [];

dynamic overridePrint(Function() testFn) => () {
      final spec = ZoneSpecification(print: (_, __, ___, msg) {
        // Add to log instead of printing to stdout
        printLogs.add(msg);
      });
      return Zone.current.fork(specification: spec).run<void>(testFn);
    };

void main() {
  tearDown(() {
    printLogs = [];
  });

  test('prints', overridePrint(() {
    final span = sdk.Span(
        'foo',
        sdk.SpanContext(sdk.TraceId([1, 2, 3]), sdk.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        sdk.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary('library_name', 'library_version'))
      ..end();

    sdk.ConsoleExporter().export([span]);

    final expected = RegExp(
        r'{traceId: 010203, parentId: 040506, name: foo, id: 070809, timestamp: \d+, duration: \d+, flags: 00, state: , status: StatusCode.unset}');
    expect(printLogs.length, 1);
    expect(printLogs[0], matches(expected));
  }));

  test('does not print after shutdown', overridePrint(() {
    final span = sdk.Span(
        'foo',
        sdk.SpanContext(sdk.TraceId([1, 2, 3]), sdk.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        sdk.SpanId([4, 5, 6]),
        [],
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary('library_name', 'library_version'));

    sdk.ConsoleExporter()
      ..shutdown()
      ..export([span]);

    expect(printLogs.length, 0);
  }));
}
