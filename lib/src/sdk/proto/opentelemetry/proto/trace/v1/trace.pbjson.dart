// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/trace/v1/trace.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use resourceSpansDescriptor instead')
const ResourceSpans$json = {
  '1': 'ResourceSpans',
  '2': [
    {'1': 'resource', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.resource.v1.Resource', '10': 'resource'},
    {'1': 'instrumentation_library_spans', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.InstrumentationLibrarySpans', '10': 'instrumentationLibrarySpans'},
    {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
};

/// Descriptor for `ResourceSpans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceSpansDescriptor = $convert.base64Decode(
    'Cg1SZXNvdXJjZVNwYW5zEkUKCHJlc291cmNlGAEgASgLMikub3BlbnRlbGVtZXRyeS5wcm90by'
    '5yZXNvdXJjZS52MS5SZXNvdXJjZVIIcmVzb3VyY2USfQodaW5zdHJ1bWVudGF0aW9uX2xpYnJh'
    'cnlfc3BhbnMYAiADKAsyOS5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLkluc3RydW1lbn'
    'RhdGlvbkxpYnJhcnlTcGFuc1IbaW5zdHJ1bWVudGF0aW9uTGlicmFyeVNwYW5zEh0KCnNjaGVt'
    'YV91cmwYAyABKAlSCXNjaGVtYVVybA==');

@$core.Deprecated('Use instrumentationLibrarySpansDescriptor instead')
const InstrumentationLibrarySpans$json = {
  '1': 'InstrumentationLibrarySpans',
  '2': [
    {'1': 'instrumentation_library', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.InstrumentationLibrary', '10': 'instrumentationLibrary'},
    {'1': 'spans', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span', '10': 'spans'},
    {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
};

/// Descriptor for `InstrumentationLibrarySpans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentationLibrarySpansDescriptor = $convert.base64Decode(
    'ChtJbnN0cnVtZW50YXRpb25MaWJyYXJ5U3BhbnMSbgoXaW5zdHJ1bWVudGF0aW9uX2xpYnJhcn'
    'kYASABKAsyNS5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbW1vbi52MS5JbnN0cnVtZW50YXRpb25M'
    'aWJyYXJ5UhZpbnN0cnVtZW50YXRpb25MaWJyYXJ5EjgKBXNwYW5zGAIgAygLMiIub3BlbnRlbG'
    'VtZXRyeS5wcm90by50cmFjZS52MS5TcGFuUgVzcGFucxIdCgpzY2hlbWFfdXJsGAMgASgJUglz'
    'Y2hlbWFVcmw=');

@$core.Deprecated('Use spanDescriptor instead')
const Span$json = {
  '1': 'Span',
  '2': [
    {'1': 'trace_id', '3': 1, '4': 1, '5': 12, '10': 'traceId'},
    {'1': 'span_id', '3': 2, '4': 1, '5': 12, '10': 'spanId'},
    {'1': 'trace_state', '3': 3, '4': 1, '5': 9, '10': 'traceState'},
    {'1': 'parent_span_id', '3': 4, '4': 1, '5': 12, '10': 'parentSpanId'},
    {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    {'1': 'kind', '3': 6, '4': 1, '5': 14, '6': '.opentelemetry.proto.trace.v1.Span.SpanKind', '10': 'kind'},
    {'1': 'start_time_unix_nano', '3': 7, '4': 1, '5': 6, '10': 'startTimeUnixNano'},
    {'1': 'end_time_unix_nano', '3': 8, '4': 1, '5': 6, '10': 'endTimeUnixNano'},
    {'1': 'attributes', '3': 9, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    {'1': 'dropped_attributes_count', '3': 10, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
    {'1': 'events', '3': 11, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span.Event', '10': 'events'},
    {'1': 'dropped_events_count', '3': 12, '4': 1, '5': 13, '10': 'droppedEventsCount'},
    {'1': 'links', '3': 13, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span.Link', '10': 'links'},
    {'1': 'dropped_links_count', '3': 14, '4': 1, '5': 13, '10': 'droppedLinksCount'},
    {'1': 'status', '3': 15, '4': 1, '5': 11, '6': '.opentelemetry.proto.trace.v1.Status', '10': 'status'},
  ],
  '3': [Span_Event$json, Span_Link$json],
  '4': [Span_SpanKind$json],
};

@$core.Deprecated('Use spanDescriptor instead')
const Span_Event$json = {
  '1': 'Event',
  '2': [
    {'1': 'time_unix_nano', '3': 1, '4': 1, '5': 6, '10': 'timeUnixNano'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'attributes', '3': 3, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    {'1': 'dropped_attributes_count', '3': 4, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
  ],
};

@$core.Deprecated('Use spanDescriptor instead')
const Span_Link$json = {
  '1': 'Link',
  '2': [
    {'1': 'trace_id', '3': 1, '4': 1, '5': 12, '10': 'traceId'},
    {'1': 'span_id', '3': 2, '4': 1, '5': 12, '10': 'spanId'},
    {'1': 'trace_state', '3': 3, '4': 1, '5': 9, '10': 'traceState'},
    {'1': 'attributes', '3': 4, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    {'1': 'dropped_attributes_count', '3': 5, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
  ],
};

@$core.Deprecated('Use spanDescriptor instead')
const Span_SpanKind$json = {
  '1': 'SpanKind',
  '2': [
    {'1': 'SPAN_KIND_UNSPECIFIED', '2': 0},
    {'1': 'SPAN_KIND_INTERNAL', '2': 1},
    {'1': 'SPAN_KIND_SERVER', '2': 2},
    {'1': 'SPAN_KIND_CLIENT', '2': 3},
    {'1': 'SPAN_KIND_PRODUCER', '2': 4},
    {'1': 'SPAN_KIND_CONSUMER', '2': 5},
  ],
};

/// Descriptor for `Span`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spanDescriptor = $convert.base64Decode(
    'CgRTcGFuEhkKCHRyYWNlX2lkGAEgASgMUgd0cmFjZUlkEhcKB3NwYW5faWQYAiABKAxSBnNwYW'
    '5JZBIfCgt0cmFjZV9zdGF0ZRgDIAEoCVIKdHJhY2VTdGF0ZRIkCg5wYXJlbnRfc3Bhbl9pZBgE'
    'IAEoDFIMcGFyZW50U3BhbklkEhIKBG5hbWUYBSABKAlSBG5hbWUSPwoEa2luZBgGIAEoDjIrLm'
    '9wZW50ZWxlbWV0cnkucHJvdG8udHJhY2UudjEuU3Bhbi5TcGFuS2luZFIEa2luZBIvChRzdGFy'
    'dF90aW1lX3VuaXhfbmFubxgHIAEoBlIRc3RhcnRUaW1lVW5peE5hbm8SKwoSZW5kX3RpbWVfdW'
    '5peF9uYW5vGAggASgGUg9lbmRUaW1lVW5peE5hbm8SRwoKYXR0cmlidXRlcxgJIAMoCzInLm9w'
    'ZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLktleVZhbHVlUgphdHRyaWJ1dGVzEjgKGGRyb3'
    'BwZWRfYXR0cmlidXRlc19jb3VudBgKIAEoDVIWZHJvcHBlZEF0dHJpYnV0ZXNDb3VudBJACgZl'
    'dmVudHMYCyADKAsyKC5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLlNwYW4uRXZlbnRSBm'
    'V2ZW50cxIwChRkcm9wcGVkX2V2ZW50c19jb3VudBgMIAEoDVISZHJvcHBlZEV2ZW50c0NvdW50'
    'Ej0KBWxpbmtzGA0gAygLMicub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TcGFuLkxpbm'
    'tSBWxpbmtzEi4KE2Ryb3BwZWRfbGlua3NfY291bnQYDiABKA1SEWRyb3BwZWRMaW5rc0NvdW50'
    'EjwKBnN0YXR1cxgPIAEoCzIkLm9wZW50ZWxlbWV0cnkucHJvdG8udHJhY2UudjEuU3RhdHVzUg'
    'ZzdGF0dXMaxAEKBUV2ZW50EiQKDnRpbWVfdW5peF9uYW5vGAEgASgGUgx0aW1lVW5peE5hbm8S'
    'EgoEbmFtZRgCIAEoCVIEbmFtZRJHCgphdHRyaWJ1dGVzGAMgAygLMicub3BlbnRlbGVtZXRyeS'
    '5wcm90by5jb21tb24udjEuS2V5VmFsdWVSCmF0dHJpYnV0ZXMSOAoYZHJvcHBlZF9hdHRyaWJ1'
    'dGVzX2NvdW50GAQgASgNUhZkcm9wcGVkQXR0cmlidXRlc0NvdW50Gt4BCgRMaW5rEhkKCHRyYW'
    'NlX2lkGAEgASgMUgd0cmFjZUlkEhcKB3NwYW5faWQYAiABKAxSBnNwYW5JZBIfCgt0cmFjZV9z'
    'dGF0ZRgDIAEoCVIKdHJhY2VTdGF0ZRJHCgphdHRyaWJ1dGVzGAQgAygLMicub3BlbnRlbGVtZX'
    'RyeS5wcm90by5jb21tb24udjEuS2V5VmFsdWVSCmF0dHJpYnV0ZXMSOAoYZHJvcHBlZF9hdHRy'
    'aWJ1dGVzX2NvdW50GAUgASgNUhZkcm9wcGVkQXR0cmlidXRlc0NvdW50IpkBCghTcGFuS2luZB'
    'IZChVTUEFOX0tJTkRfVU5TUEVDSUZJRUQQABIWChJTUEFOX0tJTkRfSU5URVJOQUwQARIUChBT'
    'UEFOX0tJTkRfU0VSVkVSEAISFAoQU1BBTl9LSU5EX0NMSUVOVBADEhYKElNQQU5fS0lORF9QUk'
    '9EVUNFUhAEEhYKElNQQU5fS0lORF9DT05TVU1FUhAF');

@$core.Deprecated('Use statusDescriptor instead')
const Status$json = {
  '1': 'Status',
  '2': [
    {
      '1': 'deprecated_code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.opentelemetry.proto.trace.v1.Status.DeprecatedStatusCode',
      '8': {'3': true},
      '10': 'deprecatedCode',
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'code', '3': 3, '4': 1, '5': 14, '6': '.opentelemetry.proto.trace.v1.Status.StatusCode', '10': 'code'},
  ],
  '4': [Status_DeprecatedStatusCode$json, Status_StatusCode$json],
};

@$core.Deprecated('Use statusDescriptor instead')
const Status_DeprecatedStatusCode$json = {
  '1': 'DeprecatedStatusCode',
  '2': [
    {'1': 'DEPRECATED_STATUS_CODE_OK', '2': 0},
    {'1': 'DEPRECATED_STATUS_CODE_CANCELLED', '2': 1},
    {'1': 'DEPRECATED_STATUS_CODE_UNKNOWN_ERROR', '2': 2},
    {'1': 'DEPRECATED_STATUS_CODE_INVALID_ARGUMENT', '2': 3},
    {'1': 'DEPRECATED_STATUS_CODE_DEADLINE_EXCEEDED', '2': 4},
    {'1': 'DEPRECATED_STATUS_CODE_NOT_FOUND', '2': 5},
    {'1': 'DEPRECATED_STATUS_CODE_ALREADY_EXISTS', '2': 6},
    {'1': 'DEPRECATED_STATUS_CODE_PERMISSION_DENIED', '2': 7},
    {'1': 'DEPRECATED_STATUS_CODE_RESOURCE_EXHAUSTED', '2': 8},
    {'1': 'DEPRECATED_STATUS_CODE_FAILED_PRECONDITION', '2': 9},
    {'1': 'DEPRECATED_STATUS_CODE_ABORTED', '2': 10},
    {'1': 'DEPRECATED_STATUS_CODE_OUT_OF_RANGE', '2': 11},
    {'1': 'DEPRECATED_STATUS_CODE_UNIMPLEMENTED', '2': 12},
    {'1': 'DEPRECATED_STATUS_CODE_INTERNAL_ERROR', '2': 13},
    {'1': 'DEPRECATED_STATUS_CODE_UNAVAILABLE', '2': 14},
    {'1': 'DEPRECATED_STATUS_CODE_DATA_LOSS', '2': 15},
    {'1': 'DEPRECATED_STATUS_CODE_UNAUTHENTICATED', '2': 16},
  ],
};

@$core.Deprecated('Use statusDescriptor instead')
const Status_StatusCode$json = {
  '1': 'StatusCode',
  '2': [
    {'1': 'STATUS_CODE_UNSET', '2': 0},
    {'1': 'STATUS_CODE_OK', '2': 1},
    {'1': 'STATUS_CODE_ERROR', '2': 2},
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode(
    'CgZTdGF0dXMSZgoPZGVwcmVjYXRlZF9jb2RlGAEgASgOMjkub3BlbnRlbGVtZXRyeS5wcm90by'
    '50cmFjZS52MS5TdGF0dXMuRGVwcmVjYXRlZFN0YXR1c0NvZGVCAhgBUg5kZXByZWNhdGVkQ29k'
    'ZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkMKBGNvZGUYAyABKA4yLy5vcGVudGVsZW1ldH'
    'J5LnByb3RvLnRyYWNlLnYxLlN0YXR1cy5TdGF0dXNDb2RlUgRjb2RlItoFChREZXByZWNhdGVk'
    'U3RhdHVzQ29kZRIdChlERVBSRUNBVEVEX1NUQVRVU19DT0RFX09LEAASJAogREVQUkVDQVRFRF'
    '9TVEFUVVNfQ09ERV9DQU5DRUxMRUQQARIoCiRERVBSRUNBVEVEX1NUQVRVU19DT0RFX1VOS05P'
    'V05fRVJST1IQAhIrCidERVBSRUNBVEVEX1NUQVRVU19DT0RFX0lOVkFMSURfQVJHVU1FTlQQAx'
    'IsCihERVBSRUNBVEVEX1NUQVRVU19DT0RFX0RFQURMSU5FX0VYQ0VFREVEEAQSJAogREVQUkVD'
    'QVRFRF9TVEFUVVNfQ09ERV9OT1RfRk9VTkQQBRIpCiVERVBSRUNBVEVEX1NUQVRVU19DT0RFX0'
    'FMUkVBRFlfRVhJU1RTEAYSLAooREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9QRVJNSVNTSU9OX0RF'
    'TklFRBAHEi0KKURFUFJFQ0FURURfU1RBVFVTX0NPREVfUkVTT1VSQ0VfRVhIQVVTVEVEEAgSLg'
    'oqREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9GQUlMRURfUFJFQ09ORElUSU9OEAkSIgoeREVQUkVD'
    'QVRFRF9TVEFUVVNfQ09ERV9BQk9SVEVEEAoSJwojREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9PVV'
    'RfT0ZfUkFOR0UQCxIoCiRERVBSRUNBVEVEX1NUQVRVU19DT0RFX1VOSU1QTEVNRU5URUQQDBIp'
    'CiVERVBSRUNBVEVEX1NUQVRVU19DT0RFX0lOVEVSTkFMX0VSUk9SEA0SJgoiREVQUkVDQVRFRF'
    '9TVEFUVVNfQ09ERV9VTkFWQUlMQUJMRRAOEiQKIERFUFJFQ0FURURfU1RBVFVTX0NPREVfREFU'
    'QV9MT1NTEA8SKgomREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9VTkFVVEhFTlRJQ0FURUQQECJOCg'
    'pTdGF0dXNDb2RlEhUKEVNUQVRVU19DT0RFX1VOU0VUEAASEgoOU1RBVFVTX0NPREVfT0sQARIV'
    'ChFTVEFUVVNfQ09ERV9FUlJPUhAC');

