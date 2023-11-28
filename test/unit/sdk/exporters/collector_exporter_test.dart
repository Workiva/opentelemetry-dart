// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:typed_data';

import 'package:mockito/mockito.dart';
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
  late MockHttpClient mockClient;
  final uri =
      Uri.parse('https://h.wdesk.org/s/opentelemetry-collector/v1/traces');

  setUp(() {
    mockClient = MockHttpClient();
  });

  tearDown(() {
    reset(mockClient);
  });

  test('sends spans', () {
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

    sdk.CollectorExporter(uri, httpClient: mockClient).export([span1, span2]);

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
                      parentSpanId: [4, 5, 6],
                      name: 'foo',
                      startTimeUnixNano: span1.startTime,
                      endTimeUnixNano: span1.endTime,
                      attributes: [
                        pb_common.KeyValue(
                            key: 'foo',
                            value: pb_common.AnyValue(stringValue: 'bar'))
                      ],
                      status: pb.Status(
                          code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                          message: ''),
                      kind: pb.Span_SpanKind.SPAN_KIND_CLIENT),
                  pb.Span(
                      traceId: [1, 2, 3],
                      spanId: [10, 11, 12],
                      parentSpanId: [4, 5, 6],
                      name: 'baz',
                      startTimeUnixNano: span2.startTime,
                      endTimeUnixNano: span2.endTime,
                      attributes: [
                        pb_common.KeyValue(
                            key: 'bool',
                            value: pb_common.AnyValue(boolValue: true))
                      ],
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
                      kind: pb.Span_SpanKind.SPAN_KIND_INTERNAL,
                      links: [
                        pb.Span_Link(
                            traceId: [1, 2, 3],
                            spanId: [7, 8, 9],
                            traceState: '',
                            attributes: [
                              pb_common.KeyValue(
                                  key: 'longKey',
                                  value:
                                      pb_common.AnyValue(stringValue: 'I am '))
                            ])
                      ])
                ],
                scope: pb_common.InstrumentationScope(
                    name: 'library_name', version: 'library_version'))
          ])
    ]);

    final verifyResult = verify(mockClient.post(uri,
        body: captureAnyNamed('body'),
        headers: {'Content-Type': 'application/x-protobuf'}))
      ..called(1);
    final captured = verifyResult.captured;

    final traceRequest = pb_trace_service.ExportTraceServiceRequest.fromBuffer(
        captured[0] as Uint8List);
    expect(traceRequest, equals(expectedBody));
  });

  test('does not send spans when shutdown', () {
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

    sdk.CollectorExporter(uri, httpClient: mockClient)
      ..shutdown()
      ..export([span]);

    verify(mockClient.close()).called(1);
    verifyNever(mockClient.post(uri,
        body: anything, headers: {'Content-Type': 'application/x-protobuf'}));
  });

  test('supplies HTTP headers', () {
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

    sdk.CollectorExporter(uri, httpClient: mockClient, headers: suppliedHeaders)
        .export([span]);

    verify(mockClient.post(uri, body: anything, headers: expectedHeaders))
        .called(1);
  });

  test('does not supply HTTP headers', () {
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

    sdk.CollectorExporter(uri, httpClient: mockClient).export([span]);

    verify(mockClient.post(uri, body: anything, headers: expectedHeaders))
        .called(1);
  });
}
