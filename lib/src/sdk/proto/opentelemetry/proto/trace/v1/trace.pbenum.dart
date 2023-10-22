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

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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

class Status_DeprecatedStatusCode extends $pb.ProtobufEnum {
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_OK = Status_DeprecatedStatusCode._(0, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_OK');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_CANCELLED = Status_DeprecatedStatusCode._(1, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_CANCELLED');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_UNKNOWN_ERROR = Status_DeprecatedStatusCode._(2, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_UNKNOWN_ERROR');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_INVALID_ARGUMENT = Status_DeprecatedStatusCode._(3, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_INVALID_ARGUMENT');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_DEADLINE_EXCEEDED = Status_DeprecatedStatusCode._(4, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_DEADLINE_EXCEEDED');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_NOT_FOUND = Status_DeprecatedStatusCode._(5, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_NOT_FOUND');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_ALREADY_EXISTS = Status_DeprecatedStatusCode._(6, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_ALREADY_EXISTS');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_PERMISSION_DENIED = Status_DeprecatedStatusCode._(7, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_PERMISSION_DENIED');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_RESOURCE_EXHAUSTED = Status_DeprecatedStatusCode._(8, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_RESOURCE_EXHAUSTED');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_FAILED_PRECONDITION = Status_DeprecatedStatusCode._(9, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_FAILED_PRECONDITION');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_ABORTED = Status_DeprecatedStatusCode._(10, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_ABORTED');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_OUT_OF_RANGE = Status_DeprecatedStatusCode._(11, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_OUT_OF_RANGE');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_UNIMPLEMENTED = Status_DeprecatedStatusCode._(12, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_UNIMPLEMENTED');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_INTERNAL_ERROR = Status_DeprecatedStatusCode._(13, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_INTERNAL_ERROR');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_UNAVAILABLE = Status_DeprecatedStatusCode._(14, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_UNAVAILABLE');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_DATA_LOSS = Status_DeprecatedStatusCode._(15, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_DATA_LOSS');
  static const Status_DeprecatedStatusCode DEPRECATED_STATUS_CODE_UNAUTHENTICATED = Status_DeprecatedStatusCode._(16, _omitEnumNames ? '' : 'DEPRECATED_STATUS_CODE_UNAUTHENTICATED');

  static const $core.List<Status_DeprecatedStatusCode> values = <Status_DeprecatedStatusCode> [
    DEPRECATED_STATUS_CODE_OK,
    DEPRECATED_STATUS_CODE_CANCELLED,
    DEPRECATED_STATUS_CODE_UNKNOWN_ERROR,
    DEPRECATED_STATUS_CODE_INVALID_ARGUMENT,
    DEPRECATED_STATUS_CODE_DEADLINE_EXCEEDED,
    DEPRECATED_STATUS_CODE_NOT_FOUND,
    DEPRECATED_STATUS_CODE_ALREADY_EXISTS,
    DEPRECATED_STATUS_CODE_PERMISSION_DENIED,
    DEPRECATED_STATUS_CODE_RESOURCE_EXHAUSTED,
    DEPRECATED_STATUS_CODE_FAILED_PRECONDITION,
    DEPRECATED_STATUS_CODE_ABORTED,
    DEPRECATED_STATUS_CODE_OUT_OF_RANGE,
    DEPRECATED_STATUS_CODE_UNIMPLEMENTED,
    DEPRECATED_STATUS_CODE_INTERNAL_ERROR,
    DEPRECATED_STATUS_CODE_UNAVAILABLE,
    DEPRECATED_STATUS_CODE_DATA_LOSS,
    DEPRECATED_STATUS_CODE_UNAUTHENTICATED,
  ];

  static final $core.Map<$core.int, Status_DeprecatedStatusCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Status_DeprecatedStatusCode? valueOf($core.int value) => _byValue[value];

  const Status_DeprecatedStatusCode._($core.int v, $core.String n) : super(v, n);
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
