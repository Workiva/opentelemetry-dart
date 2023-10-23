///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/trace/v1/trace.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SpanFlags extends $pb.ProtobufEnum {
  static const SpanFlags SPAN_FLAGS_DO_NOT_USE = SpanFlags._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_FLAGS_DO_NOT_USE');
  static const SpanFlags SPAN_FLAGS_TRACE_FLAGS_MASK = SpanFlags._(255, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_FLAGS_TRACE_FLAGS_MASK');

  static const $core.List<SpanFlags> values = <SpanFlags> [
    SPAN_FLAGS_DO_NOT_USE,
    SPAN_FLAGS_TRACE_FLAGS_MASK,
  ];

  static final $core.Map<$core.int, SpanFlags> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SpanFlags? valueOf($core.int value) => _byValue[value];

  const SpanFlags._($core.int v, $core.String n) : super(v, n);
}

class Span_SpanKind extends $pb.ProtobufEnum {
  static const Span_SpanKind SPAN_KIND_UNSPECIFIED = Span_SpanKind._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_KIND_UNSPECIFIED');
  static const Span_SpanKind SPAN_KIND_INTERNAL = Span_SpanKind._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_KIND_INTERNAL');
  static const Span_SpanKind SPAN_KIND_SERVER = Span_SpanKind._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_KIND_SERVER');
  static const Span_SpanKind SPAN_KIND_CLIENT = Span_SpanKind._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_KIND_CLIENT');
  static const Span_SpanKind SPAN_KIND_PRODUCER = Span_SpanKind._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_KIND_PRODUCER');
  static const Span_SpanKind SPAN_KIND_CONSUMER = Span_SpanKind._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPAN_KIND_CONSUMER');

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

class Status_StatusCode extends $pb.ProtobufEnum {
  static const Status_StatusCode STATUS_CODE_UNSET = Status_StatusCode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_CODE_UNSET');
  static const Status_StatusCode STATUS_CODE_OK = Status_StatusCode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_CODE_OK');
  static const Status_StatusCode STATUS_CODE_ERROR = Status_StatusCode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATUS_CODE_ERROR');

  static const $core.List<Status_StatusCode> values = <Status_StatusCode> [
    STATUS_CODE_UNSET,
    STATUS_CODE_OK,
    STATUS_CODE_ERROR,
  ];

  static final $core.Map<$core.int, Status_StatusCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Status_StatusCode? valueOf($core.int value) => _byValue[value];

  const Status_StatusCode._($core.int v, $core.String n) : super(v, n);
}

