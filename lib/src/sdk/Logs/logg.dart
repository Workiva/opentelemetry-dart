import 'dart:ffi';

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import '../common/attributes.dart';
import '../common/limits.dart' show applyAttributeLimitsForLog;

/// A representation of a single operation within a trace.

class Logg implements api.ReadableLogRecord{
  final api.SpanContext _spanContext;
  final api.SpanId _parentSpanId;
  final List<sdk.LogRecordProcessor> _processors;
  final sdk.TimeProvider _timeProvider;
  final sdk.Resource _resource;
  final sdk.LogLimits _limits;
  final sdk.InstrumentationScope _instrumentationScope;
  final Attributes _attributes = Attributes.empty();

  api.Attribute? _body;

  final String _name;
  int _droppedSpanAttributes = 0;
  int _droppedSpanEvents = 0;


  @override
  final DateTime observedTimestamp;
  @override
  final DateTime recordTime;
  @override
  api.Severity? severity;


  Logg(
  this.recordTime,
  this.observedTimestamp,
  this._name,
  this._spanContext,
  this._parentSpanId,
  this._processors,
  this._timeProvider,
  this._resource,
  this._instrumentationScope,
  this._limits,
  );

  @override
  api.SpanId get parentSpanId => _parentSpanId;

  @override
  api.SpanContext get spanContext => _spanContext;


  @override
  // TODO: implement attributes
  Attributes get attributes => _attributes;

  @override
  // TODO: implement instrumentationScope
  sdk.InstrumentationScope get instrumentationScope => _instrumentationScope;

  @override
  // TODO: implement resource
  sdk.Resource get resource => _resource;

  @override
   get body {
    if (this._body != null){
      return this._body!;
    }
    return api.Attribute.empty("", "");
  }

  @override
  void setAttribute(api.Attribute attribute) {
    //Don't want to have any attribute
    if (_limits.maxAttributeCount == 0) {
      _droppedSpanAttributes++;
      return;
    }

    final obj = _attributes.get(attribute.key);
    // If current attributes.length is equal or greater than maxNumAttributes and
    // key is not in current map, drop it.
    if (_attributes.length >= _limits.maxAttributeLength && obj == null) {
      _droppedSpanAttributes++;
      return;
    }
    _attributes.add(applyAttributeLimitsForLog(attribute, _limits));
  }
  @override
  set observedTimestamp(DateTime? _observedTimestamp) {
    // TODO: implement observedTimestamp
  }


  @override
  set spanContext(api.SpanContext? _spanContext) {
    // TODO: implement spanContext
  }

  @override
  set recordTime(DateTime _recordTime) {
    this.recordTime = _recordTime;
  }
  @override
  void setBody(api.Attribute attribute){
    this._body = attribute;
  }
  @override
  void setSevarity(api.Severity severity){
    this.severity = severity;
  }
  @override
  void emit() {

    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onEmit(this);
    }
  }

}
