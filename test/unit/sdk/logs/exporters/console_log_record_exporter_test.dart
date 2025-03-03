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
  List<String> log = <String>[];

  tearDown(() {
    log = <String>[];
  });

  test(
      'Test exporter',
      overridePrint(
        () async {
          final exporter = sdk.ConsoleLogRecordExporter();
          final tracer = sdk.TracerProviderBase().getTracer('test');
          final parent = tracer.startSpan('parent');
          final context = api.contextWithSpan(api.Context.current, parent);
          final logRecord = sdk.LogRecord(
            instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
            context: context,
            logRecordLimits: LogRecordLimits(),
            timeProvider: FakeTimeProvider(now: Int64(123)),
            resource: sdk.Resource([api.Attribute.fromString('resource.name', 'test')]),
          )
            ..makeReadonly()
            ..body = 'Log Message';
          final spanContext = parent.spanContext;

          await exporter.export([logRecord]);

          expect(log, [
            '{resource: {attributes: {resource.name: test}}, instrumentationScope: {name: library_name, version: library_version, schemaUrl: url://schema, attributes: {}}, timestamp: 123, severityText: null, severityNumber: null, body: null, attributes: {}, traceId: ${spanContext.traceId}, spanId: ${spanContext.spanId}, traceFlags: ${spanContext.traceFlags}}'
          ]);

          await exporter.shutdown();
        },
        log.add,
      ));
}
