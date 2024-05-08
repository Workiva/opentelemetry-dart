import 'dart:ffi';

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import '../common/attributes.dart';
import '../common/limits.dart' show applyAttributeLimits;

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

  final String _name;
  int _droppedSpanAttributes = 0;
  int _droppedSpanEvents = 0;

  @override
  final api.Attribute body;

  @override
  final DateTime observedTimestamp;
  @override
  final DateTime recordTime;
  @override
  final api.Severity severity;


  Logg(
  this.body,
  this.recordTime,
  this.observedTimestamp,
  this.severity,
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
  set body(api.Attribute? _body) {
    // TODO: implement body
  }

  @override
  set observedTimestamp(DateTime? _observedTimestamp) {
    // TODO: implement observedTimestamp
  }

  @override
  set severity(api.Severity? _severity) {
    // TODO: implement severity
  }

  @override
  set spanContext(api.SpanContext? _spanContext) {
    // TODO: implement spanContext
  }

  @override
  set recordTime(DateTime _recordTime) {
    this.recordTime = _recordTime;
  }


}
