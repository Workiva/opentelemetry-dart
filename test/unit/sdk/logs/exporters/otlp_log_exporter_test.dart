// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/collector/logs/v1/logs_service.pb.dart'
as pb_log_service;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/common/v1/common.pb.dart' as pb_common;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/logs/v1/logs.pb.dart' as pb_logs;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/logs/v1/logs.pbenum.dart' as pg_logs_enum;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/resource/v1/resource.pb.dart' as pb_resource;
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late MockHttpClient mockClient;
  final uri = Uri.parse('https://h.wdesk.org/s/opentelemetry-collector/v1/traces');

  setUp(() {
    mockClient = MockHttpClient();
  });

  tearDown(() {
    reset(mockClient);
  });

  test('sends logs', () {
    final resource = sdk.Resource([api.Attribute.fromString('service.name', 'bar')]);
    final instrumentationLibrary = sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []);
    final logLimit = LogRecordLimitsImpl(attributeCountLimit: 10, attributeValueLengthLimit: 5);

    final tracer = sdk.TracerProviderBase().getTracer('test');
    final parent = tracer.startSpan('parent');
    final context = api.contextWithSpan(api.Context.current, parent);

    final log1 = sdk.LogRecord(
        resource: resource,
        instrumentationScope: instrumentationLibrary,
        body: 'test log',
        severityNumber: api.Severity.fatal3,
        logRecordLimits: logLimit,
        context: context,
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..setAttribute('key', 'value');

    final log2 = sdk.LogRecord(
      resource: resource,
      instrumentationScope: instrumentationLibrary,
      context: context,
      body: 2,
      severityNumber: api.Severity.fatal3,
      attributes: sdk.Attributes.empty()
        ..addAll([
          api.Attribute.fromBoolean('fromBoolean', false),
          api.Attribute.fromDouble('fromDouble', 1.1),
          api.Attribute.fromInt('fromInt', 1),
          api.Attribute.fromBooleanList('fromBooleanList', [false]),
          api.Attribute.fromDoubleList('fromDoubleList', [1.1]),
          api.Attribute.fromIntList('fromIntList', [1]),
        ]),
      logRecordLimits: logLimit,
      timeProvider: FakeTimeProvider(now: Int64(123)),
    )..setAttribute('key', 'value');

    final log3 = sdk.LogRecord(
        resource: resource,
        instrumentationScope: instrumentationLibrary,
        context: context,
        body: 2.2,
        severityNumber: api.Severity.fatal3,
        logRecordLimits: logLimit,
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..setAttribute('key', 'value');

    final log4 = sdk.LogRecord(
        resource: resource,
        instrumentationScope: instrumentationLibrary,
        context: context,
        body: true,
        severityNumber: api.Severity.fatal3,
        logRecordLimits: logLimit,
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..setAttribute('key', 'value');

    sdk.OTLPLogExporter(uri, httpClient: mockClient).export([log1, log2, log3, log4]);

    final expected = pb_log_service.ExportLogsServiceRequest(resourceLogs: [
      pb_logs.ResourceLogs(
          resource: pb_resource.Resource(
              attributes: [pb_common.KeyValue(key: 'service.name', value: pb_common.AnyValue(stringValue: 'bar'))]),
          scopeLogs: [
            pb_logs.ScopeLogs(
              logRecords: [
                pb_logs.LogRecord(
                  timeUnixNano: Int64(123),
                  severityNumber: pg_logs_enum.SeverityNumber.valueOf(log1.severityNumber!.index),
                  attributes: [pb_common.KeyValue(key: 'key', value: pb_common.AnyValue(stringValue: 'value'))],
                  traceId: parent.spanContext.traceId.get(),
                  spanId: parent.spanContext.spanId.get(),
                  body: pb_common.AnyValue(stringValue: 'test log'),
                  observedTimeUnixNano: Int64(123),
                  droppedAttributesCount: 0,
                ),
                pb_logs.LogRecord(
                  timeUnixNano: Int64(123),
                  severityNumber: pg_logs_enum.SeverityNumber.valueOf(log2.severityNumber!.index),
                  attributes: [
                    pb_common.KeyValue(key: 'fromBoolean', value: pb_common.AnyValue(boolValue: false)),
                    pb_common.KeyValue(key: 'fromDouble', value: pb_common.AnyValue(doubleValue: 1.1)),
                    pb_common.KeyValue(key: 'fromInt', value: pb_common.AnyValue(intValue: Int64(1))),
                    pb_common.KeyValue(
                      key: 'fromBooleanList',
                      value: pb_common.AnyValue(
                        arrayValue: pb_common.ArrayValue(values: [pb_common.AnyValue(boolValue: false)]),
                      ),
                    ),
                    pb_common.KeyValue(
                      key: 'fromDoubleList',
                      value: pb_common.AnyValue(
                        arrayValue: pb_common.ArrayValue(values: [pb_common.AnyValue(doubleValue: 1.1)]),
                      ),
                    ),
                    pb_common.KeyValue(
                      key: 'fromIntList',
                      value: pb_common.AnyValue(
                        arrayValue: pb_common.ArrayValue(values: [pb_common.AnyValue(intValue: Int64(1))]),
                      ),
                    ),
                    pb_common.KeyValue(key: 'key', value: pb_common.AnyValue(stringValue: 'value')),
                  ],
                  traceId: parent.spanContext.traceId.get(),
                  spanId: parent.spanContext.spanId.get(),
                  body: pb_common.AnyValue(intValue: Int64(2)),
                  observedTimeUnixNano: Int64(123),
                  droppedAttributesCount: 0,
                ),
                pb_logs.LogRecord(
                  timeUnixNano: Int64(123),
                  severityNumber: pg_logs_enum.SeverityNumber.valueOf(log1.severityNumber!.index),
                  attributes: [pb_common.KeyValue(key: 'key', value: pb_common.AnyValue(stringValue: 'value'))],
                  traceId: parent.spanContext.traceId.get(),
                  spanId: parent.spanContext.spanId.get(),
                  body: pb_common.AnyValue(doubleValue: 2.2),
                  observedTimeUnixNano: Int64(123),
                  droppedAttributesCount: 0,
                ),
                pb_logs.LogRecord(
                  timeUnixNano: Int64(123),
                  severityNumber: pg_logs_enum.SeverityNumber.valueOf(log1.severityNumber!.index),
                  attributes: [pb_common.KeyValue(key: 'key', value: pb_common.AnyValue(stringValue: 'value'))],
                  traceId: parent.spanContext.traceId.get(),
                  spanId: parent.spanContext.spanId.get(),
                  body: pb_common.AnyValue(boolValue: true),
                  observedTimeUnixNano: Int64(123),
                  droppedAttributesCount: 0,
                ),
              ],
              scope: pb_common.InstrumentationScope(name: 'library_name', version: 'library_version'),
            )
          ])
    ]);
    final verifyResult = verify(() =>
        mockClient.post(uri, body: captureAny(named: 'body'), headers: {'Content-Type': 'application/x-protobuf'}))
      ..called(1);
    final captured = verifyResult.captured;

    final traceRequest = pb_log_service.ExportLogsServiceRequest.fromBuffer(captured[0] as Uint8List);
    expect(traceRequest, equals(expected));
  });

  test('does not send log when shutdown', () {
    final instrumentationLibrary = sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []);
    final logLimit = LogRecordLimitsImpl(attributeCountLimit: 10, attributeValueLengthLimit: 5);

    final tracer = sdk.TracerProviderBase().getTracer('test');
    final parent = tracer.startSpan('parent');
    final context = api.contextWithSpan(api.Context.current, parent);

    final log1 = sdk.LogRecord(
        instrumentationScope: instrumentationLibrary,
        context: context,
        body: 'test log',
        severityNumber: api.Severity.fatal3,
        logRecordLimits: logLimit,
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..setAttribute('key', 'value');

    sdk.OTLPLogExporter(uri, httpClient: mockClient)
      ..shutdown()
      ..export([log1]);

    verify(() => mockClient.close()).called(1);
    verifyNever(() => mockClient.post(uri, body: anything, headers: {'Content-Type': 'application/x-protobuf'}));
  });

  test('supplies HTTP headers', () {
    final instrumentationLibrary = sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []);
    final logLimit = LogRecordLimitsImpl(attributeCountLimit: 10, attributeValueLengthLimit: 5);

    final tracer = sdk.TracerProviderBase().getTracer('test');
    final parent = tracer.startSpan('parent');
    final context = api.contextWithSpan(api.Context.current, parent);

    final log1 = sdk.LogRecord(
        instrumentationScope: instrumentationLibrary,
        body: 'test log',
        severityNumber: api.Severity.fatal3,
        logRecordLimits: logLimit,
        context: context,
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..setAttribute('key', 'value');

    final suppliedHeaders = {
      'header-param-key-1': 'header-param-value-1',
      'header-param-key-2': 'header-param-value-2',
    };
    final expectedHeaders = {
      'Content-Type': 'application/x-protobuf',
      ...suppliedHeaders,
    };

    sdk.OTLPLogExporter(uri, httpClient: mockClient, headers: suppliedHeaders).export([log1]);

    verify(() => mockClient.post(uri, body: anything, headers: expectedHeaders)).called(1);
  });
}
