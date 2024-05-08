//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/logs/v1/logs_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../logs/v1/logs.pb.dart' as $4;

class ExportLogsServiceRequest extends $pb.GeneratedMessage {
  factory ExportLogsServiceRequest({
    $core.Iterable<$4.ResourceLogs>? resourceLogs,
  }) {
    final $result = create();
    if (resourceLogs != null) {
      $result.resourceLogs.addAll(resourceLogs);
    }
    return $result;
  }
  ExportLogsServiceRequest._() : super();
  factory ExportLogsServiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportLogsServiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportLogsServiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.collector.logs.v1'), createEmptyInstance: create)
    ..pc<$4.ResourceLogs>(1, _omitFieldNames ? '' : 'resourceLogs', $pb.PbFieldType.PM, subBuilder: $4.ResourceLogs.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportLogsServiceRequest clone() => ExportLogsServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportLogsServiceRequest copyWith(void Function(ExportLogsServiceRequest) updates) => super.copyWith((message) => updates(message as ExportLogsServiceRequest)) as ExportLogsServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportLogsServiceRequest create() => ExportLogsServiceRequest._();
  ExportLogsServiceRequest createEmptyInstance() => create();
  static $pb.PbList<ExportLogsServiceRequest> createRepeated() => $pb.PbList<ExportLogsServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static ExportLogsServiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportLogsServiceRequest>(create);
  static ExportLogsServiceRequest? _defaultInstance;

  /// An array of ResourceLogs.
  /// For data coming from a single resource this array will typically contain one
  /// element. Intermediary nodes (such as OpenTelemetry Collector) that receive
  /// data from multiple origins typically batch the data before forwarding further and
  /// in that case this array will contain multiple elements.
  @$pb.TagNumber(1)
  $core.List<$4.ResourceLogs> get resourceLogs => $_getList(0);
}

class ExportLogsServiceResponse extends $pb.GeneratedMessage {
  factory ExportLogsServiceResponse({
    ExportLogsPartialSuccess? partialSuccess,
  }) {
    final $result = create();
    if (partialSuccess != null) {
      $result.partialSuccess = partialSuccess;
    }
    return $result;
  }
  ExportLogsServiceResponse._() : super();
  factory ExportLogsServiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportLogsServiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportLogsServiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.collector.logs.v1'), createEmptyInstance: create)
    ..aOM<ExportLogsPartialSuccess>(1, _omitFieldNames ? '' : 'partialSuccess', subBuilder: ExportLogsPartialSuccess.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportLogsServiceResponse clone() => ExportLogsServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportLogsServiceResponse copyWith(void Function(ExportLogsServiceResponse) updates) => super.copyWith((message) => updates(message as ExportLogsServiceResponse)) as ExportLogsServiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportLogsServiceResponse create() => ExportLogsServiceResponse._();
  ExportLogsServiceResponse createEmptyInstance() => create();
  static $pb.PbList<ExportLogsServiceResponse> createRepeated() => $pb.PbList<ExportLogsServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static ExportLogsServiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportLogsServiceResponse>(create);
  static ExportLogsServiceResponse? _defaultInstance;

  ///  The details of a partially successful export request.
  ///
  ///  If the request is only partially accepted
  ///  (i.e. when the server accepts only parts of the data and rejects the rest)
  ///  the server MUST initialize the `partial_success` field and MUST
  ///  set the `rejected_<signal>` with the number of items it rejected.
  ///
  ///  Servers MAY also make use of the `partial_success` field to convey
  ///  warnings/suggestions to senders even when the request was fully accepted.
  ///  In such cases, the `rejected_<signal>` MUST have a value of `0` and
  ///  the `error_message` MUST be non-empty.
  ///
  ///  A `partial_success` message with an empty value (rejected_<signal> = 0 and
  ///  `error_message` = "") is equivalent to it not being set/present. Senders
  ///  SHOULD interpret it the same way as in the full success case.
  @$pb.TagNumber(1)
  ExportLogsPartialSuccess get partialSuccess => $_getN(0);
  @$pb.TagNumber(1)
  set partialSuccess(ExportLogsPartialSuccess v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPartialSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearPartialSuccess() => clearField(1);
  @$pb.TagNumber(1)
  ExportLogsPartialSuccess ensurePartialSuccess() => $_ensure(0);
}

class ExportLogsPartialSuccess extends $pb.GeneratedMessage {
  factory ExportLogsPartialSuccess({
    $fixnum.Int64? rejectedLogRecords,
    $core.String? errorMessage,
  }) {
    final $result = create();
    if (rejectedLogRecords != null) {
      $result.rejectedLogRecords = rejectedLogRecords;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    return $result;
  }
  ExportLogsPartialSuccess._() : super();
  factory ExportLogsPartialSuccess.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportLogsPartialSuccess.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportLogsPartialSuccess', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.collector.logs.v1'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'rejectedLogRecords')
    ..aOS(2, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportLogsPartialSuccess clone() => ExportLogsPartialSuccess()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportLogsPartialSuccess copyWith(void Function(ExportLogsPartialSuccess) updates) => super.copyWith((message) => updates(message as ExportLogsPartialSuccess)) as ExportLogsPartialSuccess;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportLogsPartialSuccess create() => ExportLogsPartialSuccess._();
  ExportLogsPartialSuccess createEmptyInstance() => create();
  static $pb.PbList<ExportLogsPartialSuccess> createRepeated() => $pb.PbList<ExportLogsPartialSuccess>();
  @$core.pragma('dart2js:noInline')
  static ExportLogsPartialSuccess getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportLogsPartialSuccess>(create);
  static ExportLogsPartialSuccess? _defaultInstance;

  ///  The number of rejected log records.
  ///
  ///  A `rejected_<signal>` field holding a `0` value indicates that the
  ///  request was fully accepted.
  @$pb.TagNumber(1)
  $fixnum.Int64 get rejectedLogRecords => $_getI64(0);
  @$pb.TagNumber(1)
  set rejectedLogRecords($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRejectedLogRecords() => $_has(0);
  @$pb.TagNumber(1)
  void clearRejectedLogRecords() => clearField(1);

  ///  A developer-facing human-readable message in English. It should be used
  ///  either to explain why the server rejected parts of the data during a partial
  ///  success or to convey warnings/suggestions during a full success. The message
  ///  should offer guidance on how users can address such issues.
  ///
  ///  error_message is an optional field. An error_message with an empty value
  ///  is equivalent to it not being set.
  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => clearField(2);
}

class LogsServiceApi {
  $pb.RpcClient _client;
  LogsServiceApi(this._client);

  $async.Future<ExportLogsServiceResponse> export($pb.ClientContext? ctx, ExportLogsServiceRequest request) =>
    _client.invoke<ExportLogsServiceResponse>(ctx, 'LogsService', 'Export', request, ExportLogsServiceResponse())
  ;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
