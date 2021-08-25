import 'package:http/http.dart' as http;

import '../../../api/trace/span.dart';
import '../../../api/trace/span_status.dart';

import 'opentelemetry/proto/collector/trace/v1/trace_service.pb.dart';
import 'opentelemetry/proto/common/v1/common.pb.dart';
import 'opentelemetry/proto/resource/v1/resource.pb.dart';
import 'opentelemetry/proto/trace/v1/trace.pb.dart' as pb;
import 'span_exporter.dart';

class CollectorExporter implements SpanExporter {
  Uri uri;
  http.Client client;
  var _isShutdown = false;

  CollectorExporter(this.uri, {http.Client httpClient}) {
    client = httpClient ?? http.Client();
  }

  @override
  void export(List<Span> spans) {
    if (_isShutdown) {
      return;
    }

    if (spans.isEmpty) {
      return;
    }

    final pbSpans = <pb.Span>[];
    for (var i = 0; i < spans.length; i++) {
      pbSpans.add(_spanToProtobuf(spans[i]));
    }

    final body = ExportTraceServiceRequest(resourceSpans: [
      pb.ResourceSpans(
          resource: Resource(attributes: [
            KeyValue(
                key: 'service.name',
                value: AnyValue(stringValue: spans[0].tracer.name))
          ]),
          instrumentationLibrarySpans: [
            pb.InstrumentationLibrarySpans(spans: pbSpans)
          ])
    ]);

    client.post(uri,
        body: body.writeToBuffer(),
        headers: {'Content-Type': 'application/x-protobuf'});
  }

  pb.Span _spanToProtobuf(Span span) {
    pb.Status_StatusCode statusCode;

    switch (span.status.code) {
      case StatusCode.UNSET:
        statusCode = pb.Status_StatusCode.STATUS_CODE_UNSET;
        break;
      case StatusCode.ERROR:
        statusCode = pb.Status_StatusCode.STATUS_CODE_ERROR;
        break;
      case StatusCode.OK:
        statusCode = pb.Status_StatusCode.STATUS_CODE_OK;
        break;
    }

    return pb.Span(
        traceId: span.spanContext.traceId,
        spanId: span.spanContext.spanId,
        parentSpanId: span.parentSpanId,
        name: span.name,
        startTimeUnixNano: span.startTime * 1000,
        endTimeUnixNano: span.endTime * 1000,
        status: pb.Status(code: statusCode, message: span.status.description));
  }

  @override
  void shutdown() {
    _isShutdown = true;
  }
}
