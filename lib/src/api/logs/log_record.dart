// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;

enum Severity {
  unspecified,
  trace,
  trace2,
  trace3,
  trace4,
  debug,
  debug2,
  debug3,
  debug4,
  info,
  info2,
  info3,
  info4,
  warn,
  warn2,
  warn3,
  warn4,
  error,
  error2,
  error3,
  error4,
  fatal,
  fatal2,
  fatal3,
  fatal4,
}

abstract class LogRecord {
  factory LogRecord({
    sdk.Attributes? attributes,
    api.Context? context,
    dynamic body,
    DateTime? observedTimestamp,
    Severity? severityNumber,
    String? severityText,
    DateTime? timeStamp,
  }) =>
      _LogRecord(
        attributes: attributes,
        severityText: severityText,
        context: context,
        body: body,
        observedTimestamp: observedTimestamp,
        severityNumber: severityNumber,
        timeStamp: timeStamp,
      );

  DateTime? get timeStamp;

  DateTime? get observedTimestamp;

  Severity? get severityNumber;

  String? get severityText;

  dynamic get body;

  sdk.Attributes get attributes;

  api.Context get context;
}

class _LogRecord implements LogRecord {
  @override
  final sdk.Attributes attributes;

  @override
  final api.Context context;

  @override
  final dynamic body;

  @override
  final DateTime? observedTimestamp;

  @override
  final Severity? severityNumber;

  @override
  final String? severityText;

  @override
  final DateTime? timeStamp;

  _LogRecord({
    this.severityText,
    this.body,
    this.observedTimestamp,
    this.severityNumber,
    this.timeStamp,
    sdk.Attributes? attributes,
    api.Context? context,
  })  : attributes = attributes ?? sdk.Attributes.empty(),
        context = context ?? api.Context.current;
}
