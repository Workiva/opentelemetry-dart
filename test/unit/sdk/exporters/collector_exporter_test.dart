import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/collector_exporter.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/collector/trace/v1/trace_service.pb.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/common/v1/common.pb.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/resource/v1/resource.pb.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/opentelemetry/proto/trace/v1/trace.pb.dart'
    as pb;
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart'
    as instrumentation_sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
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
    final tracer = Tracer(
        'bar', [], IdGenerator(), instrumentation_sdk.InstrumentationLibrary());
    final span1 = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.NONE), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        tracer)
      ..end();
    final span2 = Span(
        'baz',
        SpanContext(TraceId([1, 2, 3]), SpanId([10, 11, 12]),
            TraceFlags(api.TraceFlags.NONE), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        tracer)
      ..end();

    CollectorExporter(uri, httpClient: mockClient).export([span1, span2]);

    final expectedBody = ExportTraceServiceRequest(resourceSpans: [
      pb.ResourceSpans(
          resource: Resource(attributes: [
            KeyValue(key: 'service.name', value: AnyValue(stringValue: 'bar'))
          ]),
          instrumentationLibrarySpans: [
            pb.InstrumentationLibrarySpans(spans: [
              pb.Span(
                  traceId: [1, 2, 3],
                  spanId: [7, 8, 9],
                  parentSpanId: [4, 5, 6],
                  name: 'foo',
                  startTimeUnixNano: span1.startTime * 1000,
                  endTimeUnixNano: span1.endTime * 1000,
                  status: pb.Status(
                      code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                      message: null)),
              pb.Span(
                  traceId: [1, 2, 3],
                  spanId: [10, 11, 12],
                  parentSpanId: [4, 5, 6],
                  name: 'baz',
                  startTimeUnixNano: span2.startTime * 1000,
                  endTimeUnixNano: span2.endTime * 1000,
                  status: pb.Status(
                      code: pb.Status_StatusCode.STATUS_CODE_UNSET,
                      message: null))
            ])
          ])
    ]);

    verify(mockClient.post(uri,
        body: expectedBody.writeToBuffer(),
        headers: {'Content-Type': 'application/x-protobuf'})).called(1);
  });

  test('does not send spans when shutdown', () {
    final tracer = Tracer(
        'bar', [], IdGenerator(), instrumentation_sdk.InstrumentationLibrary());
    final span = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.NONE), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        tracer)
      ..end();

    CollectorExporter(uri, httpClient: mockClient)
      ..shutdown()
      ..export([span]);

    verifyNever(mockClient.post(uri,
        body: anything, headers: {'Content-Type': 'application/x-protobuf'}));
  });
}
