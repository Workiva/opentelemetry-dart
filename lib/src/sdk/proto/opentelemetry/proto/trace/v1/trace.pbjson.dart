///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/trace/v1/trace.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use spanFlagsDescriptor instead')
const SpanFlags$json = const {
  '1': 'SpanFlags',
  '2': const [
    const {'1': 'SPAN_FLAGS_DO_NOT_USE', '2': 0},
    const {'1': 'SPAN_FLAGS_TRACE_FLAGS_MASK', '2': 255},
  ],
};

/// Descriptor for `SpanFlags`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List spanFlagsDescriptor = $convert.base64Decode('CglTcGFuRmxhZ3MSGQoVU1BBTl9GTEFHU19ET19OT1RfVVNFEAASIAobU1BBTl9GTEFHU19UUkFDRV9GTEFHU19NQVNLEP8B');
@$core.Deprecated('Use tracesDataDescriptor instead')
const TracesData$json = const {
  '1': 'TracesData',
  '2': const [
    const {'1': 'resource_spans', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.ResourceSpans', '10': 'resourceSpans'},
  ],
};

/// Descriptor for `TracesData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tracesDataDescriptor = $convert.base64Decode('CgpUcmFjZXNEYXRhElIKDnJlc291cmNlX3NwYW5zGAEgAygLMisub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5SZXNvdXJjZVNwYW5zUg1yZXNvdXJjZVNwYW5z');
@$core.Deprecated('Use resourceSpansDescriptor instead')
const ResourceSpans$json = const {
  '1': 'ResourceSpans',
  '2': const [
    const {'1': 'resource', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.resource.v1.Resource', '10': 'resource'},
    const {'1': 'scope_spans', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.ScopeSpans', '10': 'scopeSpans'},
    const {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
  '9': const [
    const {'1': 1000, '2': 1001},
  ],
};

/// Descriptor for `ResourceSpans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceSpansDescriptor = $convert.base64Decode('Cg1SZXNvdXJjZVNwYW5zEkUKCHJlc291cmNlGAEgASgLMikub3BlbnRlbGVtZXRyeS5wcm90by5yZXNvdXJjZS52MS5SZXNvdXJjZVIIcmVzb3VyY2USSQoLc2NvcGVfc3BhbnMYAiADKAsyKC5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLlNjb3BlU3BhbnNSCnNjb3BlU3BhbnMSHQoKc2NoZW1hX3VybBgDIAEoCVIJc2NoZW1hVXJsSgYI6AcQ6Qc=');
@$core.Deprecated('Use scopeSpansDescriptor instead')
const ScopeSpans$json = const {
  '1': 'ScopeSpans',
  '2': const [
    const {'1': 'scope', '3': 1, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.InstrumentationScope', '10': 'scope'},
    const {'1': 'spans', '3': 2, '4': 3, '5': 11, '6': '.opentelemetry.proto.trace.v1.Span', '10': 'spans'},
    const {'1': 'schema_url', '3': 3, '4': 1, '5': 9, '10': 'schemaUrl'},
  ],
};

/// Descriptor for `ScopeSpans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scopeSpansDescriptor = $convert.base64Decode('CgpTY29wZVNwYW5zEkkKBXNjb3BlGAEgASgLMjMub3BlbnRlbGVtZXRyeS5wcm90by5jb21tb24udjEuSW5zdHJ1bWVudGF0aW9uU2NvcGVSBXNjb3BlEjgKBXNwYW5zGAIgAygLMiIub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TcGFuUgVzcGFucxIdCgpzY2hlbWFfdXJsGAMgASgJUglzY2hlbWFVcmw=');
@$core.Deprecated('Use spanDescriptor instead')
const Span$json = const {
  '1': 'Span',
  '2': const [
    const {'1': 'trace_id', '3': 1, '4': 1, '5': 12, '10': 'traceId'},
    const {'1': 'span_id', '3': 2, '4': 1, '5': 12, '10': 'spanId'},
    const {'1': 'trace_state', '3': 3, '4': 1, '5': 9, '10': 'traceState'},
    const {'1': 'parent_span_id', '3': 4, '4': 1, '5': 12, '10': 'parentSpanId'},
    const {'1': 'flags', '3': 16, '4': 1, '5': 7, '10': 'flags'},
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
    const {'1': 'flags', '3': 6, '4': 1, '5': 7, '10': 'flags'},
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
final $typed_data.Uint8List spanDescriptor = $convert.base64Decode('CgRTcGFuEhkKCHRyYWNlX2lkGAEgASgMUgd0cmFjZUlkEhcKB3NwYW5faWQYAiABKAxSBnNwYW5JZBIfCgt0cmFjZV9zdGF0ZRgDIAEoCVIKdHJhY2VTdGF0ZRIkCg5wYXJlbnRfc3Bhbl9pZBgEIAEoDFIMcGFyZW50U3BhbklkEhQKBWZsYWdzGBAgASgHUgVmbGFncxISCgRuYW1lGAUgASgJUgRuYW1lEj8KBGtpbmQYBiABKA4yKy5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLlNwYW4uU3BhbktpbmRSBGtpbmQSLwoUc3RhcnRfdGltZV91bml4X25hbm8YByABKAZSEXN0YXJ0VGltZVVuaXhOYW5vEisKEmVuZF90aW1lX3VuaXhfbmFubxgIIAEoBlIPZW5kVGltZVVuaXhOYW5vEkcKCmF0dHJpYnV0ZXMYCSADKAsyJy5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbW1vbi52MS5LZXlWYWx1ZVIKYXR0cmlidXRlcxI4Chhkcm9wcGVkX2F0dHJpYnV0ZXNfY291bnQYCiABKA1SFmRyb3BwZWRBdHRyaWJ1dGVzQ291bnQSQAoGZXZlbnRzGAsgAygLMigub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TcGFuLkV2ZW50UgZldmVudHMSMAoUZHJvcHBlZF9ldmVudHNfY291bnQYDCABKA1SEmRyb3BwZWRFdmVudHNDb3VudBI9CgVsaW5rcxgNIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8udHJhY2UudjEuU3Bhbi5MaW5rUgVsaW5rcxIuChNkcm9wcGVkX2xpbmtzX2NvdW50GA4gASgNUhFkcm9wcGVkTGlua3NDb3VudBI8CgZzdGF0dXMYDyABKAsyJC5vcGVudGVsZW1ldHJ5LnByb3RvLnRyYWNlLnYxLlN0YXR1c1IGc3RhdHVzGsQBCgVFdmVudBIkCg50aW1lX3VuaXhfbmFubxgBIAEoBlIMdGltZVVuaXhOYW5vEhIKBG5hbWUYAiABKAlSBG5hbWUSRwoKYXR0cmlidXRlcxgDIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLktleVZhbHVlUgphdHRyaWJ1dGVzEjgKGGRyb3BwZWRfYXR0cmlidXRlc19jb3VudBgEIAEoDVIWZHJvcHBlZEF0dHJpYnV0ZXNDb3VudBr0AQoETGluaxIZCgh0cmFjZV9pZBgBIAEoDFIHdHJhY2VJZBIXCgdzcGFuX2lkGAIgASgMUgZzcGFuSWQSHwoLdHJhY2Vfc3RhdGUYAyABKAlSCnRyYWNlU3RhdGUSRwoKYXR0cmlidXRlcxgEIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLktleVZhbHVlUgphdHRyaWJ1dGVzEjgKGGRyb3BwZWRfYXR0cmlidXRlc19jb3VudBgFIAEoDVIWZHJvcHBlZEF0dHJpYnV0ZXNDb3VudBIUCgVmbGFncxgGIAEoB1IFZmxhZ3MimQEKCFNwYW5LaW5kEhkKFVNQQU5fS0lORF9VTlNQRUNJRklFRBAAEhYKElNQQU5fS0lORF9JTlRFUk5BTBABEhQKEFNQQU5fS0lORF9TRVJWRVIQAhIUChBTUEFOX0tJTkRfQ0xJRU5UEAMSFgoSU1BBTl9LSU5EX1BST0RVQ0VSEAQSFgoSU1BBTl9LSU5EX0NPTlNVTUVSEAU=');
@$core.Deprecated('Use statusDescriptor instead')
const Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'code', '3': 3, '4': 1, '5': 14, '6': '.opentelemetry.proto.trace.v1.Status.StatusCode', '10': 'code'},
  ],
  '4': const [Status_StatusCode$json],
  '9': const [
    const {'1': 1, '2': 2},
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
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode('CgZTdGF0dXMSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRJDCgRjb2RlGAMgASgOMi8ub3BlbnRlbGVtZXRyeS5wcm90by50cmFjZS52MS5TdGF0dXMuU3RhdHVzQ29kZVIEY29kZSJOCgpTdGF0dXNDb2RlEhUKEVNUQVRVU19DT0RFX1VOU0VUEAASEgoOU1RBVFVTX0NPREVfT0sQARIVChFTVEFUVVNfQ09ERV9FUlJPUhACSgQIARAC');
