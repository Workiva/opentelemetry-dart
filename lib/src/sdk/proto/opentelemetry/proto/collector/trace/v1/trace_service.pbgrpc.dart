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

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'trace_service.pb.dart' as $1;

export 'trace_service.pb.dart';

@$pb.GrpcServiceName('opentelemetry.proto.collector.trace.v1.TraceService')
class TraceServiceClient extends $grpc.Client {
  static final _$export = $grpc.ClientMethod<$1.ExportTraceServiceRequest, $1.ExportTraceServiceResponse>(
      '/opentelemetry.proto.collector.trace.v1.TraceService/Export',
      ($1.ExportTraceServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ExportTraceServiceResponse.fromBuffer(value));

  TraceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.ExportTraceServiceResponse> export($1.ExportTraceServiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$export, request, options: options);
  }
}

@$pb.GrpcServiceName('opentelemetry.proto.collector.trace.v1.TraceService')
abstract class TraceServiceBase extends $grpc.Service {
  $core.String get $name => 'opentelemetry.proto.collector.trace.v1.TraceService';

  TraceServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.ExportTraceServiceRequest, $1.ExportTraceServiceResponse>(
        'Export',
        export_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ExportTraceServiceRequest.fromBuffer(value),
        ($1.ExportTraceServiceResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.ExportTraceServiceResponse> export_Pre($grpc.ServiceCall call, $async.Future<$1.ExportTraceServiceRequest> request) async {
    return export(call, await request);
  }

  $async.Future<$1.ExportTraceServiceResponse> export($grpc.ServiceCall call, $1.ExportTraceServiceRequest request);
}
