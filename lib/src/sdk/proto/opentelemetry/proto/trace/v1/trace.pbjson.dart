///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/trace/v1/trace.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use resourceSpansDescriptor instead')
const ResourceSpans$json = const {
  '1': 'ResourceSpans',
  '2': const [
    const {'1': 'resource', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.resource.v1.Resource', '10': 'resource'},
    const {'1': 'instrumentation_library_spans', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.InstrumentationLibrarySpans', '10': 'instrumentationLibrarySpans'},
    const {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
};

/// Descriptor for `ResourceSpans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceSpansDescriptor = $convert.base64Decode('Cg1SZXNvdXJjZVNwYW5zEkUKCHJlc291cmNlGAEgASgLMikub3BlbnRlbGVtZXRyeS5wcm90by5yZXNvdXJjZS52MS5SZXNvdXJjZVIIcmVzb3VyY2USfQodaW5zdHJ1bWVudGF0aW9uX2xpYnJhcnlfc3BhbnMYAiADKAsyOS5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLkluc3RydW1lbnRhdGlvbkxpYnJhcnlTcGFuc1IbaW5zdHJ1bWVudGF0aW9uTGlicmFyeVNwYW5zEh0KCnNjaGVtYV91cmwYAyABKAlSCXNjaGVtYVVybA==');
@$core.Deprecated('Use instrumentationLibrarySpansDescriptor instead')
const InstrumentationLibrarySpans$json = const {
  '1': 'InstrumentationLibrarySpans',
  '2': const [
    const {'1': 'instrumentation_library', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.InstrumentationLibrary', '10': 'instrumentationLibrary'},
    const {'1': 'spans', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span', '10': 'spans'},
    const {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
};

/// Descriptor for `InstrumentationLibrarySpans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentationLibrarySpansDescriptor = $convert.base64Decode('ChtJbnN0cnVtZW50YXRpb25MaWJyYXJ5U3BhbnMSbgoXaW5zdHJ1bWVudGF0aW9uX2xpYnJhcnkYASABKAsyNS5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbW1vbi52MS5JbnN0cnVtZW50YXRpb25MaWJyYXJ5UhZpbnN0cnVtZW50YXRpb25MaWJyYXJ5EjgKBXNwYW5zGAIgAygLMiIub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TcGFuUgVzcGFucxIdCgpzY2hlbWFfdXJsGAMgASgJUglzY2hlbWFVcmw=');
@$core.Deprecated('Use spanDescriptor instead')
const Span$json = const {
  '1': 'Span',
  '2': const [
    const {'1': 'trace_id', '3': 1, '4': 1, '5': 12, '10': 'traceId'},
    const {'1': 'span_id', '3': 2, '4': 1, '5': 12, '10': 'spanId'},
    const {'1': 'trace_state', '3': 3, '4': 1, '5': 9, '10': 'traceState'},
    const {'1': 'parent_span_id', '3': 4, '4': 1, '5': 12, '10': 'parentSpanId'},
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'kind', '3': 6, '4': 1, '5': 14, '6': '.opentelemetry.proto.trace.v1.Span.SpanKind', '10': 'kind'},
    const {'1': 'start_time_unix_nano', '3': 7, '4': 1, '5': 6, '10': 'startTimeUnixNano'},
    const {'1': 'end_time_unix_nano', '3': 8, '4': 1, '5': 6, '10': 'endTimeUnixNano'},
    const {'1': 'attributes', '3': 9, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    const {'1': 'dropped_attributes_count', '3': 10, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
    const {'1': 'events', '3': 11, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span.Event', '10': 'events'},
    const {'1': 'dropped_events_count', '3': 12, '4': 1, '5': 13, '10': 'droppedEventsCount'},
    const {'1': 'links', '3': 13, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span.Link', '10': 'links'},
    const {'1': 'dropped_links_count', '3': 14, '4': 1, '5': 13, '10': 'droppedLinksCount'},
    const {'1': 'status', '3': 15, '4': 1, '5': 11, '6': '.opentelemetry.proto.trace.v1.Status', '10': 'status'},
  ],
  '3': const [Span_Event$json, Span_Link$json],
  '4': const [Span_SpanKind$json],
};

@$core.Deprecated('Use spanDescriptor instead')
const Span_Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'time_unix_nano', '3': 1, '4': 1, '5': 6, '10': 'timeUnixNano'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'attributes', '3': 3, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    const {'1': 'dropped_attributes_count', '3': 4, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
  ],
};

@$core.Deprecated('Use spanDescriptor instead')
const Span_Link$json = const {
  '1': 'Link',
  '2': const [
    const {'1': 'trace_id', '3': 1, '4': 1, '5': 12, '10': 'traceId'},
    const {'1': 'span_id', '3': 2, '4': 1, '5': 12, '10': 'spanId'},
    const {'1': 'trace_state', '3': 3, '4': 1, '5': 9, '10': 'traceState'},
    const {'1': 'attributes', '3': 4, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    const {'1': 'dropped_attributes_count', '3': 5, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
  ],
};

@$core.Deprecated('Use spanDescriptor instead')
const Span_SpanKind$json = const {
  '1': 'SpanKind',
  '2': const [
    const {'1': 'SPAN_KIND_UNSPECIFIED', '2': 0},
    const {'1': 'SPAN_KIND_INTERNAL', '2': 1},
    const {'1': 'SPAN_KIND_SERVER', '2': 2},
    const {'1': 'SPAN_KIND_CLIENT', '2': 3},
    const {'1': 'SPAN_KIND_PRODUCER', '2': 4},
    const {'1': 'SPAN_KIND_CONSUMER', '2': 5},
  ],
};

/// Descriptor for `Span`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spanDescriptor = $convert.base64Decode('CgRTcGFuEhkKCHRyYWNlX2lkGAEgASgMUgd0cmFjZUlkEhcKB3NwYW5faWQYAiABKAxSBnNwYW5JZBIfCgt0cmFjZV9zdGF0ZRgDIAEoCVIKdHJhY2VTdGF0ZRIkCg5wYXJlbnRfc3Bhbl9pZBgEIAEoDFIMcGFyZW50U3BhbklkEhIKBG5hbWUYBSABKAlSBG5hbWUSPwoEa2luZBgGIAEoDjIrLm9wZW50ZWxlbWV0cnkucHJvdG8udHJhY2UudjEuU3Bhbi5TcGFuS2luZFIEa2luZBIvChRzdGFydF90aW1lX3VuaXhfbmFubxgHIAEoBlIRc3RhcnRUaW1lVW5peE5hbm8SKwoSZW5kX3RpbWVfdW5peF9uYW5vGAggASgGUg9lbmRUaW1lVW5peE5hbm8SRwoKYXR0cmlidXRlcxgJIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLktleVZhbHVlUgphdHRyaWJ1dGVzEjgKGGRyb3BwZWRfYXR0cmlidXRlc19jb3VudBgKIAEoDVIWZHJvcHBlZEF0dHJpYnV0ZXNDb3VudBJACgZldmVudHMYCyADKAsyKC5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLlNwYW4uRXZlbnRSBmV2ZW50cxIwChRkcm9wcGVkX2V2ZW50c19jb3VudBgMIAEoDVISZHJvcHBlZEV2ZW50c0NvdW50Ej0KBWxpbmtzGA0gAygLMicub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TcGFuLkxpbmtSBWxpbmtzEi4KE2Ryb3BwZWRfbGlua3NfY291bnQYDiABKA1SEWRyb3BwZWRMaW5rc0NvdW50EjwKBnN0YXR1cxgPIAEoCzIkLm9wZW50ZWxlbWV0cnkucHJvdG8udHJhY2UudjEuU3RhdHVzUgZzdGF0dXMaxAEKBUV2ZW50EiQKDnRpbWVfdW5peF9uYW5vGAEgASgGUgx0aW1lVW5peE5hbm8SEgoEbmFtZRgCIAEoCVIEbmFtZRJHCgphdHRyaWJ1dGVzGAMgAygLMicub3BlbnRlbGVtZXRyeS5wcm90by5jb21tb24udjEuS2V5VmFsdWVSCmF0dHJpYnV0ZXMSOAoYZHJvcHBlZF9hdHRyaWJ1dGVzX2NvdW50GAQgASgNUhZkcm9wcGVkQXR0cmlidXRlc0NvdW50Gt4BCgRMaW5rEhkKCHRyYWNlX2lkGAEgASgMUgd0cmFjZUlkEhcKB3NwYW5faWQYAiABKAxSBnNwYW5JZBIfCgt0cmFjZV9zdGF0ZRgDIAEoCVIKdHJhY2VTdGF0ZRJHCgphdHRyaWJ1dGVzGAQgAygLMicub3BlbnRlbGVtZXRyeS5wcm90by5jb21tb24udjEuS2V5VmFsdWVSCmF0dHJpYnV0ZXMSOAoYZHJvcHBlZF9hdHRyaWJ1dGVzX2NvdW50GAUgASgNUhZkcm9wcGVkQXR0cmlidXRlc0NvdW50IpkBCghTcGFuS2luZBIZChVTUEFOX0tJTkRfVU5TUEVDSUZJRUQQABIWChJTUEFOX0tJTkRfSU5URVJOQUwQARIUChBTUEFOX0tJTkRfU0VSVkVSEAISFAoQU1BBTl9LSU5EX0NMSUVOVBADEhYKElNQQU5fS0lORF9QUk9EVUNFUhAEEhYKElNQQU5fS0lORF9DT05TVU1FUhAF');
@$core.Deprecated('Use statusDescriptor instead')
const Status$json = const {
  '1': 'Status',
  '2': const [
    const {
      '1': 'deprecated_code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.opentelemetry.proto.trace.v1.Status.DeprecatedStatusCode',
      '8': const {'3': true},
      '10': 'deprecatedCode',
    },
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'code', '3': 3, '4': 1, '5': 14, '6': '.opentelemetry.proto.trace.v1.Status.StatusCode', '10': 'code'},
  ],
  '4': const [Status_DeprecatedStatusCode$json, Status_StatusCode$json],
};

@$core.Deprecated('Use statusDescriptor instead')
const Status_DeprecatedStatusCode$json = const {
  '1': 'DeprecatedStatusCode',
  '2': const [
    const {'1': 'DEPRECATED_STATUS_CODE_OK', '2': 0},
    const {'1': 'DEPRECATED_STATUS_CODE_CANCELLED', '2': 1},
    const {'1': 'DEPRECATED_STATUS_CODE_UNKNOWN_ERROR', '2': 2},
    const {'1': 'DEPRECATED_STATUS_CODE_INVALID_ARGUMENT', '2': 3},
    const {'1': 'DEPRECATED_STATUS_CODE_DEADLINE_EXCEEDED', '2': 4},
    const {'1': 'DEPRECATED_STATUS_CODE_NOT_FOUND', '2': 5},
    const {'1': 'DEPRECATED_STATUS_CODE_ALREADY_EXISTS', '2': 6},
    const {'1': 'DEPRECATED_STATUS_CODE_PERMISSION_DENIED', '2': 7},
    const {'1': 'DEPRECATED_STATUS_CODE_RESOURCE_EXHAUSTED', '2': 8},
    const {'1': 'DEPRECATED_STATUS_CODE_FAILED_PRECONDITION', '2': 9},
    const {'1': 'DEPRECATED_STATUS_CODE_ABORTED', '2': 10},
    const {'1': 'DEPRECATED_STATUS_CODE_OUT_OF_RANGE', '2': 11},
    const {'1': 'DEPRECATED_STATUS_CODE_UNIMPLEMENTED', '2': 12},
    const {'1': 'DEPRECATED_STATUS_CODE_INTERNAL_ERROR', '2': 13},
    const {'1': 'DEPRECATED_STATUS_CODE_UNAVAILABLE', '2': 14},
    const {'1': 'DEPRECATED_STATUS_CODE_DATA_LOSS', '2': 15},
    const {'1': 'DEPRECATED_STATUS_CODE_UNAUTHENTICATED', '2': 16},
  ],
};

@$core.Deprecated('Use statusDescriptor instead')
const Status_StatusCode$json = const {
  '1': 'StatusCode',
  '2': const [
    const {'1': 'STATUS_CODE_UNSET', '2': 0},
    const {'1': 'STATUS_CODE_OK', '2': 1},
    const {'1': 'STATUS_CODE_ERROR', '2': 2},
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode('CgZTdGF0dXMSZgoPZGVwcmVjYXRlZF9jb2RlGAEgASgOMjkub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TdGF0dXMuRGVwcmVjYXRlZFN0YXR1c0NvZGVCAhgBUg5kZXByZWNhdGVkQ29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEkMKBGNvZGUYAyABKA4yLy5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLlN0YXR1cy5TdGF0dXNDb2RlUgRjb2RlItoFChREZXByZWNhdGVkU3RhdHVzQ29kZRIdChlERVBSRUNBVEVEX1NUQVRVU19DT0RFX09LEAASJAogREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9DQU5DRUxMRUQQARIoCiRERVBSRUNBVEVEX1NUQVRVU19DT0RFX1VOS05PV05fRVJST1IQAhIrCidERVBSRUNBVEVEX1NUQVRVU19DT0RFX0lOVkFMSURfQVJHVU1FTlQQAxIsCihERVBSRUNBVEVEX1NUQVRVU19DT0RFX0RFQURMSU5FX0VYQ0VFREVEEAQSJAogREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9OT1RfRk9VTkQQBRIpCiVERVBSRUNBVEVEX1NUQVRVU19DT0RFX0FMUkVBRFlfRVhJU1RTEAYSLAooREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9QRVJNSVNTSU9OX0RFTklFRBAHEi0KKURFUFJFQ0FURURfU1RBVFVTX0NPREVfUkVTT1VSQ0VfRVhIQVVTVEVEEAgSLgoqREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9GQUlMRURfUFJFQ09ORElUSU9OEAkSIgoeREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9BQk9SVEVEEAoSJwojREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9PVVRfT0ZfUkFOR0UQCxIoCiRERVBSRUNBVEVEX1NUQVRVU19DT0RFX1VOSU1QTEVNRU5URUQQDBIpCiVERVBSRUNBVEVEX1NUQVRVU19DT0RFX0lOVEVSTkFMX0VSUk9SEA0SJgoiREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9VTkFWQUlMQUJMRRAOEiQKIERFUFJFQ0FURURfU1RBVFVTX0NPREVfREFUQV9MT1NTEA8SKgomREVQUkVDQVRFRF9TVEFUVVNfQ09ERV9VTkFVVEhFTlRJQ0FURUQQECJOCgpTdGF0dXNDb2RlEhUKEVNUQVRVU19DT0RFX1VOU0VUEAASEgoOU1RBVFVTX0NPREVfT0sQARIVChFTVEFUVVNfQ09ERV9FUlJPUhAC');
