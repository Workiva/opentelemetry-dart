@TestOn('vm')
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/collector/trace/v1/trace_service.pb.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/common/v1/common.pb.dart'
    as pb_common;
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/resource/v1/resource.pb.dart'
    as pb_resource;
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/trace/v1/trace.pb.dart'
    as pb;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  MockHTTPClient mockClient;
  final uri =
      Uri.parse('https://h.wdesk.org/s/opentelemetry-collector/v1/traces');

  setUp(() {
    mockClient = MockHTTPClient();
  });

  tearDown(() {
    reset(mockClient);
  });

  test('sends spans', () {
    final resource =
        sdk.Resource([api.Attribute.fromString('service.name', 'bar')]);
    final instrumentationLibrary =
        sdk.InstrumentationLibrary('library_name', 'library_version');
    final span1 = Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        resource,
        instrumentationLibrary,
        attributes: [api.Attribute.fromString('foo', 'bar')])
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
        attributes: [api.Attribute.fromBoolean('bool', true)])
      ..end();

    sdk.CollectorExporter(uri, httpClient: mockClient).export([span1, span2]);

    final expectedBody = ExportTraceServiceRequest(resourceSpans: [
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
                      endTimeUnixNano: span1.endTime,
                      attributes: [
                        pb_common.KeyValue(
                            key: 'foo',
                            value: pb_common.AnyValue(stringValue: 'bar'))
                      ],
                      status: pb.Status(
                          code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                          message: null)),
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
                      status: pb.Status(
                          code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                          message: null))
                ],
                instrumentationLibrary: pb_common.InstrumentationLibrary(
                    name: 'library_name', version: 'library_version'))
          ])
    ]);

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

    verifyNever(mockClient.post(uri,
        body: anything, headers: {'Content-Type': 'application/x-protobuf'}));
  });
}
