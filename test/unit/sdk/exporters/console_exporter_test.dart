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
    final span = Span('foo', SpanContext('trace123', 'span789', TraceState()), 'span456', [])
    ..end();

    ConsoleExporter().export([span]);

    final expected = RegExp(r'^{traceId: trace123, parentId: span456, name: foo, id: span789, timestamp: \d+, duration: \d+}$');
    expect(printLogs.length, 1);
    expect(expected.hasMatch(printLogs[0]), true);
  }));

  test('does not print after shutdown', overridePrint(() {
    final span = Span('foo', SpanContext('trace123', 'span789', TraceState()), 'span456', []);

    ConsoleExporter()
    ..shutdown()
    ..export([span]);

    expect(printLogs.length, 0);
  }));
}
