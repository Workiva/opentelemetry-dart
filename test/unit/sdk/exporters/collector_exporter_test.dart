// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
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
  late MockHTTPClient mockClient;
  final uri =
      Uri.parse('https://h.wdesk.org/s/opentelemetry-collector/v1/traces');

  setUp(() {
    mockClient = MockHTTPClient();
  });

  tearDown(() {
    reset(mockClient);
  });

  test('sends spans', () async {
    final resource =
        sdk.Resource([api.Attribute.fromString('service.name', 'bar')]);
    final instrumentationLibrary =
        sdk.InstrumentationLibrary('library_name', 'library_version');
    final limits = sdk.SpanLimits(maxNumAttributeLength: 5);

    final span1 = Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        resource,
        instrumentationLibrary,
        attributes: [api.Attribute.fromString('foo', 'bar')],
        kind: api.SpanKind.client)
      ..end();
    final span2 = Span(
        'baz',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([10, 11, 12]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        resource,
        instrumentationLibrary,
        limits: limits,
        attributes: [api.Attribute.fromBoolean('bool', true)],
        kind: api.SpanKind.internal,
        links: [
          api.SpanLink(span1.spanContext, attributes: [
            api.Attribute.fromString('longKey',
                'I am very long with maxNumAttributeLength: 5 limitation!')
          ])
        ])
      ..end();

    final expectedBody =
        pb_trace_service.ExportTraceServiceRequest(resourceSpans: [
      pb.ResourceSpans(
          resource: pb_resource.Resource(attributes: [
            pb_common.KeyValue(
                key: 'service.name',
                value: pb_common.AnyValue(stringValue: 'bar'))
          ]),
          instrumentationLibrarySpans: [
            pb.InstrumentationLibrarySpans(
                spans: [
                  pb.Span(
                      traceId: [1, 2, 3],
                      spanId: [7, 8, 9],
                      parentSpanId: [4, 5, 6],
                      name: 'foo',
                      startTimeUnixNano: span1.startTime,
                      endTimeUnixNano: span1.endTime!,
                      attributes: [
                        pb_common.KeyValue(
                            key: 'foo',
                            value: pb_common.AnyValue(stringValue: 'bar'))
                      ],
                      status: pb.Status(
                          code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                          message: null),
                      kind: pb.Span_SpanKind.SPAN_KIND_CLIENT),
                  pb.Span(
                      traceId: [1, 2, 3],
                      spanId: [10, 11, 12],
                      parentSpanId: [4, 5, 6],
                      name: 'baz',
                      startTimeUnixNano: span2.startTime,
                      endTimeUnixNano: span2.endTime!,
                      attributes: [
                        pb_common.KeyValue(
                            key: 'bool',
                            value: pb_common.AnyValue(boolValue: true))
                      ],
                      status: pb.Status(
                          code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                          message: null),
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
                instrumentationLibrary: pb_common.InstrumentationLibrary(
                    name: 'library_name', version: 'library_version'))
          ])
    ]);

    when(mockClient.post(
      uri,
      body: expectedBody,
      headers: {'Content-Type': 'application/x-protobuf'},
    )).thenAnswer((_) => Future.value(Response('', 200)));

    sdk.CollectorExporter(uri, httpClient: mockClient).export([span1, span2]);

    verify(mockClient.post(uri,
        body: expectedBody.writeToBuffer(),
        headers: {'Content-Type': 'application/x-protobuf'})).called(1);
  });

  test('does not send spans when shutdown', () {
    final span = Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationLibrary('library_name', 'library_version'))
      ..end();

    sdk.CollectorExporter(uri, httpClient: mockClient)
      ..shutdown()
      ..export([span]);

    verify(mockClient.close()).called(1);
    verifyNever(mockClient.post(uri,
        body: anything, headers: {'Content-Type': 'application/x-protobuf'}));
  });
}
