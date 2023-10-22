// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/trace/v1/trace_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../trace/v1/trace.pb.dart' as $2;

class ExportTraceServiceRequest extends $pb.GeneratedMessage {
  factory ExportTraceServiceRequest({
    $core.Iterable<$2.ResourceSpans>? resourceSpans,
  }) {
    final $result = create();
    if (resourceSpans != null) {
      $result.resourceSpans.addAll(resourceSpans);
    }
    return $result;
  }
  ExportTraceServiceRequest._() : super();
  factory ExportTraceServiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportTraceServiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportTraceServiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.collector.trace.v1'), createEmptyInstance: create)
    ..pc<$2.ResourceSpans>(1, _omitFieldNames ? '' : 'resourceSpans', $pb.PbFieldType.PM, subBuilder: $2.ResourceSpans.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportTraceServiceRequest clone() => ExportTraceServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportTraceServiceRequest copyWith(void Function(ExportTraceServiceRequest) updates) => super.copyWith((message) => updates(message as ExportTraceServiceRequest)) as ExportTraceServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceRequest create() => ExportTraceServiceRequest._();
  ExportTraceServiceRequest createEmptyInstance() => create();
  static $pb.PbList<ExportTraceServiceRequest> createRepeated() => $pb.PbList<ExportTraceServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportTraceServiceRequest>(create);
  static ExportTraceServiceRequest? _defaultInstance;

  /// An array of ResourceSpans.
  /// For data coming from a single resource this array will typically contain one
  /// element. Intermediary nodes (such as OpenTelemetry Collector) that receive
  /// data from multiple origins typically batch the data before forwarding further and
  /// in that case this array will contain multiple elements.
  @$pb.TagNumber(1)
  $core.List<$2.ResourceSpans> get resourceSpans => $_getList(0);
}

class ExportTraceServiceResponse extends $pb.GeneratedMessage {
  factory ExportTraceServiceResponse() => create();
  ExportTraceServiceResponse._() : super();
  factory ExportTraceServiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportTraceServiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportTraceServiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.collector.trace.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportTraceServiceResponse clone() => ExportTraceServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportTraceServiceResponse copyWith(void Function(ExportTraceServiceResponse) updates) => super.copyWith((message) => updates(message as ExportTraceServiceResponse)) as ExportTraceServiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceResponse create() => ExportTraceServiceResponse._();
  ExportTraceServiceResponse createEmptyInstance() => create();
  static $pb.PbList<ExportTraceServiceResponse> createRepeated() => $pb.PbList<ExportTraceServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static ExportTraceServiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportTraceServiceResponse>(create);
  static ExportTraceServiceResponse? _defaultInstance;
}

class TraceServiceApi {
  $pb.RpcClient _client;
  TraceServiceApi(this._client);

  $async.Future<ExportTraceServiceResponse> export($pb.ClientContext? ctx, ExportTraceServiceRequest request) =>
    _client.invoke<ExportTraceServiceResponse>(ctx, 'TraceService', 'Export', request, ExportTraceServiceResponse())
  ;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
