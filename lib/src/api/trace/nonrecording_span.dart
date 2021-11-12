import 'package:fixnum/fixnum.dart';

import '../../sdk/common/attributes.dart' as sdk_attributes;
import '../../sdk/instrumentation_library.dart' as sdk_instrumentation_library;
import '../../sdk/resource/resource.dart' as sdk_resource;
import '../../sdk/trace/span.dart';
import '../../sdk/trace/span_context.dart' as sdk_spancontext;
import '../../sdk/trace/span_id.dart';
import '../common/attributes.dart';
import 'span.dart' as api;
import 'span_context.dart';
import 'span_status.dart';

/// A class representing a [Span] which should not be sampled or recorded.
///
/// See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#wrapping-a-spancontext-in-a-span
/// for more information.
///
/// This class should not be exposed to consumers and is used internally to wrap
/// [SpanContext] being injected or extracted for external calls.
class NonRecordingSpan extends Span implements api.Span {
  final Attributes _attributes = sdk_attributes.Attributes.empty();
  final SpanStatus _status = SpanStatus()..code = StatusCode.ok;
  final SpanContext _spanContext;

  NonRecordingSpan(this._spanContext)
      : super('NON_RECORDING', _spanContext, SpanId.invalid(), [], null, null);

  @override
  Attributes get attributes => _attributes;

  @override
  set attributes(Attributes attributes) {
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
  SpanId get parentSpanId => SpanId.invalid();

  @override
  void setStatus(StatusCode status, {String description}) {
    return;
  }

  @override
  sdk_spancontext.SpanContext get spanContext => _spanContext;

  @override
  Int64 get startTime => null;

  @override
  SpanStatus get status => _status;

  @override
  sdk_resource.Resource get resource => null;

  @override
  sdk_instrumentation_library.InstrumentationLibrary
      get instrumentationLibrary => null;
}
