import 'package:http/http.dart' as http;

import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;
import 'opentelemetry/proto/collector/trace/v1/trace_service.pb.dart'
    as pb_trace_service;
import 'opentelemetry/proto/trace/v1/trace.pb.dart' as pb_trace;
import 'opentelemetry/proto/resource/v1/resource.pb.dart' as pb_resource;
import 'opentelemetry/proto/common/v1/common.pb.dart' as pb_common;

class CollectorExporter implements api.SpanExporter {
  Uri uri;
  http.Client client;
  var _isShutdown = false;

  CollectorExporter(this.uri, {http.Client httpClient}) {
    client = httpClient ?? http.Client();
  }

  @override
  void export(List<api.Span> spans) {
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

  /// Group and construct the protobuf equivalent of the given list of [api.Span]s.
  /// Spans are grouped by a trace provider's [sdk.Resource] and a tracer's
  /// [api.InstrumentationLibrary].
  Iterable<pb_trace.ResourceSpans> _spansToProtobuf(List<api.Span> spans) {
    // use a map of maps to group spans by resource and instrumentation library
    final rsm =
        <sdk.Resource, Map<api.InstrumentationLibrary, List<pb_trace.Span>>>{};
    for (final span in spans) {
      final il = rsm[(span as sdk.Span).resource] ??
          <api.InstrumentationLibrary, List<pb_trace.Span>>{};
      il[span.instrumentationLibrary] =
          il[span.instrumentationLibrary] ?? <pb_trace.Span>[]
            ..add(_spanToProtobuf(span as sdk.Span));
      rsm[(span as sdk.Span).resource] = il;
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

  pb_trace.Span _spanToProtobuf(sdk.Span span) {
    pb_trace.Status_StatusCode statusCode;
    switch (span.status.code) {
      case api.StatusCode.unset:
        statusCode = pb_trace.Status_StatusCode.STATUS_CODE_UNSET;
        break;
      case api.StatusCode.error:
        statusCode = pb_trace.Status_StatusCode.STATUS_CODE_ERROR;
        break;
      case api.StatusCode.ok:
        statusCode = pb_trace.Status_StatusCode.STATUS_CODE_OK;
        break;
    }

    return pb_trace.Span(
        traceId: span.spanContext.traceId.get(),
        spanId: span.spanContext.spanId.get(),
        parentSpanId: span.parentSpanId?.get(),
        name: span.name,
        startTimeUnixNano: span.startTime,
        endTimeUnixNano: span.endTime,
        attributes: span.attributes.keys.map((key) => pb_common.KeyValue(
            key: key,
            value: _attributeValueToProtobuf(span.attributes.get(key)))),
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
  void forceFlush() {
    throw UnimplementedError();
  }

  @override
  void shutdown() {
    _isShutdown = true;
  }
}
