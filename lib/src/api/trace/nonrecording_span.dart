// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;

/// A class representing a [api.Span] which should not be sampled or recorded.
///
/// See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#wrapping-a-spancontext-in-a-span
/// for more information.
///
/// This class should not be exposed to consumers and is used internally to wrap
/// [api.SpanContext] being injected or extracted for external calls.
class NonRecordingSpan implements api.Span {
  final api.SpanStatus _status = api.SpanStatus()..code = api.StatusCode.ok;
  final api.SpanContext _spanContext;

  NonRecordingSpan(this._spanContext);

  @override
  void setAttribute(api.Attribute attribute) {}

  @override
  void setAttributes(List<api.Attribute> attributes) {}

  @override
  void end() {}

  @override
  Int64? get endTime => null;

  @override
  String get name => 'NON_RECORDING';

  @override
  set name(String? _name) {}

  @override
  bool get isRecording => false;

  @override
  api.SpanId get parentSpanId => api.SpanId.invalid();

  @override
  void setStatus(api.StatusCode status, {String? description}) {}

  @override
  api.SpanContext get spanContext => _spanContext;

  @override
  Int64? get startTime => null;

  @override
  api.SpanStatus get status => _status;

  @override
  api.InstrumentationLibrary? get instrumentationLibrary => null;

  @override
  void recordException(dynamic exception, {StackTrace? stackTrace}) {}

  @override
  void addEvent(String name, Int64 timestamp,
      {List<api.Attribute>? attributes}) {}

  @override
  api.SpanKind get kind => api.SpanKind.internal;
}
