//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/logs/v1/logs.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Possible values for LogRecord.SeverityNumber.
class SeverityNumber extends $pb.ProtobufEnum {
  static const SeverityNumber SEVERITY_NUMBER_UNSPECIFIED = SeverityNumber._(0, _omitEnumNames ? '' : 'SEVERITY_NUMBER_UNSPECIFIED');
  static const SeverityNumber SEVERITY_NUMBER_TRACE = SeverityNumber._(1, _omitEnumNames ? '' : 'SEVERITY_NUMBER_TRACE');
  static const SeverityNumber SEVERITY_NUMBER_TRACE2 = SeverityNumber._(2, _omitEnumNames ? '' : 'SEVERITY_NUMBER_TRACE2');
  static const SeverityNumber SEVERITY_NUMBER_TRACE3 = SeverityNumber._(3, _omitEnumNames ? '' : 'SEVERITY_NUMBER_TRACE3');
  static const SeverityNumber SEVERITY_NUMBER_TRACE4 = SeverityNumber._(4, _omitEnumNames ? '' : 'SEVERITY_NUMBER_TRACE4');
  static const SeverityNumber SEVERITY_NUMBER_DEBUG = SeverityNumber._(5, _omitEnumNames ? '' : 'SEVERITY_NUMBER_DEBUG');
  static const SeverityNumber SEVERITY_NUMBER_DEBUG2 = SeverityNumber._(6, _omitEnumNames ? '' : 'SEVERITY_NUMBER_DEBUG2');
  static const SeverityNumber SEVERITY_NUMBER_DEBUG3 = SeverityNumber._(7, _omitEnumNames ? '' : 'SEVERITY_NUMBER_DEBUG3');
  static const SeverityNumber SEVERITY_NUMBER_DEBUG4 = SeverityNumber._(8, _omitEnumNames ? '' : 'SEVERITY_NUMBER_DEBUG4');
  static const SeverityNumber SEVERITY_NUMBER_INFO = SeverityNumber._(9, _omitEnumNames ? '' : 'SEVERITY_NUMBER_INFO');
  static const SeverityNumber SEVERITY_NUMBER_INFO2 = SeverityNumber._(10, _omitEnumNames ? '' : 'SEVERITY_NUMBER_INFO2');
  static const SeverityNumber SEVERITY_NUMBER_INFO3 = SeverityNumber._(11, _omitEnumNames ? '' : 'SEVERITY_NUMBER_INFO3');
  static const SeverityNumber SEVERITY_NUMBER_INFO4 = SeverityNumber._(12, _omitEnumNames ? '' : 'SEVERITY_NUMBER_INFO4');
  static const SeverityNumber SEVERITY_NUMBER_WARN = SeverityNumber._(13, _omitEnumNames ? '' : 'SEVERITY_NUMBER_WARN');
  static const SeverityNumber SEVERITY_NUMBER_WARN2 = SeverityNumber._(14, _omitEnumNames ? '' : 'SEVERITY_NUMBER_WARN2');
  static const SeverityNumber SEVERITY_NUMBER_WARN3 = SeverityNumber._(15, _omitEnumNames ? '' : 'SEVERITY_NUMBER_WARN3');
  static const SeverityNumber SEVERITY_NUMBER_WARN4 = SeverityNumber._(16, _omitEnumNames ? '' : 'SEVERITY_NUMBER_WARN4');
  static const SeverityNumber SEVERITY_NUMBER_ERROR = SeverityNumber._(17, _omitEnumNames ? '' : 'SEVERITY_NUMBER_ERROR');
  static const SeverityNumber SEVERITY_NUMBER_ERROR2 = SeverityNumber._(18, _omitEnumNames ? '' : 'SEVERITY_NUMBER_ERROR2');
  static const SeverityNumber SEVERITY_NUMBER_ERROR3 = SeverityNumber._(19, _omitEnumNames ? '' : 'SEVERITY_NUMBER_ERROR3');
  static const SeverityNumber SEVERITY_NUMBER_ERROR4 = SeverityNumber._(20, _omitEnumNames ? '' : 'SEVERITY_NUMBER_ERROR4');
  static const SeverityNumber SEVERITY_NUMBER_FATAL = SeverityNumber._(21, _omitEnumNames ? '' : 'SEVERITY_NUMBER_FATAL');
  static const SeverityNumber SEVERITY_NUMBER_FATAL2 = SeverityNumber._(22, _omitEnumNames ? '' : 'SEVERITY_NUMBER_FATAL2');
  static const SeverityNumber SEVERITY_NUMBER_FATAL3 = SeverityNumber._(23, _omitEnumNames ? '' : 'SEVERITY_NUMBER_FATAL3');
  static const SeverityNumber SEVERITY_NUMBER_FATAL4 = SeverityNumber._(24, _omitEnumNames ? '' : 'SEVERITY_NUMBER_FATAL4');

