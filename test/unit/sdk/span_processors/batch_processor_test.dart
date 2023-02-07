// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/exporters/span_exporter.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/batch_processor.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  late BatchSpanProcessor processor;
  late SpanExporter mockExporter;
  late Span mockSpan1, mockSpan2, mockSpan3;

  setUp(() {
    mockSpan1 = MockSpan();
    mockSpan2 = MockSpan();
    mockSpan3 = MockSpan();

    mockExporter = MockSpanExporter();
    processor = BatchSpanProcessor(mockExporter,
        maxExportBatchSize: 2, scheduledDelayMillis: 100);
  });

  tearDown(() {
    processor.shutdown();
    reset(mockExporter);
  });

  test('forceFlush', () {
    processor
      ..onEnd(mockSpan1)
      ..onEnd(mockSpan2)
      ..onEnd(mockSpan3)
      ..forceFlush();

    verify(mockExporter.export([mockSpan1, mockSpan2])).called(1);
    verify(mockExporter.export([mockSpan3])).called(1);
    verify(mockExporter.forceFlush()).called(1);
  });

  test('shutdown shuts exporter down', () {
    processor.shutdown();

    verify(mockExporter.shutdown()).called(1);
    verify(mockExporter.forceFlush()).called(1);
  });
}
