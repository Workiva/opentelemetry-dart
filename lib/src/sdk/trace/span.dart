// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import '../common/attributes.dart';

/// A representation of a single operation within a trace.
class Span implements api.Span {
  final api.SpanContext _spanContext;
  final api.SpanId? _parentSpanId;
  final api.SpanKind _kind;
  final api.SpanStatus _status = api.SpanStatus();
  final List<api.SpanProcessor> _processors;
  final List<api.SpanLink> _links;
  final sdk.TimeProvider _timeProvider;
  final sdk.Resource? _resource;
  final sdk.SpanLimits _limits;
  final api.InstrumentationLibrary? _instrumentationLibrary;
  final Int64 _startTime;
  final Attributes _attributes = Attributes.empty();
  Int64? _endTime;
  int _droppedSpanAttributes = 0;

  @override
  String name;

  @override
  bool get isRecording => _endTime == null;

  /// Construct a [Span].
  Span(this.name, this._spanContext, this._parentSpanId, this._processors,
      this._timeProvider, this._resource, this._instrumentationLibrary,
      {api.SpanKind? kind,
      List<api.Attribute>? attributes,
      List<api.SpanLink>? links,
      api.Context? parentContext,
      sdk.SpanLimits? limits,
      Int64? startTime})
      : _links = _applyLinkLimits(links ?? [], limits ?? sdk.SpanLimits()),
        _kind = kind ?? api.SpanKind.internal,
        _startTime = startTime ?? _timeProvider.now,
        _limits = limits ?? sdk.SpanLimits() {
    if (attributes != null) {
      setAttributes(attributes);
    }

    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onStart(this, parentContext);
    }
  }

  @override
  api.SpanContext get spanContext => _spanContext;

  @override
  Int64? get endTime => _endTime;

  @override
  Int64 get startTime => _startTime;

  @override
  api.SpanId? get parentSpanId => _parentSpanId;

  @override
  void end() {
    _endTime ??= _timeProvider.now;

    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onEnd(this);
    }
  }

  @override
  void setStatus(api.StatusCode status, {String description = ''}) {
    // A status cannot be Unset after being set, and cannot be set to any other
    // status after being marked "Ok".
    if (status == api.StatusCode.unset || _status.code == api.StatusCode.ok) {
      return;
    }

    _status.code = status;

    // Description is ignored for statuses other than "Error".
    if (status == api.StatusCode.error && description.isNotEmpty) {
      _status.description = description;
    }
  }

  @override
  api.SpanStatus get status => _status;

  sdk.Resource? get resource => _resource;

  @override
  api.InstrumentationLibrary? get instrumentationLibrary =>
      _instrumentationLibrary;

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
    _attributes
        .add(_rebuildAttribute(attribute, _limits.maxNumAttributeLength));
  }

  static api.Attribute _rebuildAttribute(api.Attribute attr, int maxLength) {
    // if maxNumAttributeLength is less than zero, then it has unlimited length.
    if (maxLength < 0) return attr;

    if (attr.value is String) {
      attr = api.Attribute.fromString(attr.key,
          _applyAttributeLengthLimit(attr.value as String, maxLength));
    } else if (attr.value is List<String>) {
      final listString = attr.value as List<String>;
      for (var j = 0; j < listString.length; j++) {
        listString[j] = _applyAttributeLengthLimit(listString[j], maxLength);
      }
      attr = api.Attribute.fromStringList(attr.key, listString);
    }
    return attr;
  }

  @override
  void recordException(dynamic exception, {StackTrace? stackTrace}) {
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
  void addEvent(
    String name,
    Int64 timestamp, {
    List<api.Attribute> attributes = const [],
  }) {
    // ignore: todo
    // TODO: O11Y-1531
    throw UnimplementedError();
  }

  // This method just can be called once during construction.
  static List<api.SpanLink> _applyLinkLimits(
      List<api.SpanLink> links, sdk.SpanLimits limits) {
    if (links.isEmpty) return links;
    final spanLink = <api.SpanLink>[];

    for (final link in links) {
      if (spanLink.length >= limits.maxNumLink) {
        break;
      }

      if (!link.context.isValid) continue;

      final linkAttributes = <api.Attribute>[];

      // make sure override duplicated attributes in the list
      final attributeMap = <String, int>{};

      for (final attr in link.attributes) {
        // if attributes num is already greater than maxNumAttributesPerLink
        // and this key doesn't exist in the list, drop it.
        if (attributeMap.length >= limits.maxNumAttributesPerLink &&
            !attributeMap.containsKey(attr.key)) {
          continue;
        }

        // apply maxNumAttributeLength limit.
        final trimedAttr =
            _rebuildAttribute(attr, limits.maxNumAttributeLength);

        // if this key has been added before, found its index,
        // and replace it with new value.
        if (attributeMap.containsKey(attr.key)) {
          final idx = attributeMap[attr.key]!;
          linkAttributes[idx] = trimedAttr;
        } else {
          // record this new key's index with linkAttributes length,
          // and add this new attr in linkAttributes.
          attributeMap[attr.key] = linkAttributes.length;
          linkAttributes.add(trimedAttr);
        }
      }

      spanLink.add(api.SpanLink(link.context, attributes: linkAttributes));
    }
    return spanLink;
  }

  List<api.SpanLink> get links => _links;

  Attributes get attributes => _attributes;

  //Truncate just strings which length is longer than configuration.
  //Reference: https://github.com/open-telemetry/opentelemetry-java/blob/14ffacd1cdd22f5aa556eeda4a569c7f144eadf2/sdk/common/src/main/java/io/opentelemetry/sdk/internal/AttributeUtil.java#L80
  static String _applyAttributeLengthLimit(String value, int lengthLimit) {
    return value.length > lengthLimit ? value.substring(0, lengthLimit) : value;
  }

  int get droppedAttributes => _droppedSpanAttributes;
}
