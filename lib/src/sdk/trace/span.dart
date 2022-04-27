import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import '../common/attributes.dart';

/// A representation of a single operation within a trace.
class Span implements api.Span {
  final api.SpanContext _spanContext;
  final api.SpanId _parentSpanId;
  final api.SpanKind _kind; // ignore: unused_field
  final api.SpanStatus _status = api.SpanStatus();
  final List<api.SpanProcessor> _processors;
  final List<api.SpanLink> _links; // ignore: unused_field
  final sdk.TimeProvider _timeProvider;
  final sdk.Resource _resource;
  final sdk.SpanLimits _spanLimits;
  final api.InstrumentationLibrary _instrumentationLibrary;
  final Int64 _startTime;
  final Attributes attributes = Attributes.empty();
  Int64 _endTime;
  int _droppedSpanAttributes = 0;

  @override
  String name;

  @override
  bool get isRecording => _endTime == null;

  /// Construct a [Span].
  Span(this.name, this._spanContext, this._parentSpanId, this._processors,
      this._timeProvider, this._resource, this._instrumentationLibrary,
      {api.SpanKind kind,
      List<api.Attribute> attributes,
      List<api.SpanLink> links,
      sdk.SpanLimits spanlimits,
      Int64 startTime})
      : _links = links ?? [],
        _kind = kind ?? api.SpanKind.internal,
        _startTime = startTime ?? _timeProvider.now,
        _spanLimits = spanlimits ?? sdk.SpanLimits() {
    if (attributes != null) {
      setAttributes(attributes);
    }

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
    _endTime ??= _timeProvider.now;

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

  sdk.Resource get resource => _resource;

  @override
  api.InstrumentationLibrary get instrumentationLibrary =>
      _instrumentationLibrary;

  @override
  void setAttributes(List<api.Attribute> attributes) {
    //Don't want to have any attribute
    if (_spanLimits.maxNumAttributes == 0) {
      _droppedSpanAttributes += attributes.length;
      return;
    }

    attributes.forEach(setAttribute);
  }

  @override
  void setAttribute(api.Attribute attribute) {
    //Don't want to have any attribute
    if (_spanLimits.maxNumAttributes == 0) {
      _droppedSpanAttributes++;
      return;
    }

    final obj = attributes.get(attribute.key);
    //If current attributes.length is equal or greater than maxNumAttributes and
    //key is not in current map, drop it.
    if (attributes.length >= _spanLimits.maxNumAttributes && obj == null) {
      _droppedSpanAttributes++;
      return;
    }
    attributes.add(_rebuildAttribute(attribute));
  }

  /// reBuild an attribute, this way it is tightly coupled with the type we supported,
  /// if later we added more types, then we need to change this method.
  api.Attribute _rebuildAttribute(api.Attribute attr) {
    //if maxNumAttributeLength is less than zero, then it has unlimited length.
    if (_spanLimits.maxNumAttributeLength < 0) return attr;

    if (attr.value is String) {
      attr = api.Attribute.fromString(
          attr.key,
          _applyAttributeLengthLimit(
              attr.value, _spanLimits.maxNumAttributeLength));
    } else if (attr.value is List<String>) {
      final listString = attr.value as List<String>;
      for (var j = 0; j < listString.length; j++) {
        listString[j] = _applyAttributeLengthLimit(
            listString[j], _spanLimits.maxNumAttributeLength);
      }
      attr = api.Attribute.fromStringList(attr.key, listString);
    }
    return attr;
  }

  @override
  void recordException(dynamic exception, {StackTrace stackTrace}) {
    // ignore: todo
    // TODO: O11Y-1531: Consider integration of Events here.
    setStatus(api.StatusCode.error, description: exception.toString());
    setAttributes([
      api.Attribute.fromBoolean('error', true),
      api.Attribute.fromString('exception', exception.toString()),
      api.Attribute.fromString('stacktrace', stackTrace.toString()),
    ]);
  }

  @override
  api.SpanKind get kind => _kind;

  @override
  void addEvent(String name, Int64 timestamp,
      {List<api.Attribute> attributes}) {
    // TODO: O11Y-1531
    throw UnimplementedError();
  }

  //Truncate just strings which length is longer than configuration.
  //Reference: https://github.com/open-telemetry/opentelemetry-java/blob/14ffacd1cdd22f5aa556eeda4a569c7f144eadf2/sdk/common/src/main/java/io/opentelemetry/sdk/internal/AttributeUtil.java#L80
  static String _applyAttributeLengthLimit(String value, int lengthLimit) {
    return value.length > lengthLimit ? value.substring(0, lengthLimit) : value;
  }

  int get droppedAttributes => _droppedSpanAttributes;
}
