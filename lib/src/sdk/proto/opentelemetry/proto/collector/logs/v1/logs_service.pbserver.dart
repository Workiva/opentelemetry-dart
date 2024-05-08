//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/collector/logs/v1/logs_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'logs_service.pb.dart' as $5;
import 'logs_service.pbjson.dart';

export 'logs_service.pb.dart';

abstract class LogsServiceBase extends $pb.GeneratedService {
  $async.Future<$5.ExportLogsServiceResponse> export($pb.ServerContext ctx, $5.ExportLogsServiceRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Export': return $5.ExportLogsServiceRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Export': return this.export(ctx, request as $5.ExportLogsServiceRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => LogsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => LogsServiceBase$messageJson;
}

