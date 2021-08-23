import 'dart:async';

import 'package:opentelemetry/src/sdk/trace/exporters/console_exporter.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

List<String> printLogs = [];

dynamic overridePrint(Function() testFn) => () {
  final spec = ZoneSpecification(
    print: (_, __, ___, msg) {
      // Add to log instead of printing to stdout
      printLogs.add(msg);
    }
  );
  return Zone.current.fork(specification: spec).run<void>(testFn);
};

void main() {
  tearDown(() {
    printLogs = [];
  });

  test('prints', overridePrint(() {
    final span = Span('foo', SpanContext([1, 2, 3], [7, 8, 9], TraceState()), [4, 5, 6], [])
    ..end();

    ConsoleExporter().export([span]);

    final expected = RegExp(r'{traceId: \[1, 2, 3\], parentId: \[4, 5, 6\], name: foo, id: \[7, 8, 9\], timestamp: \d+, duration: \d+, status: StatusCode.UNSET}');
    expect(printLogs.length, 1);
    expect(expected.hasMatch(printLogs[0]), true);
  }));

  test('does not print after shutdown', overridePrint(() {
    final span = Span('foo', SpanContext([1, 2, 3], [7, 8, 9], TraceState()), [4, 5, 6], []);

    ConsoleExporter()
    ..shutdown()
    ..export([span]);

    expect(printLogs.length, 0);
  }));
}
