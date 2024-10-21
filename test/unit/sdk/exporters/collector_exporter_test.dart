// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logging/logging.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/common/limits.dart';
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/collector/trace/v1/trace_service.pb.dart'
    as pb_trace_service;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/common/v1/common.pb.dart'
    as pb_common;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/resource/v1/resource.pb.dart'
    as pb_resource;
import 'package:opentelemetry/src/sdk/proto/opentelemetry/proto/trace/v1/trace.pb.dart'
    as pb;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  final uri =
      Uri.parse('https://example.test/s/opentelemetry-collector/v1/traces');

  group('Send spans with success - ', () {
    late MockHttpClient mockClient;
    setUp(() {
      mockClient = MockHttpClient();
      when(() => mockClient.post(uri,
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('', 200));
    });

    tearDown(() {
      reset(mockClient);
    });

    test('sends spans', () async {
      final resource =
          sdk.Resource([api.Attribute.fromString('service.name', 'bar')]);
      final instrumentationLibrary = sdk.InstrumentationScope(
          'library_name', 'library_version', 'url://schema', []);
      final limits = sdk.SpanLimits(maxNumAttributeLength: 5);
      final span1 = Span(
          'foo',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          resource,
          instrumentationLibrary,
          api.SpanKind.client,
          [],
          sdk.SpanLimits(),
          sdk.DateTimeTimeProvider().now)
        ..setAttributes([api.Attribute.fromString('foo', 'bar')])
        ..end();
      final span2 = Span(
          'baz',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([10, 11, 12]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          resource,
          instrumentationLibrary,
          api.SpanKind.internal,
          applyLinkLimits([
            api.SpanLink(span1.spanContext, attributes: [
              api.Attribute.fromString('longKey',
                  'I am very long with maxNumAttributeLength: 5 limitation!')
            ]),
          ], limits),
          limits,
          sdk.DateTimeTimeProvider().now)
        ..setAttributes([api.Attribute.fromBoolean('bool', true)])
        ..addEvent('testEvent',
            timestamp: sdk.DateTimeTimeProvider().now,
            attributes: [api.Attribute.fromString('foo', 'bar')])
        ..end();

      await sdk.CollectorExporter(uri, httpClient: mockClient)
          .export([span1, span2]);

      final expectedBody =
          pb_trace_service.ExportTraceServiceRequest(resourceSpans: [
        pb.ResourceSpans(
            resource: pb_resource.Resource(attributes: [
              pb_common.KeyValue(
                  key: 'service.name',
                  value: pb_common.AnyValue(stringValue: 'bar'))
            ]),
            scopeSpans: [
              pb.ScopeSpans(
                  spans: [
                    pb.Span(
                        traceId: [1, 2, 3],
                        spanId: [7, 8, 9],
                        traceState: '',
                        parentSpanId: [4, 5, 6],
                        name: 'foo',
                        kind: pb.Span_SpanKind.SPAN_KIND_CLIENT,
                        startTimeUnixNano: span1.startTime,
                        endTimeUnixNano: span1.endTime,
                        attributes: [
                          pb_common.KeyValue(
                              key: 'foo',
                              value: pb_common.AnyValue(stringValue: 'bar'))
                        ],
                        droppedAttributesCount: 0,
                        status: pb.Status(
                            code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                            message: ''),
                        flags: 0),
                    pb.Span(
                        traceId: [1, 2, 3],
                        spanId: [10, 11, 12],
                        traceState: '',
                        parentSpanId: [4, 5, 6],
                        name: 'baz',
                        kind: pb.Span_SpanKind.SPAN_KIND_INTERNAL,
                        startTimeUnixNano: span2.startTime,
                        endTimeUnixNano: span2.endTime,
                        attributes: [
                          pb_common.KeyValue(
                              key: 'bool',
                              value: pb_common.AnyValue(boolValue: true))
                        ],
                        droppedAttributesCount: 0,
                        events: [
                          pb.Span_Event(
                            timeUnixNano: span2.events.first.timestamp,
                            name: 'testEvent',
                            attributes: [
                              pb_common.KeyValue(
                                  key: 'foo',
                                  value: pb_common.AnyValue(stringValue: 'bar'))
                            ],
                            droppedAttributesCount: 0,
                          )
                        ],
                        droppedEventsCount: 0,
                        status: pb.Status(
                            code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                            message: ''),
                        links: [
                          pb.Span_Link(
                              traceId: [1, 2, 3],
                              spanId: [7, 8, 9],
                              traceState: '',
                              attributes: [
                                pb_common.KeyValue(
                                    key: 'longKey',
                                    value: pb_common.AnyValue(
                                        stringValue: 'I am '))
                              ],
                              droppedAttributesCount: 0,
                              flags: 0)
                        ],
                        droppedLinksCount: 0,
                        flags: 0)
                  ],
                  scope: pb_common.InstrumentationScope(
                      name: 'library_name', version: 'library_version'))
            ])
      ]);

      final verifyResult = verify(() => mockClient.post(uri,
          body: captureAny(named: 'body'),
          headers: {'Content-Type': 'application/x-protobuf'}))
        ..called(1);
      final captured = verifyResult.captured;

      final traceRequest =
          pb_trace_service.ExportTraceServiceRequest.fromBuffer(
              captured[0] as Uint8List);
      expect(traceRequest, equals(expectedBody));
    });

    test('does not send spans when shutdown', () async {
      final span = Span(
          'foo',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          sdk.Resource([]),
          sdk.InstrumentationScope(
              'library_name', 'library_version', 'url://schema', []),
          api.SpanKind.internal,
          [],
          sdk.SpanLimits(),
          sdk.DateTimeTimeProvider().now)
        ..end();
      final exporter = sdk.CollectorExporter(uri, httpClient: mockClient);
      // ignore: cascade_invocations
      exporter.shutdown();
      await exporter.export([span]);

      verify(() => mockClient.close()).called(1);
      verifyNever(() => mockClient.post(uri,
          body: anything, headers: {'Content-Type': 'application/x-protobuf'}));
    });

    test('supplies HTTP headers', () async {
      final span = Span(
          'foo',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          sdk.Resource([]),
          sdk.InstrumentationScope(
              'library_name', 'library_version', 'url://schema', []),
          api.SpanKind.internal,
          [],
          sdk.SpanLimits(),
          sdk.DateTimeTimeProvider().now)
        ..end();

      final suppliedHeaders = {
        'header-param-key-1': 'header-param-value-1',
        'header-param-key-2': 'header-param-value-2',
      };
      final expectedHeaders = {
        'Content-Type': 'application/x-protobuf',
        ...suppliedHeaders,
      };

      await sdk.CollectorExporter(uri,
              httpClient: mockClient, headers: suppliedHeaders)
          .export([span]);

      verify(() =>
              mockClient.post(uri, body: anything, headers: expectedHeaders))
          .called(1);
    });

    test('does not supply HTTP headers', () async {
      final span = Span(
          'foo',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          sdk.Resource([]),
          sdk.InstrumentationScope(
              'library_name', 'library_version', 'url://schema', []),
          api.SpanKind.internal,
          [],
          sdk.SpanLimits(),
          sdk.DateTimeTimeProvider().now)
        ..end();

      final expectedHeaders = {'Content-Type': 'application/x-protobuf'};

      await sdk.CollectorExporter(uri, httpClient: mockClient).export([span]);

      verify(() =>
              mockClient.post(uri, body: anything, headers: expectedHeaders))
          .called(1);
    });
  });

  group('Send spans with failure - ', () {
    late MockHttpClient mockClient;
    setUp(() {
      mockClient = MockHttpClient();
      when(() => mockClient.post(uri,
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('', 403));
    });

    tearDown(() {
      reset(mockClient);
    });
    test('shows a warning log when export failed', () async {
      final span = Span(
          'foo',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          sdk.Resource([]),
          sdk.InstrumentationScope(
              'library_name', 'library_version', 'url://schema', []),
          api.SpanKind.internal,
          [],
          sdk.SpanLimits(),
          sdk.DateTimeTimeProvider().now)
        ..end();

      when(() => mockClient.post(uri,
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/x-protobuf'}))
          .thenThrow(Exception('Failed to connect'));

      final records = <LogRecord>[];
      final sub = Logger.root.onRecord.listen(records.add);
      await sdk.CollectorExporter(uri, httpClient: mockClient).export([span]);
      await sub.cancel();

      verify(() => mockClient.post(uri,
          body: anything,
          headers: {'Content-Type': 'application/x-protobuf'})).called(3);

      expect(records, hasLength(4));
      expect(records[0].level, equals(Level.WARNING));
      expect(records[1].level, equals(Level.WARNING));
      expect(records[2].level, equals(Level.WARNING));
      expect(records[3].level, equals(Level.SEVERE));
    });

    test('client not return 200', () async {
      final span = Span(
          'foo',
          api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
              api.TraceFlags.none, api.TraceState.empty()),
          api.SpanId([4, 5, 6]),
          [],
          sdk.DateTimeTimeProvider(),
          sdk.Resource([]),
          sdk.InstrumentationScope(
              'library_name', 'library_version', 'url://schema', []),
          api.SpanKind.internal,
          [],
          sdk.SpanLimits(),
          sdk.DateTimeTimeProvider().now)
        ..end();

      when(() => mockClient.post(uri,
              body: any(named: 'body'),
              headers: {'Content-Type': 'application/x-protobuf'}))
          .thenAnswer((_) async => Response('Service unAvailable', 403));

      final expectedHeaders = {'Content-Type': 'application/x-protobuf'};
      await sdk.CollectorExporter(uri, httpClient: mockClient).export([span]);

      verify(() =>
              mockClient.post(uri, body: anything, headers: expectedHeaders))
          .called(3);
    });
  });
}
