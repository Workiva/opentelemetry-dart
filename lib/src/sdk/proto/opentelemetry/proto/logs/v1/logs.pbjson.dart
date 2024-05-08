//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/logs/v1/logs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use severityNumberDescriptor instead')
const SeverityNumber$json = {
  '1': 'SeverityNumber',
  '2': [
    {'1': 'SEVERITY_NUMBER_UNSPECIFIED', '2': 0},
    {'1': 'SEVERITY_NUMBER_TRACE', '2': 1},
    {'1': 'SEVERITY_NUMBER_TRACE2', '2': 2},
    {'1': 'SEVERITY_NUMBER_TRACE3', '2': 3},
    {'1': 'SEVERITY_NUMBER_TRACE4', '2': 4},
    {'1': 'SEVERITY_NUMBER_DEBUG', '2': 5},
    {'1': 'SEVERITY_NUMBER_DEBUG2', '2': 6},
    {'1': 'SEVERITY_NUMBER_DEBUG3', '2': 7},
    {'1': 'SEVERITY_NUMBER_DEBUG4', '2': 8},
    {'1': 'SEVERITY_NUMBER_INFO', '2': 9},
    {'1': 'SEVERITY_NUMBER_INFO2', '2': 10},
    {'1': 'SEVERITY_NUMBER_INFO3', '2': 11},
    {'1': 'SEVERITY_NUMBER_INFO4', '2': 12},
    {'1': 'SEVERITY_NUMBER_WARN', '2': 13},
    {'1': 'SEVERITY_NUMBER_WARN2', '2': 14},
    {'1': 'SEVERITY_NUMBER_WARN3', '2': 15},
    {'1': 'SEVERITY_NUMBER_WARN4', '2': 16},
    {'1': 'SEVERITY_NUMBER_ERROR', '2': 17},
    {'1': 'SEVERITY_NUMBER_ERROR2', '2': 18},
    {'1': 'SEVERITY_NUMBER_ERROR3', '2': 19},
    {'1': 'SEVERITY_NUMBER_ERROR4', '2': 20},
    {'1': 'SEVERITY_NUMBER_FATAL', '2': 21},
    {'1': 'SEVERITY_NUMBER_FATAL2', '2': 22},
    {'1': 'SEVERITY_NUMBER_FATAL3', '2': 23},
    {'1': 'SEVERITY_NUMBER_FATAL4', '2': 24},
  ],
};

/// Descriptor for `SeverityNumber`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List severityNumberDescriptor = $convert.base64Decode(
    'Cg5TZXZlcml0eU51bWJlchIfChtTRVZFUklUWV9OVU1CRVJfVU5TUEVDSUZJRUQQABIZChVTRV'
    'ZFUklUWV9OVU1CRVJfVFJBQ0UQARIaChZTRVZFUklUWV9OVU1CRVJfVFJBQ0UyEAISGgoWU0VW'
    'RVJJVFlfTlVNQkVSX1RSQUNFMxADEhoKFlNFVkVSSVRZX05VTUJFUl9UUkFDRTQQBBIZChVTRV'
    'ZFUklUWV9OVU1CRVJfREVCVUcQBRIaChZTRVZFUklUWV9OVU1CRVJfREVCVUcyEAYSGgoWU0VW'
    'RVJJVFlfTlVNQkVSX0RFQlVHMxAHEhoKFlNFVkVSSVRZX05VTUJFUl9ERUJVRzQQCBIYChRTRV'
    'ZFUklUWV9OVU1CRVJfSU5GTxAJEhkKFVNFVkVSSVRZX05VTUJFUl9JTkZPMhAKEhkKFVNFVkVS'
    'SVRZX05VTUJFUl9JTkZPMxALEhkKFVNFVkVSSVRZX05VTUJFUl9JTkZPNBAMEhgKFFNFVkVSSV'
    'RZX05VTUJFUl9XQVJOEA0SGQoVU0VWRVJJVFlfTlVNQkVSX1dBUk4yEA4SGQoVU0VWRVJJVFlf'
    'TlVNQkVSX1dBUk4zEA8SGQoVU0VWRVJJVFlfTlVNQkVSX1dBUk40EBASGQoVU0VWRVJJVFlfTl'
    'VNQkVSX0VSUk9SEBESGgoWU0VWRVJJVFlfTlVNQkVSX0VSUk9SMhASEhoKFlNFVkVSSVRZX05V'
    'TUJFUl9FUlJPUjMQExIaChZTRVZFUklUWV9OVU1CRVJfRVJST1I0EBQSGQoVU0VWRVJJVFlfTl'
    'VNQkVSX0ZBVEFMEBUSGgoWU0VWRVJJVFlfTlVNQkVSX0ZBVEFMMhAWEhoKFlNFVkVSSVRZX05V'
    'TUJFUl9GQVRBTDMQFxIaChZTRVZFUklUWV9OVU1CRVJfRkFUQUw0EBg=');

@$core.Deprecated('Use logRecordFlagsDescriptor instead')
const LogRecordFlags$json = {
  '1': 'LogRecordFlags',
  '2': [
    {'1': 'LOG_RECORD_FLAGS_DO_NOT_USE', '2': 0},
    {'1': 'LOG_RECORD_FLAGS_TRACE_FLAGS_MASK', '2': 255},
  ],
};

/// Descriptor for `LogRecordFlags`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List logRecordFlagsDescriptor = $convert.base64Decode(
    'Cg5Mb2dSZWNvcmRGbGFncxIfChtMT0dfUkVDT1JEX0ZMQUdTX0RPX05PVF9VU0UQABImCiFMT0'
    'dfUkVDT1JEX0ZMQUdTX1RSQUNFX0ZMQUdTX01BU0sQ/wE=');

