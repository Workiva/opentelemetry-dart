//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/trace/v1/trace.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  SpanFlags represents constants used to interpret the
///  Span.flags field, which is protobuf 'fixed32' type and is to
///  be used as bit-fields. Each non-zero value defined in this enum is
///  a bit-mask.  To extract the bit-field, for example, use an
///  expression like:
///
///    (span.flags & SPAN_FLAGS_TRACE_FLAGS_MASK)
///
///  See https://www.w3.org/TR/trace-context-2/#trace-flags for the flag definitions.
///
///  Note that Span flags were introduced in version 1.1 of the
///  OpenTelemetry protocol.  Older Span producers do not set this
///  field, consequently consumers should not rely on the absence of a
///  particular flag bit to indicate the presence of a particular feature.
class SpanFlags extends $pb.ProtobufEnum {
  static const SpanFlags SPAN_FLAGS_DO_NOT_USE = SpanFlags._(0, _omitEnumNames ? '' : 'SPAN_FLAGS_DO_NOT_USE');
  static const SpanFlags SPAN_FLAGS_TRACE_FLAGS_MASK = SpanFlags._(255, _omitEnumNames ? '' : 'SPAN_FLAGS_TRACE_FLAGS_MASK');
  static const SpanFlags SPAN_FLAGS_CONTEXT_HAS_IS_REMOTE_MASK = SpanFlags._(256, _omitEnumNames ? '' : 'SPAN_FLAGS_CONTEXT_HAS_IS_REMOTE_MASK');
  static const SpanFlags SPAN_FLAGS_CONTEXT_IS_REMOTE_MASK = SpanFlags._(512, _omitEnumNames ? '' : 'SPAN_FLAGS_CONTEXT_IS_REMOTE_MASK');

  static const $core.List<SpanFlags> values = <SpanFlags> [
    SPAN_FLAGS_DO_NOT_USE,
    SPAN_FLAGS_TRACE_FLAGS_MASK,
    SPAN_FLAGS_CONTEXT_HAS_IS_REMOTE_MASK,
    SPAN_FLAGS_CONTEXT_IS_REMOTE_MASK,
  ];

  static final $core.Map<$core.int, SpanFlags> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SpanFlags? valueOf($core.int value) => _byValue[value];

  const SpanFlags._($core.int v, $core.String n) : super(v, n);
}

/// SpanKind is the type of span. Can be used to specify additional relationships between spans
/// in addition to a parent/child relationship.
class Span_SpanKind extends $pb.ProtobufEnum {
  static const Span_SpanKind SPAN_KIND_UNSPECIFIED = Span_SpanKind._(0, _omitEnumNames ? '' : 'SPAN_KIND_UNSPECIFIED');
  static const Span_SpanKind SPAN_KIND_INTERNAL = Span_SpanKind._(1, _omitEnumNames ? '' : 'SPAN_KIND_INTERNAL');
  static const Span_SpanKind SPAN_KIND_SERVER = Span_SpanKind._(2, _omitEnumNames ? '' : 'SPAN_KIND_SERVER');
  static const Span_SpanKind SPAN_KIND_CLIENT = Span_SpanKind._(3, _omitEnumNames ? '' : 'SPAN_KIND_CLIENT');
  static const Span_SpanKind SPAN_KIND_PRODUCER = Span_SpanKind._(4, _omitEnumNames ? '' : 'SPAN_KIND_PRODUCER');
  static const Span_SpanKind SPAN_KIND_CONSUMER = Span_SpanKind._(5, _omitEnumNames ? '' : 'SPAN_KIND_CONSUMER');

  static const $core.List<Span_SpanKind> values = <Span_SpanKind> [
    SPAN_KIND_UNSPECIFIED,
    SPAN_KIND_INTERNAL,
    SPAN_KIND_SERVER,
    SPAN_KIND_CLIENT,
    SPAN_KIND_PRODUCER,
    SPAN_KIND_CONSUMER,
  ];

  static final $core.Map<$core.int, Span_SpanKind> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Span_SpanKind? valueOf($core.int value) => _byValue[value];

  const Span_SpanKind._($core.int v, $core.String n) : super(v, n);
}

/// For the semantics of status codes see
/// https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#set-status
class Status_StatusCode extends $pb.ProtobufEnum {
  static const Status_StatusCode STATUS_CODE_UNSET = Status_StatusCode._(0, _omitEnumNames ? '' : 'STATUS_CODE_UNSET');
  static const Status_StatusCode STATUS_CODE_OK = Status_StatusCode._(1, _omitEnumNames ? '' : 'STATUS_CODE_OK');
  static const Status_StatusCode STATUS_CODE_ERROR = Status_StatusCode._(2, _omitEnumNames ? '' : 'STATUS_CODE_ERROR');

  static const $core.List<Status_StatusCode> values = <Status_StatusCode> [
    STATUS_CODE_UNSET,
    STATUS_CODE_OK,
    STATUS_CODE_ERROR,
  ];

  static final $core.Map<$core.int, Status_StatusCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Status_StatusCode? valueOf($core.int value) => _byValue[value];

  const Status_StatusCode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
