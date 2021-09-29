import 'dart:async';

import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/console_exporter.dart';
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
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
    final span = Span(
        'foo',
        SpanContext([1, 2, 3], [7, 8, 9], TraceState()),
        [4, 5, 6],
        [],
        Tracer('bar', [], IdGenerator(), InstrumentationLibrary()))
      ..end();

    ConsoleExporter().export([span]);

    final expected = RegExp(
        r'{traceId: 010203, parentId: 040506, name: foo, id: 070809, timestamp: \d+, duration: \d+, status: StatusCode.UNSET}');
    expect(printLogs.length, 1);
    expect(expected.hasMatch(printLogs[0]), true);
  }));

  test('does not print after shutdown', overridePrint(() {
    final span = Span(
        'foo',
        SpanContext([1, 2, 3], [7, 8, 9], TraceState()),
        [4, 5, 6],
        [],
        Tracer('bar', [], IdGenerator(), InstrumentationLibrary()));

    ConsoleExporter()
      ..shutdown()
      ..export([span]);

    expect(printLogs.length, 0);
  }));
}
