// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:fixnum/fixnum.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  test('Test exporter', () async {
    final exporter = sdk.InMemoryLogRecordExporter();
    final logRecord = sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      logRecordLimits: LogRecordLimits(),
      timeProvider: FakeTimeProvider(now: Int64(123)),
      resource: sdk.Resource([api.Attribute.fromString('resource.name', 'test')]),
    )
      ..makeReadonly()
      ..body = 'Log Message';

    await exporter.export([logRecord]);

    expect(exporter.finishedLogRecords.length, 1);
    expect(exporter.finishedLogRecords.first.instrumentationScope.name, 'library_name');

    await exporter.shutdown();

    expect(exporter.finishedLogRecords.length, 0);
  });
}
