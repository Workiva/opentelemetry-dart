import 'package:http/http.dart' as http;

import '../../../api/exporters/span_exporter.dart';
import '../../../api/instrumentation_library.dart';
import '../../../api/resource/resource.dart';
import '../../../api/trace/span.dart';
import '../../../api/trace/span_status.dart';
import 'opentelemetry/proto/collector/trace/v1/trace_service.pb.dart'
    as pb_trace_service;
import 'opentelemetry/proto/trace/v1/trace.pb.dart' as pb_trace;
import 'opentelemetry/proto/resource/v1/resource.pb.dart' as pb_resource;
import 'opentelemetry/proto/common/v1/common.pb.dart' as pb_common;

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

    final body = pb_trace_service.ExportTraceServiceRequest(
        resourceSpans: _spansToProtobuf(spans));

    client.post(uri,
        body: body.writeToBuffer(),
        headers: {'Content-Type': 'application/x-protobuf'});
  }

  /// Group and construct the protobuf equivalent of the given list of [Span]s.
  /// Spans are grouped by a trace provider's [Resource] and a tracer's
  /// [InstrumentationLibrary].
  Iterable<pb_trace.ResourceSpans> _spansToProtobuf(List<Span> spans) {
    // use a map of maps to group spans by resource and instrumentation library
    final rsm = <Resource, Map<InstrumentationLibrary, List<pb_trace.Span>>>{};
    for (final span in spans) {
      final il =
          rsm[span.resource] ?? <InstrumentationLibrary, List<pb_trace.Span>>{};
      il[span.instrumentationLibrary] =
          il[span.instrumentationLibrary] ?? <pb_trace.Span>[]
            ..add(_spanToProtobuf(span));
      rsm[span.resource] = il;
    }

    final rss = <pb_trace.ResourceSpans>[];
    for (final il in rsm.entries) {
      // for each distinct resource, construct the protobuf equivalent
      final attrs = <pb_common.KeyValue>[];
      for (final attr in il.key.attributes.keys) {
        attrs.add(pb_common.KeyValue(
            key: attr,
            value: _attributeValueToProtobuf(il.key.attributes.get(attr))));
      }
      final rs = pb_trace.ResourceSpans(
          resource: pb_resource.Resource(attributes: attrs),
          instrumentationLibrarySpans: []);
      // for each distinct instrumentation library, construct the protobuf equivalent
      for (final ils in il.value.entries) {
        rs.instrumentationLibrarySpans.add(pb_trace.InstrumentationLibrarySpans(
            spans: ils.value,
            instrumentationLibrary: pb_common.InstrumentationLibrary(
                name: ils.key.name, version: ils.key.version)));
      }
      rss.add(rs);
    }
    return rss;
  }

  pb_trace.Span _spanToProtobuf(Span span) {
    pb_trace.Status_StatusCode statusCode;

    switch (span.status.code) {
      case StatusCode.unset:
        statusCode = pb_trace.Status_StatusCode.STATUS_CODE_UNSET;
        break;
      case StatusCode.error:
        statusCode = pb_trace.Status_StatusCode.STATUS_CODE_ERROR;
        break;
      case StatusCode.ok:
        statusCode = pb_trace.Status_StatusCode.STATUS_CODE_OK;
        break;
    }

    return pb_trace.Span(
        traceId: span.spanContext.traceId.get(),
        spanId: span.spanContext.spanId.get(),
        parentSpanId: span.parentSpanId?.get(),
        name: span.name,
        startTimeUnixNano: span.startTime * 1000,
        endTimeUnixNano: span.endTime * 1000,
        status: pb_trace.Status(
            code: statusCode, message: span.status.description));
  }

  pb_common.AnyValue _attributeValueToProtobuf(Object value) {
    switch (value.runtimeType) {
      case String:
        return pb_common.AnyValue(stringValue: value);
      case bool:
        return pb_common.AnyValue(boolValue: value);
      case double:
        return pb_common.AnyValue(doubleValue: value);
      case int:
        return pb_common.AnyValue(intValue: value);
      case List:
        final list = value as List;
        if (list.isNotEmpty) {
          switch (list[0].runtimeType) {
            case String:
              final values = [] as List<pb_common.AnyValue>;
              for (final str in list) {
                values.add(pb_common.AnyValue(stringValue: str));
              }
              return pb_common.AnyValue(
                  arrayValue: pb_common.ArrayValue(values: values));
            case bool:
              final values = [] as List<pb_common.AnyValue>;
              for (final b in list) {
                values.add(pb_common.AnyValue(boolValue: b));
              }
              return pb_common.AnyValue(
                  arrayValue: pb_common.ArrayValue(values: values));
            case double:
              final values = [] as List<pb_common.AnyValue>;
              for (final d in list) {
                values.add(pb_common.AnyValue(doubleValue: d));
              }
              return pb_common.AnyValue(
                  arrayValue: pb_common.ArrayValue(values: values));
            case int:
              final values = [] as List<pb_common.AnyValue>;
              for (final i in list) {
                values.add(pb_common.AnyValue(intValue: i));
              }
              return pb_common.AnyValue(
                  arrayValue: pb_common.ArrayValue(values: values));
          }
        }
    }
    return pb_common.AnyValue();
  }

  @override
  void shutdown() {
    _isShutdown = true;
  }
}
