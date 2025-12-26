// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/trace/v1/trace_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../common/v1/common.pbjson.dart' as $0;
import '../../../resource/v1/resource.pbjson.dart' as $1;
import '../../../trace/v1/trace.pbjson.dart' as $2;

@$core.Deprecated('Use exportTraceServiceRequestDescriptor instead')
const ExportTraceServiceRequest$json = {
  '1': 'ExportTraceServiceRequest',
  '2': [
    {'1': 'resource_spans', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.ResourceSpans', '10': 'resourceSpans'},
  ],
};

/// Descriptor for `ExportTraceServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportTraceServiceRequestDescriptor = $convert.base64Decode(
    'ChlFeHBvcnRUcmFjZVNlcnZpY2VSZXF1ZXN0ElIKDnJlc291cmNlX3NwYW5zGAEgAygLMisub3'
    'BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5SZXNvdXJjZVNwYW5zUg1yZXNvdXJjZVNwYW5z');

@$core.Deprecated('Use exportTraceServiceResponseDescriptor instead')
const ExportTraceServiceResponse$json = {
  '1': 'ExportTraceServiceResponse',
  '2': [
    {'1': 'partial_success', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.collector.trace.v1.ExportTracePartialSuccess', '10': 'partialSuccess'},
  ],
};

/// Descriptor for `ExportTraceServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportTraceServiceResponseDescriptor = $convert.base64Decode(
    'ChpFeHBvcnRUcmFjZVNlcnZpY2VSZXNwb25zZRJqCg9wYXJ0aWFsX3N1Y2Nlc3MYASABKAsyQS'
    '5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbGxlY3Rvci50cmFjZS52MS5FeHBvcnRUcmFjZVBhcnRp'
    'YWxTdWNjZXNzUg5wYXJ0aWFsU3VjY2Vzcw==');

@$core.Deprecated('Use exportTracePartialSuccessDescriptor instead')
const ExportTracePartialSuccess$json = {
  '1': 'ExportTracePartialSuccess',
  '2': [
    {'1': 'rejected_spans', '3': 1, '4': 1, '5': 3, '10': 'rejectedSpans'},
    {'1': 'error_message', '3': 2, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ExportTracePartialSuccess`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportTracePartialSuccessDescriptor = $convert.base64Decode(
    'ChlFeHBvcnRUcmFjZVBhcnRpYWxTdWNjZXNzEiUKDnJlamVjdGVkX3NwYW5zGAEgASgDUg1yZW'
    'plY3RlZFNwYW5zEiMKDWVycm9yX21lc3NhZ2UYAiABKAlSDGVycm9yTWVzc2FnZQ==');

const $core.Map<$core.String, $core.dynamic> TraceServiceBase$json = {
  '1': 'TraceService',
  '2': [
    {'1': 'Export', '2': '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceRequest', '3': '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceResponse', '4': {}},
  ],
};

@$core.Deprecated('Use traceServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> TraceServiceBase$messageJson = {
  '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceRequest': ExportTraceServiceRequest$json,
  '.opentelemetry.proto.trace.v1.ResourceSpans': $2.ResourceSpans$json,
  '.opentelemetry.proto.resource.v1.Resource': $1.Resource$json,
  '.opentelemetry.proto.common.v1.KeyValue': $0.KeyValue$json,
  '.opentelemetry.proto.common.v1.AnyValue': $0.AnyValue$json,
  '.opentelemetry.proto.common.v1.ArrayValue': $0.ArrayValue$json,
  '.opentelemetry.proto.common.v1.KeyValueList': $0.KeyValueList$json,
  '.opentelemetry.proto.trace.v1.ScopeSpans': $2.ScopeSpans$json,
  '.opentelemetry.proto.common.v1.InstrumentationScope': $0.InstrumentationScope$json,
  '.opentelemetry.proto.trace.v1.Span': $2.Span$json,
  '.opentelemetry.proto.trace.v1.Span.Event': $2.Span_Event$json,
  '.opentelemetry.proto.trace.v1.Span.Link': $2.Span_Link$json,
  '.opentelemetry.proto.trace.v1.Status': $2.Status$json,
  '.opentelemetry.proto.collector.trace.v1.ExportTraceServiceResponse': ExportTraceServiceResponse$json,
  '.opentelemetry.proto.collector.trace.v1.ExportTracePartialSuccess': ExportTracePartialSuccess$json,
};

/// Descriptor for `TraceService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List traceServiceDescriptor = $convert.base64Decode(
    'CgxUcmFjZVNlcnZpY2USkQEKBkV4cG9ydBJBLm9wZW50ZWxlbWV0cnkucHJvdG8uY29sbGVjdG'
    '9yLnRyYWNlLnYxLkV4cG9ydFRyYWNlU2VydmljZVJlcXVlc3QaQi5vcGVudGVsZW1ldHJ5LnBy'
    'b3RvLmNvbGxlY3Rvci50cmFjZS52MS5FeHBvcnRUcmFjZVNlcnZpY2VSZXNwb25zZSIA');

