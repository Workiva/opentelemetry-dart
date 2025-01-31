// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/common/limits.dart';

/// https://opentelemetry.io/docs/specs/otel/logs/sdk/#readwritelogrecord
abstract class ReadableLogRecord {
  Int64? get timeStamp;

  Int64? get observedTimestamp;

  String? get severityText;

  api.Severity? get severityNumber;

  dynamic get body;

  sdk.Attributes? get attributes;

  api.SpanContext? get spanContext;

  sdk.Resource? get resource;

  sdk.InstrumentationScope? get instrumentationScope;

  int get droppedAttributesCount;
}

abstract class ReadWriteLogRecord extends ReadableLogRecord {
  set body(dynamic severity);

  set severityText(String? severity);

  set severityNumber(api.Severity? severity);
}

class LogRecord implements ReadWriteLogRecord {
  @override
  final sdk.InstrumentationScope instrumentationScope;

  @override
  final sdk.Resource? resource;

  final sdk.TimeProvider _timeProvider;
  final api.Context _context;
  final sdk.LogRecordLimits logRecordLimits;
  final DateTime? _timeStamp;
  final DateTime? _observedTimestamp;

  bool _isReadonly = false;
  String? _severityText;
  api.Severity? _severityNumber;
  dynamic _body;
  int _totalAttributesCount = 0;

  final sdk.Attributes _attributes;

  LogRecord({
    required this.instrumentationScope,
    required this.logRecordLimits,
    api.Severity? severityNumber,
    String? severityText,
    List<api.Attribute> attributes = const <api.Attribute>[],
    DateTime? timeStamp,
    DateTime? observedTimestamp,
    api.Context? context,
    dynamic body,
    this.resource,
    sdk.TimeProvider? timeProvider,
  })  : _severityText = severityText,
        _context = context ?? api.Context.current,
        _body = body,
        _attributes = sdk.Attributes.empty(),
        _severityNumber = severityNumber,
        _timeStamp = timeStamp,
        _observedTimestamp = observedTimestamp,
        _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider() {
    if (attributes.isNotEmpty) setAttributes(attributes);
  }

  @override
  sdk.Attributes? get attributes => _attributes;

  @override
  dynamic get body => _body;

  @override
  set body(dynamic body) {
    if (_isReadonly) return;
    _body = body;
  }

  @override
  api.SpanContext? get spanContext => api.spanContextFromContext(_context);

  @override
  int get droppedAttributesCount =>
      _totalAttributesCount - (attributes?.length ?? 0);

  @override
  Int64? get timeStamp => _timeStamp != null
      ? Int64(_timeStamp!.microsecondsSinceEpoch) * 1000
      : _timeProvider.now;

  @override
  Int64? get observedTimestamp => _observedTimestamp != null
      ? Int64(_observedTimestamp!.microsecondsSinceEpoch) * 1000
      : _timeProvider.now;

  @override
  api.Severity? get severityNumber => _severityNumber;

  @override
  set severityNumber(api.Severity? severity) {
    if (_isReadonly) return;
    _severityNumber = severity;
  }

  @override
  String? get severityText => _severityText;

  @override
  set severityText(String? severity) {
    if (_isReadonly) return;
    _severityText = severity;
  }

  void setAttributes(List<api.Attribute> attributes) {
    attributes.forEach(setAttribute);
  }

  void setAttribute(api.Attribute attribute) {
    if (_isReadonly) return;
    if (attribute.key.isEmpty) return;
    if (logRecordLimits.attributeCountLimit == 0) return;
    _totalAttributesCount += 1;
    _attributes.add(applyAttributeLimitsForLog(attribute, logRecordLimits));
  }

  /// A LogRecordProcessor may freely modify logRecord for the duration of the OnEmit call.
  /// If logRecord is needed after OnEmit returns (i.e. for asynchronous processing) only reads are permitted.
  @internal
  void makeReadonly() {
    _isReadonly = true;
  }
}
