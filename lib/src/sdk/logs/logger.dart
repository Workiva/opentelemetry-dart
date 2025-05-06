// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class Logger extends api.Logger {
  final sdk.InstrumentationScope _instrumentationScope;
  final sdk.Resource _resource;
  final sdk.LogRecordLimits _logRecordLimits;
  final sdk.TimeProvider _timeProvider;
  final List<sdk.LogRecordProcessor> _processors;

  @protected
  Logger(
    this._instrumentationScope,
    this._logRecordLimits,
    this._timeProvider,
    this._processors,
    this._resource,
  );

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
      logRecordLimits: _logRecordLimits,
      resource: _resource,
      instrumentationScope: _instrumentationScope,
      context: context,
      severityText: severityText,
      severityNumber: severityNumber,
      attributes: attributes,
      body: body,
      timeProvider: _timeProvider,
    );
    for (final processor in _processors) {
      processor.onEmit(log);
    }
  }
}
