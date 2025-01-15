// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class Logger extends api.Logger {
  final sdk.InstrumentationScope instrumentationScope;
  final sdk.Resource? resource;
  final Function(sdk.LogRecord)? onLogEmit;
  final sdk.LogRecordLimits logRecordLimits;
  final sdk.TimeProvider? timeProvider;

  Logger({
    required this.instrumentationScope,
    required this.logRecordLimits,
    this.onLogEmit,
    this.resource,
    this.timeProvider,
  });

  @override
  void emit({
    sdk.Attributes? attributes,
    Context? context,
    dynamic body,
    DateTime? observedTimestamp,
    api.Severity? severityNumber,
    String? severityText,
    DateTime? timeStamp,
  }) {
    final log = sdk.LogRecord(
      logRecordLimits: logRecordLimits,
      resource: resource,
      instrumentationScope: instrumentationScope,
      context: context,
      severityText: severityText,
      severityNumber: severityNumber,
      attributes: attributes,
      body: body,
      timeProvider: timeProvider,
    );
    onLogEmit?.call(log);
    log.makeReadonly();
  }
}
