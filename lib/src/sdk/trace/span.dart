import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;

/// A representation of a single operation within a trace.
class Span implements api.Span {
  final api.SpanContext _spanContext;
  final api.SpanId _parentSpanId;
  final api.SpanStatus _status = api.SpanStatus();
  final List<api.SpanProcessor> _processors;
  final api.Resource _resource;
  final api.InstrumentationLibrary _instrumentationLibrary;
  Int64 _startTime;
  Int64 _endTime;

  @override
  String name;

  @override
  bool get isRecording => _endTime == null;

  /// Construct a [Span].
  Span(this.name, this._spanContext, this._parentSpanId, this._processors,
      this._resource, this._instrumentationLibrary,
      {api.Attributes attributes}) {
    _startTime = Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    this.attributes = attributes ?? api.Attributes.empty();
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onStart();
    }
  }

  @override
  api.SpanContext get spanContext => _spanContext;

  @override
  Int64 get endTime => _endTime;

  @override
  Int64 get startTime => _startTime;

  @override
  api.SpanId get parentSpanId => _parentSpanId;

  @override
  void end() {
    _endTime ??= Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onEnd(this);
    }
  }

  @override
  void setStatus(api.StatusCode status, {String description}) {
    // A status cannot be Unset after being set, and cannot be set to any other
    // status after being marked "Ok".
    if (status == api.StatusCode.unset || _status.code == api.StatusCode.ok) {
      return;
    }

    _status.code = status;

    // Description is ignored for statuses other than "Error".
    if (status == api.StatusCode.error && description != null) {
      _status.description = description;
    }
  }

  @override
  api.SpanStatus get status => _status;

  @override
  api.Resource get resource => _resource;

  @override
  api.InstrumentationLibrary get instrumentationLibrary =>
      _instrumentationLibrary;

  @override
  api.Attributes attributes;
}
