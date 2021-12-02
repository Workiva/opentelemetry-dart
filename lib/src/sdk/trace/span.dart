import 'package:fixnum/fixnum.dart';

import '../../api/common/attributes.dart';
import '../../api/instrumentation_library.dart';
import '../../api/resource/resource.dart';
import '../../api/span_processors/span_processor.dart';
import '../../api/trace/span.dart' as span_api;
import '../../api/trace/span_status.dart';
import '../../sdk/trace/span_context.dart';
import '../../api/trace/tracer.dart';
import '../common/attributes.dart' as attributes_sdk;
import 'span_id.dart';

/// A representation of a single operation within a trace.
class Span implements span_api.Span {
  final SpanContext _spanContext;
  final SpanId _parentSpanId;
  final SpanStatus _status = SpanStatus();
  final List<SpanProcessor> _processors;
  final Resource _resource;
  final InstrumentationLibrary _instrumentationLibrary;
  final Tracer _tracer;
  Int64 _startTime;
  Int64 _endTime;

  @override
  String name;

  @override
  bool get isRecording => _endTime == null;

  /// Construct a [Span].
  Span(this.name, this._spanContext, this._parentSpanId, this._processors,
      this._resource, this._instrumentationLibrary, this._tracer,
      {Attributes attributes}) {
    _startTime = Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    this.attributes = attributes ?? attributes_sdk.Attributes.empty();
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onStart();
    }
  }

  @override
  SpanContext get spanContext => _spanContext;

  @override
  Int64 get endTime => _endTime;

  @override
  Int64 get startTime => _startTime;

  @override
  SpanId get parentSpanId => _parentSpanId;

  @override
  void end() {
    _endTime ??= Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onEnd(this);
    }
  }

  @override
  void setStatus(StatusCode status, {String description}) {
    // A status cannot be Unset after being set, and cannot be set to any other
    // status after being marked "Ok".
    if (status == StatusCode.unset || _status.code == StatusCode.ok) {
      return;
    }

    _status.code = status;

    // Description is ignored for statuses other than "Error".
    if (status == StatusCode.error && description != null) {
      _status.description = description;
    }
  }

  @override
  SpanStatus get status => _status;

  @override
  Resource get resource => _resource;

  @override
  InstrumentationLibrary get instrumentationLibrary => _instrumentationLibrary;

  @override
  Tracer get tracer => _tracer;

  @override
  Attributes attributes;
}
