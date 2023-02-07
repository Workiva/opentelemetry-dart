// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/exporters/span_exporter.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/simple_processor.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  late SpanExporter exporter;
  late SimpleSpanProcessor processor;
  late Span span;

  setUp(() {
    exporter = MockSpanExporter();
    processor = SimpleSpanProcessor(exporter);
    span = MockSpan();
  });

  test('executes export', () {
    processor.onEnd(span);

    verify(exporter.export([span])).called(1);
  });

  test('flushes exporter on forced flush', () {
    processor.forceFlush();

    verify(exporter.forceFlush()).called(1);
  });

  test('does not export if shut down', () {
    processor
      ..shutdown()
      ..onEnd(span);

    verify(exporter.shutdown()).called(1);
    verify(exporter.forceFlush()).called(1);
    verifyNever(exporter.export([span]));
  });
}
