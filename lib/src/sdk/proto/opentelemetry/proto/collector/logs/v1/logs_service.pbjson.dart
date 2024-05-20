//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/logs/v1/logs_service.proto
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
import '../../../logs/v1/logs.pbjson.dart' as $4;
import '../../../resource/v1/resource.pbjson.dart' as $1;

@$core.Deprecated('Use exportLogsServiceRequestDescriptor instead')
const ExportLogsServiceRequest$json = {
  '1': 'ExportLogsServiceRequest',
  '2': [
    {'1': 'resource_logs', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.logs.v1.ResourceLogs', '10': 'resourceLogs'},
  ],
};

/// Descriptor for `ExportLogsServiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportLogsServiceRequestDescriptor = $convert.base64Decode(
    'ChhFeHBvcnRMb2dzU2VydmljZVJlcXVlc3QSTgoNcmVzb3VyY2VfbG9ncxgBIAMoCzIpLm9wZW'
    '50ZWxlbWV0cnkucHJvdG8ubG9ncy52MS5SZXNvdXJjZUxvZ3NSDHJlc291cmNlTG9ncw==');

@$core.Deprecated('Use exportLogsServiceResponseDescriptor instead')
const ExportLogsServiceResponse$json = {
  '1': 'ExportLogsServiceResponse',
  '2': [
    {'1': 'partial_success', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.collector.logs.v1.ExportLogsPartialSuccess', '10': 'partialSuccess'},
  ],
};

/// Descriptor for `ExportLogsServiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportLogsServiceResponseDescriptor = $convert.base64Decode(
    'ChlFeHBvcnRMb2dzU2VydmljZVJlc3BvbnNlEmgKD3BhcnRpYWxfc3VjY2VzcxgBIAEoCzI/Lm'
    '9wZW50ZWxlbWV0cnkucHJvdG8uY29sbGVjdG9yLmxvZ3MudjEuRXhwb3J0TG9nc1BhcnRpYWxT'
    'dWNjZXNzUg5wYXJ0aWFsU3VjY2Vzcw==');

@$core.Deprecated('Use exportLogsPartialSuccessDescriptor instead')
const ExportLogsPartialSuccess$json = {
  '1': 'ExportLogsPartialSuccess',
  '2': [
    {'1': 'rejected_log_records', '3': 1, '4': 1, '5': 3, '10': 'rejectedLogRecords'},
    {'1': 'error_message', '3': 2, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
};

/// Descriptor for `ExportLogsPartialSuccess`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportLogsPartialSuccessDescriptor = $convert.base64Decode(
    'ChhFeHBvcnRMb2dzUGFydGlhbFN1Y2Nlc3MSMAoUcmVqZWN0ZWRfbG9nX3JlY29yZHMYASABKA'
    'NSEnJlamVjdGVkTG9nUmVjb3JkcxIjCg1lcnJvcl9tZXNzYWdlGAIgASgJUgxlcnJvck1lc3Nh'
    'Z2U=');

const $core.Map<$core.String, $core.dynamic> LogsServiceBase$json = {
  '1': 'LogsService',
  '2': [
    {'1': 'Export', '2': '.opentelemetry.proto.collector.logs.v1.ExportLogsServiceRequest', '3': '.opentelemetry.proto.collector.logs.v1.ExportLogsServiceResponse', '4': {}},
  ],
};

@$core.Deprecated('Use logsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> LogsServiceBase$messageJson = {
  '.opentelemetry.proto.collector.logs.v1.ExportLogsServiceRequest': ExportLogsServiceRequest$json,
  '.opentelemetry.proto.logs.v1.ResourceLogs': $4.ResourceLogs$json,
  '.opentelemetry.proto.resource.v1.Resource': $1.Resource$json,
  '.opentelemetry.proto.common.v1.KeyValue': $0.KeyValue$json,
  '.opentelemetry.proto.common.v1.AnyValue': $0.AnyValue$json,
  '.opentelemetry.proto.common.v1.ArrayValue': $0.ArrayValue$json,
  '.opentelemetry.proto.common.v1.KeyValueList': $0.KeyValueList$json,
  '.opentelemetry.proto.logs.v1.ScopeLogs': $4.ScopeLogs$json,
  '.opentelemetry.proto.common.v1.InstrumentationScope': $0.InstrumentationScope$json,
  '.opentelemetry.proto.logs.v1.LogRecord': $4.LogRecord$json,
  '.opentelemetry.proto.collector.logs.v1.ExportLogsServiceResponse': ExportLogsServiceResponse$json,
  '.opentelemetry.proto.collector.logs.v1.ExportLogsPartialSuccess': ExportLogsPartialSuccess$json,
};

/// Descriptor for `LogsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List logsServiceDescriptor = $convert.base64Decode(
    'CgtMb2dzU2VydmljZRKNAQoGRXhwb3J0Ej8ub3BlbnRlbGVtZXRyeS5wcm90by5jb2xsZWN0b3'
    'IubG9ncy52MS5FeHBvcnRMb2dzU2VydmljZVJlcXVlc3QaQC5vcGVudGVsZW1ldHJ5LnByb3Rv'
    'LmNvbGxlY3Rvci5sb2dzLnYxLkV4cG9ydExvZ3NTZXJ2aWNlUmVzcG9uc2UiAA==');

