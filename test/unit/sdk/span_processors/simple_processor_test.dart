@TestOn('vm')
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/exporters/span_exporter.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/simple_processor.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  SpanExporter exporter;
  SimpleSpanProcessor processor;
  Span span;

  setUp(() {
    exporter = MockSpanExporter();
    processor = SimpleSpanProcessor(exporter);
    span = MockSpan();
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