@$core.Deprecated('Use logsDataDescriptor instead')
const LogsData$json = {
  '1': 'LogsData',
  '2': [
    {'1': 'resource_logs', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.logs.v1.ResourceLogs', '10': 'resourceLogs'},
  ],
};

/// Descriptor for `LogsData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logsDataDescriptor = $convert.base64Decode(
    'CghMb2dzRGF0YRJOCg1yZXNvdXJjZV9sb2dzGAEgAygLMikub3BlbnRlbGVtZXRyeS5wcm90by'
    '5sb2dzLnYxLlJlc291cmNlTG9nc1IMcmVzb3VyY2VMb2dz');

@$core.Deprecated('Use resourceLogsDescriptor instead')
const ResourceLogs$json = {
  '1': 'ResourceLogs',
  '2': [
    {'1': 'resource', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.resource.v1.Resource', '10': 'resource'},
    {'1': 'scope_logs', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.logs.v1.ScopeLogs', '10': 'scopeLogs'},
    {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
  '9': [
    {'1': 1000, '2': 1001},
  ],
};

/// Descriptor for `ResourceLogs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceLogsDescriptor = $convert.base64Decode(
    'CgxSZXNvdXJjZUxvZ3MSRQoIcmVzb3VyY2UYASABKAsyKS5vcGVudGVsZW1ldHJ5LnByb3RvLn'
    'Jlc291cmNlLnYxLlJlc291cmNlUghyZXNvdXJjZRJFCgpzY29wZV9sb2dzGAIgAygLMiYub3Bl'
    'bnRlbGVtZXRyeS5wcm90by5sb2dzLnYxLlNjb3BlTG9nc1IJc2NvcGVMb2dzEh0KCnNjaGVtYV'
    '91cmwYAyABKAlSCXNjaGVtYVVybEoGCOgHEOkH');

@$core.Deprecated('Use scopeLogsDescriptor instead')
const ScopeLogs$json = {
  '1': 'ScopeLogs',
  '2': [
    {'1': 'scope', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.InstrumentationScope', '10': 'scope'},
    {'1': 'log_records', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.logs.v1.LogRecord', '10': 'logRecords'},
    {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
};

/// Descriptor for `ScopeLogs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scopeLogsDescriptor = $convert.base64Decode(
    'CglTY29wZUxvZ3MSSQoFc2NvcGUYASABKAsyMy5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbW1vbi'
    '52MS5JbnN0cnVtZW50YXRpb25TY29wZVIFc2NvcGUSRwoLbG9nX3JlY29yZHMYAiADKAsyJi5v'
    'cGVudGVsZW1ldHJ5LnByb3RvLmxvZ3MudjEuTG9nUmVjb3JkUgpsb2dSZWNvcmRzEh0KCnNjaG'
    'VtYV91cmwYAyABKAlSCXNjaGVtYVVybA==');

@$core.Deprecated('Use logRecordDescriptor instead')
const LogRecord$json = {
  '1': 'LogRecord',
  '2': [
    {'1': 'time_unix_nano', '3': 1, '4': 1, '5': 6, '10': 'timeUnixNano'},
    {'1': 'observed_time_unix_nano', '3': 11, '4': 1, '5': 6, '10': 'observedTimeUnixNano'},
    {'1': 'severity_number', '3': 2, '4': 1, '5': 14, '6': '.opentelemetry.proto.logs.v1.SeverityNumber', '10': 'severityNumber'},
    {'1': 'severity_text', '3': 3, '4': 1, '5': 9, '10': 'severityText'},
    {'1': 'body', '3': 5, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.AnyValue', '10': 'body'},
    {'1': 'attributes', '3': 6, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    {'1': 'dropped_attributes_count', '3': 7, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
    {'1': 'flags', '3': 8, '4': 1, '5': 7, '10': 'flags'},
    {'1': 'trace_id', '3': 9, '4': 1, '5': 12, '10': 'traceId'},
    {'1': 'span_id', '3': 10, '4': 1, '5': 12, '10': 'spanId'},
  ],
  '9': [
    {'1': 4, '2': 5},
  ],
};

/// Descriptor for `LogRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logRecordDescriptor = $convert.base64Decode(
    'CglMb2dSZWNvcmQSJAoOdGltZV91bml4X25hbm8YASABKAZSDHRpbWVVbml4TmFubxI1ChdvYn'
    'NlcnZlZF90aW1lX3VuaXhfbmFubxgLIAEoBlIUb2JzZXJ2ZWRUaW1lVW5peE5hbm8SVAoPc2V2'
    'ZXJpdHlfbnVtYmVyGAIgASgOMisub3BlbnRlbGVtZXRyeS5wcm90by5sb2dzLnYxLlNldmVyaX'
    'R5TnVtYmVyUg5zZXZlcml0eU51bWJlchIjCg1zZXZlcml0eV90ZXh0GAMgASgJUgxzZXZlcml0'
    'eVRleHQSOwoEYm9keRgFIAEoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLkFueV'
    'ZhbHVlUgRib2R5EkcKCmF0dHJpYnV0ZXMYBiADKAsyJy5vcGVudGVsZW1ldHJ5LnByb3RvLmNv'
    'bW1vbi52MS5LZXlWYWx1ZVIKYXR0cmlidXRlcxI4Chhkcm9wcGVkX2F0dHJpYnV0ZXNfY291bn'
    'QYByABKA1SFmRyb3BwZWRBdHRyaWJ1dGVzQ291bnQSFAoFZmxhZ3MYCCABKAdSBWZsYWdzEhkK'
    'CHRyYWNlX2lkGAkgASgMUgd0cmFjZUlkEhcKB3NwYW5faWQYCiABKAxSBnNwYW5JZEoECAQQBQ'
    '==');

