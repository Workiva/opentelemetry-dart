// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import '../common/attributes.dart';
import '../common/limits.dart' show applyAttributeLimits;

/// A representation of a single operation within a trace.
@protected
class Span implements sdk.ReadWriteSpan {
  final api.SpanContext _spanContext;
  final api.SpanId _parentSpanId;
  final api.SpanKind _kind;
  final api.SpanStatus _status = api.SpanStatus();
  final List<sdk.SpanProcessor> _processors;
  final List<api.SpanLink> _links;
  final sdk.TimeProvider _timeProvider;
  final sdk.Resource _resource;
  final sdk.SpanLimits _limits;
  final sdk.InstrumentationScope _instrumentationScope;
  final Int64 _startTime;
  final Attributes _attributes = Attributes.empty();
  final List<api.SpanEvent> _events = [];

  String _name;
  int _droppedSpanAttributes = 0;
  int _droppedSpanEvents = 0;

  Int64? _endTime;

  @override
  void setName(String name) {
    _name = name;
  }

  @override
  String get name => _name;

  bool get isRecording => _endTime == null;

  /// Construct a [Span].
  @protected
  Span(
      this._name,
      this._spanContext,
      this._parentSpanId,
      this._processors,
      this._timeProvider,
      this._resource,
      this._instrumentationScope,
      this._kind,
      this._links,
      this._limits,
      this._startTime);

  @override
  api.SpanContext get spanContext => _spanContext;

  @override
  Int64? get endTime => _endTime;

  @override
  Int64 get startTime => _startTime;

  @override
  api.SpanId get parentSpanId => _parentSpanId;

  @override
  void end() {
    if (!isRecording) {
      return;
    }

    _endTime = _timeProvider.now;

    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onEnd(this);
    }
  }

  @override
  void setStatus(api.StatusCode status, [String? description]) {
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
  sdk.Resource get resource => _resource;

  @override
  sdk.InstrumentationScope get instrumentationScope => _instrumentationScope;

  @override
  void setAttributes(List<api.Attribute> attributes) {
    //Don't want to have any attribute
    if (_limits.maxNumAttributes == 0) {
      _droppedSpanAttributes += attributes.length;
      return;
    }

    attributes.forEach(setAttribute);
  }

  @override
  void setAttribute(api.Attribute attribute) {
    //Don't want to have any attribute
    if (_limits.maxNumAttributes == 0) {
      _droppedSpanAttributes++;
      return;
    }

    final obj = _attributes.get(attribute.key);
    // If current attributes.length is equal or greater than maxNumAttributes and
    // key is not in current map, drop it.
    if (_attributes.length >= _limits.maxNumAttributes && obj == null) {
      _droppedSpanAttributes++;
      return;
    }
    _attributes.add(applyAttributeLimits(attribute, _limits));
  }

  @override
  void recordException(dynamic exception,
      {StackTrace stackTrace = StackTrace.empty}) {
    // ignore: todo
    // TODO: O11Y-1531: Consider integration of Events here.
    setAttributes([
      api.Attribute.fromString(api.SemanticAttributes.exceptionType,
          exception.runtimeType.toString()),
      api.Attribute.fromString(
          api.SemanticAttributes.exceptionMessage, exception.toString()),
      api.Attribute.fromString(
          api.SemanticAttributes.exceptionStacktrace, stackTrace.toString()),
    ]);
  }

  @override
  api.SpanKind get kind => _kind;

  @override
  void addEvent(String name,
      {Int64? timestamp, List<api.Attribute> attributes = const []}) {
    timestamp ??= _timeProvider.now;

    // Don't want to have any events
    if (_limits.maxNumEvents == 0) {
      _droppedSpanEvents++;
      return;
    }

    if (events.length >= _limits.maxNumEvents) {
      _droppedSpanEvents++;
      return;
    }

    // Filter attributes and make sure that not more than limit are provided
    var droppedEventAttributes = 0;
    final filteredAttributes = <String, api.Attribute>{};
    for (final attribute in attributes) {
      final obj = filteredAttributes[attribute.key];
      if (filteredAttributes.length >= _limits.maxNumAttributesPerEvent &&
          obj == null) {
        droppedEventAttributes++;
      } else {
        filteredAttributes[attribute.key] =
            applyAttributeLimits(attribute, _limits);
      }
    }

    _events.add(api.SpanEvent(
      timestamp: timestamp,
      name: name,
      attributes: filteredAttributes.values,
      droppedAttributesCount: droppedEventAttributes,
    ));
  }

  @override
  List<api.SpanLink> get links => List.unmodifiable(_links);

  @override
  Attributes get attributes => _attributes;

  int get droppedAttributes => _droppedSpanAttributes;

  @override
  List<api.SpanEvent> get events => List.unmodifiable(_events);

  @override
  int get droppedEventsCount => _droppedSpanEvents;
}
