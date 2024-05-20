// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/Logs/readable_log_record.dart';
import 'package:test/test.dart';


import '../../mocks.dart';

void main() {
  late sdk.LogRecordExporter exporter;
  late sdk.LogRecordProcessor processor;
  late  ReadableLogRecord logRecord;

  setUp(() {
    exporter = MockLogRecordExpoter();
    processor = sdk.SimpleLogRecordProcessor(logRecordExporter: exporter);
    logRecord = MockReadableLog();
  });

  test('executes export', () {
    processor.onEmit(logRecord);

    verify(() => exporter.export([logRecord])).called(1);
  });

  test('flushes exporter on forced flush', () {
    processor.forceFlush();

    verify(() => exporter.forceFlush()).called(1);
  });

  test('does not export if shut down', () {
    processor
      ..shutdown()
      ..onEmit(logRecord);

    verify(() => exporter.shutdown()).called(1);
    verify(() => exporter.forceFlush()).called(1);
    verifyNever(() => exporter.export([logRecord]));
  });
}
