// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:fixnum/fixnum.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/common/export_result.dart';
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  test('test processor', () async {
    final exporter = MockLogRecordExporter();
    when(() => exporter.export(any())).thenAnswer((_) async => ExportResult(code: ExportResultCode.success));
    final processor = sdk.BatchLogRecordProcessor(
      exporter: exporter,
      scheduledDelayMillis: Duration.zero.inMilliseconds,
    );

    final tracer = sdk.TracerProviderBase().getTracer('test');
    final parent = tracer.startSpan('parent');
    final context = api.contextWithSpan(api.Context.current, parent);
    final logRecord = sdk.LogRecord(
        instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
        logRecord: api.LogRecord(),
        logRecordLimits: sdk.LogRecordLimits(),
        context: context,
        timeProvider: FakeTimeProvider(now: Int64(123)));
    final logRecordA = logRecord
      ..body = 'test log'
      ..severityNumber = api.Severity.fatal3;
    processor.onEmit(logRecordA);

    await Future.delayed(const Duration(milliseconds: 100));
    verify(() => exporter.export(any<List<sdk.ReadableLogRecord>>(
          that: predicate<List<sdk.ReadableLogRecord>>((a) {
            final first = a.first;
            return first.body == 'test log' &&
                first.spanContext?.spanId == parent.spanContext.spanId &&
                first.severityNumber == api.Severity.fatal3;
          }),
        ))).called(1);
  });

  test('processor shut down', () async {
    final exporter = MockLogRecordExporter();
    when(exporter.shutdown).thenAnswer((_) async => ExportResult(code: ExportResultCode.success));

    final processor = sdk.BatchLogRecordProcessor(
      exporter: exporter,
      scheduledDelayMillis: Duration.zero.inMilliseconds,
    );

    await processor.shutdown();

    verify(exporter.shutdown).called(1);
  });

  test('processor shut down will not emit log', () async {
    final exporter = MockLogRecordExporter();
    when(exporter.shutdown).thenAnswer((_) async => ExportResult(code: ExportResultCode.success));

    final processor = sdk.BatchLogRecordProcessor(
      exporter: exporter,
      scheduledDelayMillis: Duration.zero.inMilliseconds,
    );

    await processor.shutdown();
    final logRecord = sdk.LogRecord(
        instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
        logRecord: api.LogRecord(),
        logRecordLimits: sdk.LogRecordLimits());
    final logRecordA = logRecord
      ..body = 'test log'
      ..severityNumber = api.Severity.fatal3;
    processor.onEmit(logRecordA);

    await Future.delayed(const Duration(milliseconds: 100));

    verifyNever(() => exporter.export(any()));
  });

  test('processor force flush', () async {
    final exporter = MockLogRecordExporter();
    when(() => exporter.export(any())).thenAnswer((_) async => ExportResult(code: ExportResultCode.success));

    final processor = sdk.BatchLogRecordProcessor(
      exporter: exporter,
      scheduledDelayMillis: Duration(seconds: 5).inMilliseconds,
    );

    final logRecord = sdk.LogRecord(
        instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
        logRecord: api.LogRecord(),
        logRecordLimits: sdk.LogRecordLimits());
    final logRecordA = logRecord
      ..body = 'test log'
      ..severityNumber = api.Severity.fatal3;
    processor.onEmit(logRecordA);

    await processor.forceFlush();

    verify(() => exporter.export(any<List<sdk.ReadableLogRecord>>(
          that: predicate<List<sdk.ReadableLogRecord>>((a) {
            final first = a.first;
            return first.body == 'test log' && first.severityNumber == api.Severity.fatal3;
          }),
        ))).called(1);
  });
}
