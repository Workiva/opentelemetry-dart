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
  final api.SpanId _parentSpanId = api.SpanId.invalid();
  final api.SpanContext _spanContext;

  NonRecordingSpan(this._spanContext);

  @override
  void setAttribute(api.Attribute attribute) {}

  @override
  void setAttributes(List<api.Attribute> attributes) {}

  @override
  void end() {}

  @override
  void setName(String _name) {}

  @override
  api.SpanId get parentSpanId => _parentSpanId;

  @override
  void setStatus(api.StatusCode status, [String? description]) {}

  @override
  api.SpanContext get spanContext => _spanContext;

  @override
  void recordException(dynamic exception, {StackTrace? stackTrace}) {}

  @override
  void addEvent(String name,
      {Int64? timestamp, List<api.Attribute>? attributes}) {}
}
