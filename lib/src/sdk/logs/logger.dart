// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/api.dart' as api;

class Logger extends api.Logger {
  final sdk.InstrumentationScope instrumentationScope;
  final sdk.Resource _resource;
  final sdk.LogRecordLimits logRecordLimits;
  final sdk.TimeProvider timeProvider;
  final List<sdk.LogRecordProcessor> processors;

  @protected
  Logger({
    required this.instrumentationScope,
    required this.logRecordLimits,
    required this.timeProvider,
    this.processors = const <sdk.LogRecordProcessor>[],
    sdk.Resource? resource,
  }) : _resource = resource ?? sdk.Resource([]);

  @override
  void emit({
    List<api.Attribute> attributes = const [],
    Context? context,
    dynamic body,
    DateTime? observedTimestamp,
    api.Severity? severityNumber,
    String? severityText,
    DateTime? timeStamp,
  }) {
    final log = sdk.LogRecord(
      logRecordLimits: logRecordLimits,
      resource: _resource,
      instrumentationScope: instrumentationScope,
      context: context,
      severityText: severityText,
      severityNumber: severityNumber,
      attributes: attributes,
      body: body,
      timeProvider: timeProvider,
    );
    for (final processor in processors) {
      processor.onEmit(log);
    }
    log.makeReadonly();
  }
}
