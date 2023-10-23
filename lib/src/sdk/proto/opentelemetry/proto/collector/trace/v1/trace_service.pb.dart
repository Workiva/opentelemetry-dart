///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/trace/v1/trace_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../trace/v1/trace.pb.dart' as $2;

class ExportTraceServiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExportTraceServiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.collector.trace.v1'), createEmptyInstance: create)
    ..pc<$2.ResourceSpans>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resourceSpans', $pb.PbFieldType.PM, subBuilder: $2.ResourceSpans.create)
    ..hasRequiredFields = false
  ;

  ExportTraceServiceRequest._() : super();
  factory ExportTraceServiceRequest({
    $core.Iterable<$2.ResourceSpans>? resourceSpans,
  }) {
    final _result = create();
    if (resourceSpans != null) {
      _result.resourceSpans.addAll(resourceSpans);
    }
    return _result;
  }
  factory ExportTraceServiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportTraceServiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportTraceServiceRequest clone() => ExportTraceServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportTraceServiceRequest copyWith(void Function(ExportTraceServiceRequest) updates) => super.copyWith((message) => updates(message as ExportTraceServiceRequest)) as ExportTraceServiceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceRequest create() => ExportTraceServiceRequest._();
  ExportTraceServiceRequest createEmptyInstance() => create();
  static $pb.PbList<ExportTraceServiceRequest> createRepeated() => $pb.PbList<ExportTraceServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportTraceServiceRequest>(create);
  static ExportTraceServiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$2.ResourceSpans> get resourceSpans => $_getList(0);
}

class ExportTraceServiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExportTraceServiceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.collector.trace.v1'), createEmptyInstance: create)
    ..aOM<ExportTracePartialSuccess>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'partialSuccess', subBuilder: ExportTracePartialSuccess.create)
    ..hasRequiredFields = false
  ;

  ExportTraceServiceResponse._() : super();
  factory ExportTraceServiceResponse({
    ExportTracePartialSuccess? partialSuccess,
  }) {
    final _result = create();
    if (partialSuccess != null) {
      _result.partialSuccess = partialSuccess;
    }
    return _result;
  }
  factory ExportTraceServiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportTraceServiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportTraceServiceResponse clone() => ExportTraceServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportTraceServiceResponse copyWith(void Function(ExportTraceServiceResponse) updates) => super.copyWith((message) => updates(message as ExportTraceServiceResponse)) as ExportTraceServiceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceResponse create() => ExportTraceServiceResponse._();
  ExportTraceServiceResponse createEmptyInstance() => create();
  static $pb.PbList<ExportTraceServiceResponse> createRepeated() => $pb.PbList<ExportTraceServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportTraceServiceResponse>(create);
  static ExportTraceServiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ExportTracePartialSuccess get partialSuccess => $_getN(0);
  @$pb.TagNumber(1)
  set partialSuccess(ExportTracePartialSuccess v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPartialSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearPartialSuccess() => clearField(1);
  @$pb.TagNumber(1)
  ExportTracePartialSuccess ensurePartialSuccess() => $_ensure(0);
}

class ExportTracePartialSuccess extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExportTracePartialSuccess', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.collector.trace.v1'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectedSpans')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  ExportTracePartialSuccess._() : super();
  factory ExportTracePartialSuccess({
    $fixnum.Int64? rejectedSpans,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (rejectedSpans != null) {
      _result.rejectedSpans = rejectedSpans;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory ExportTracePartialSuccess.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportTracePartialSuccess.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportTracePartialSuccess clone() => ExportTracePartialSuccess()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportTracePartialSuccess copyWith(void Function(ExportTracePartialSuccess) updates) => super.copyWith((message) => updates(message as ExportTracePartialSuccess)) as ExportTracePartialSuccess; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExportTracePartialSuccess create() => ExportTracePartialSuccess._();
  ExportTracePartialSuccess createEmptyInstance() => create();
  static $pb.PbList<ExportTracePartialSuccess> createRepeated() => $pb.PbList<ExportTracePartialSuccess>();
  @$core.pragma('dart2js:noInline')
  static ExportTracePartialSuccess getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportTracePartialSuccess>(create);
  static ExportTracePartialSuccess? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get rejectedSpans => $_getI64(0);
  @$pb.TagNumber(1)
  set rejectedSpans($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRejectedSpans() => $_has(0);
  @$pb.TagNumber(1)
  void clearRejectedSpans() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => clearField(2);
}

class TraceServiceApi {
  $pb.RpcClient _client;
  TraceServiceApi(this._client);

  $async.Future<ExportTraceServiceResponse> export($pb.ClientContext? ctx, ExportTraceServiceRequest request) {
    var emptyResponse = ExportTraceServiceResponse();
    return _client.invoke<ExportTraceServiceResponse>(ctx, 'TraceService', 'Export', request, emptyResponse);
  }
}

