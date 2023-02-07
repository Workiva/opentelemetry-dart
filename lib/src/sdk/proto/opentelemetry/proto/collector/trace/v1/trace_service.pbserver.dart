///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/trace/v1/trace_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'trace_service.pb.dart' as $3;
import 'trace_service.pbjson.dart';

export 'trace_service.pb.dart';

abstract class TraceServiceBase extends $pb.GeneratedService {
  $async.Future<$3.ExportTraceServiceResponse> export($pb.ServerContext ctx, $3.ExportTraceServiceRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'Export': return $3.ExportTraceServiceRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'Export': return this.export(ctx, request as $3.ExportTraceServiceRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TraceServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => TraceServiceBase$messageJson;
}