  static const $core.List<SeverityNumber> values = <SeverityNumber> [
    SEVERITY_NUMBER_UNSPECIFIED,
    SEVERITY_NUMBER_TRACE,
    SEVERITY_NUMBER_TRACE2,
    SEVERITY_NUMBER_TRACE3,
    SEVERITY_NUMBER_TRACE4,
    SEVERITY_NUMBER_DEBUG,
    SEVERITY_NUMBER_DEBUG2,
    SEVERITY_NUMBER_DEBUG3,
    SEVERITY_NUMBER_DEBUG4,
    SEVERITY_NUMBER_INFO,
    SEVERITY_NUMBER_INFO2,
    SEVERITY_NUMBER_INFO3,
    SEVERITY_NUMBER_INFO4,
    SEVERITY_NUMBER_WARN,
    SEVERITY_NUMBER_WARN2,
    SEVERITY_NUMBER_WARN3,
    SEVERITY_NUMBER_WARN4,
    SEVERITY_NUMBER_ERROR,
    SEVERITY_NUMBER_ERROR2,
    SEVERITY_NUMBER_ERROR3,
    SEVERITY_NUMBER_ERROR4,
    SEVERITY_NUMBER_FATAL,
    SEVERITY_NUMBER_FATAL2,
    SEVERITY_NUMBER_FATAL3,
    SEVERITY_NUMBER_FATAL4,
  ];

  static final $core.Map<$core.int, SeverityNumber> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SeverityNumber? valueOf($core.int value) => _byValue[value];

  const SeverityNumber._($core.int v, $core.String n) : super(v, n);
}

///  LogRecordFlags represents constants used to interpret the
///  LogRecord.flags field, which is protobuf 'fixed32' type and is to
///  be used as bit-fields. Each non-zero value defined in this enum is
///  a bit-mask.  To extract the bit-field, for example, use an
///  expression like:
///
///    (logRecord.flags & LOG_RECORD_FLAGS_TRACE_FLAGS_MASK)
class LogRecordFlags extends $pb.ProtobufEnum {
  static const LogRecordFlags LOG_RECORD_FLAGS_DO_NOT_USE = LogRecordFlags._(0, _omitEnumNames ? '' : 'LOG_RECORD_FLAGS_DO_NOT_USE');
  static const LogRecordFlags LOG_RECORD_FLAGS_TRACE_FLAGS_MASK = LogRecordFlags._(255, _omitEnumNames ? '' : 'LOG_RECORD_FLAGS_TRACE_FLAGS_MASK');

  static const $core.List<LogRecordFlags> values = <LogRecordFlags> [
    LOG_RECORD_FLAGS_DO_NOT_USE,
    LOG_RECORD_FLAGS_TRACE_FLAGS_MASK,
  ];

  static final $core.Map<$core.int, LogRecordFlags> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LogRecordFlags? valueOf($core.int value) => _byValue[value];

  const LogRecordFlags._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
