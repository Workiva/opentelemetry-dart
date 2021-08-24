import 'package:fixnum/fixnum.dart';

import '../../api/common/attributes.dart';
import '../../api/trace/span.dart' as span_api;
import '../../api/trace/span_status.dart';
import '../../api/trace/tracer.dart';
import '../../sdk/trace/span_context.dart';
import '../common/attributes.dart' as attributes_sdk;
import 'span_id.dart';
import 'span_processors/span_processor.dart';

/// A representation of a single operation within a trace.
class Span implements span_api.Span {
  final SpanContext _spanContext;
  final SpanId _parentSpanId;
  final SpanStatus _status = SpanStatus();
  final List<SpanProcessor> _processors;
  final Tracer _tracer;
  bool _isRecording;
  Int64 _startTime;
  Int64 _endTime;

  @override
  String name;

  set isRecording(bool isRecording) {
    _isRecording = isRecording;
  }

  @override
  bool get isRecording {
    if (_endTime != null && _endTime > Int64.ZERO) {
      return false; // An ended Span cannot be recording.
    }

    return _isRecording;
  }

  /// Construct a [Span].
  Span(this.name, this._spanContext, this._parentSpanId, this._processors,
      this._tracer,
      {Attributes attributes}) {
    _startTime = Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    this.attributes = attributes ?? attributes_sdk.Attributes.empty();
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onStart();
    }
    _isRecording = true;
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
    _isRecording = false;
  }

  @override
  void setStatus(StatusCode status, {String description}) {
    // A status cannot be Unset after being set, and cannot be set to any other
    // status after being marked "Ok".
    if (status == StatusCode.UNSET || _status.code == StatusCode.OK) {
      return;
    }

    _status.code = status;

    // Description is ignored for statuses other than "Error".
    if (status == StatusCode.ERROR && description != null) {
      _status.description = description;
    }
  }

  @override
  SpanStatus get status => _status;

  @override
  Tracer get tracer => _tracer;

  @override
  Attributes attributes;
}