///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/trace/v1/trace_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
import '../../../trace/v1/trace.pbjson.dart' as $2;
import '../../../resource/v1/resource.pbjson.dart' as $1;
import '../../../common/v1/common.pbjson.dart' as $0;

@$core.Deprecated('Use exportTraceServiceRequestDescriptor instead')
const ExportTraceServiceRequest$json = const {
  '1': 'ExportTraceServiceRequest',
  '2': const [
    const {'1': 'resource_spans', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.ResourceSpans', '10': 'resourceSpans'},
  ],
};

/// Descriptor for `ExportTraceServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportTraceServiceRequestDescriptor = $convert.base64Decode('ChlFeHBvcnRUcmFjZVNlcnZpY2VSZXF1ZXN0ElIKDnJlc291cmNlX3NwYW5zGAEgAygLMisub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5SZXNvdXJjZVNwYW5zUg1yZXNvdXJjZVNwYW5z');
@$core.Deprecated('Use exportTraceServiceResponseDescriptor instead')
const ExportTraceServiceResponse$json = const {
  '1': 'ExportTraceServiceResponse',
};

/// Descriptor for `ExportTraceServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportTraceServiceResponseDescriptor = $convert.base64Decode('ChpFeHBvcnRUcmFjZVNlcnZpY2VSZXNwb25zZQ==');
const $core.Map<$core.String, $core.dynamic> TraceServiceBase$json = const {
  '1': 'TraceService',
  '2': const [
    const {'1': 'Export', '2': '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceRequest', '3': '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceResponse', '4': const {}},
  ],
};

@$core.Deprecated('Use traceServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> TraceServiceBase$messageJson = const {
  '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceRequest': ExportTraceServiceRequest$json,
  '.opentelemetry.proto.trace.v1.ResourceSpans': $2.ResourceSpans$json,
  '.opentelemetry.proto.resource.v1.Resource': $1.Resource$json,
  '.opentelemetry.proto.common.v1.KeyValue': $0.KeyValue$json,
  '.opentelemetry.proto.common.v1.AnyValue': $0.AnyValue$json,
  '.opentelemetry.proto.common.v1.ArrayValue': $0.ArrayValue$json,
  '.opentelemetry.proto.common.v1.KeyValueList': $0.KeyValueList$json,
  '.opentelemetry.proto.trace.v1.InstrumentationLibrarySpans': $2.InstrumentationLibrarySpans$json,
  '.opentelemetry.proto.common.v1.InstrumentationLibrary': $0.InstrumentationLibrary$json,
  '.opentelemetry.proto.trace.v1.Span': $2.Span$json,
  '.opentelemetry.proto.trace.v1.Span.Event': $2.Span_Event$json,
  '.opentelemetry.proto.trace.v1.Span.Link': $2.Span_Link$json,
  '.opentelemetry.proto.trace.v1.Status': $2.Status$json,
  '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceResponse': ExportTraceServiceResponse$json,
};

/// Descriptor for `TraceService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List traceServiceDescriptor = $convert.base64Decode('CgxUcmFjZVNlcnZpY2USkQEKBkV4cG9ydBJBLm9wZW50ZWxlbWV0cnkucHJvdG8uY29sbGVjdG9yLnRyYWNlLnYxLkV4cG9ydFRyYWNlU2VydmljZVJlcXVlc3QaQi5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbGxlY3Rvci50cmFjZS52MS5FeHBvcnRUcmFjZVNlcnZpY2VSZXNwb25zZSIA');
