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
  final api.Attributes _attributes = api.Attributes.empty();
  final api.SpanStatus _status = api.SpanStatus()..code = api.StatusCode.ok;
  final api.SpanContext _spanContext;

  NonRecordingSpan(this._spanContext);

  @override
  api.Attributes get attributes => _attributes;

  @override
  set attributes(api.Attributes attributes) {
    return;
  }

  @override
  void end() {
    return;
  }

  @override
  Int64 get endTime => null;

  @override
  String get name => 'NON_RECORDING';

  @override
  bool get isRecording => false;

  @override
  api.SpanId get parentSpanId => api.SpanId.invalid();

  @override
  void setStatus(api.StatusCode status, {String description}) {
    return;
  }

  @override
  api.SpanContext get spanContext => _spanContext;

  @override
  Int64 get startTime => null;

  @override
  api.SpanStatus get status => _status;

  @override
  api.Resource get resource => null;

  @override
  api.InstrumentationLibrary get instrumentationLibrary => null;

  @override
  void recordException(dynamic exception, {StackTrace stackTrace}) {
    return;
  }
}
