// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/trace/v1/trace.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v1/common.pb.dart' as $0;
import '../../resource/v1/resource.pb.dart' as $1;
import 'trace.pbenum.dart';

export 'trace.pbenum.dart';

///  TracesData represents the traces data that can be stored in a persistent storage,
///  OR can be embedded by other protocols that transfer OTLP traces data but do
///  not implement the OTLP protocol.
///
///  The main difference between this message and collector protocol is that
///  in this message there will not be any "control" or "metadata" specific to
///  OTLP protocol.
///
///  When new fields are added into this message, the OTLP request MUST be updated
///  as well.
class TracesData extends $pb.GeneratedMessage {
  factory TracesData({
    $core.Iterable<ResourceSpans>? resourceSpans,
  }) {
    final $result = create();
    if (resourceSpans != null) {
      $result.resourceSpans.addAll(resourceSpans);
    }
    return $result;
  }
  TracesData._() : super();
  factory TracesData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TracesData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TracesData', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..pc<ResourceSpans>(1, _omitFieldNames ? '' : 'resourceSpans', $pb.PbFieldType.PM, subBuilder: ResourceSpans.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TracesData clone() => TracesData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TracesData copyWith(void Function(TracesData) updates) => super.copyWith((message) => updates(message as TracesData)) as TracesData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TracesData create() => TracesData._();
  TracesData createEmptyInstance() => create();
  static $pb.PbList<TracesData> createRepeated() => $pb.PbList<TracesData>();
  @$core.pragma('dart2js:noInline')
  static TracesData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TracesData>(create);
  static TracesData? _defaultInstance;

  /// An array of ResourceSpans.
  /// For data coming from a single resource this array will typically contain
  /// one element. Intermediary nodes that receive data from multiple origins
  /// typically batch the data before forwarding further and in that case this
  /// array will contain multiple elements.
  @$pb.TagNumber(1)
  $core.List<ResourceSpans> get resourceSpans => $_getList(0);
}

/// A collection of ScopeSpans from a Resource.
class ResourceSpans extends $pb.GeneratedMessage {
  factory ResourceSpans({
    $1.Resource? resource,
    $core.Iterable<ScopeSpans>? scopeSpans,
    $core.String? schemaUrl,
  }) {
    final $result = create();
    if (resource != null) {
      $result.resource = resource;
    }
    if (scopeSpans != null) {
      $result.scopeSpans.addAll(scopeSpans);
    }
    if (schemaUrl != null) {
      $result.schemaUrl = schemaUrl;
    }
    return $result;
  }
  ResourceSpans._() : super();
  factory ResourceSpans.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResourceSpans.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResourceSpans', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..aOM<$1.Resource>(1, _omitFieldNames ? '' : 'resource', subBuilder: $1.Resource.create)
    ..pc<ScopeSpans>(2, _omitFieldNames ? '' : 'scopeSpans', $pb.PbFieldType.PM, subBuilder: ScopeSpans.create)
    ..aOS(3, _omitFieldNames ? '' : 'schemaUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResourceSpans clone() => ResourceSpans()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResourceSpans copyWith(void Function(ResourceSpans) updates) => super.copyWith((message) => updates(message as ResourceSpans)) as ResourceSpans;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResourceSpans create() => ResourceSpans._();
  ResourceSpans createEmptyInstance() => create();
  static $pb.PbList<ResourceSpans> createRepeated() => $pb.PbList<ResourceSpans>();
  @$core.pragma('dart2js:noInline')
  static ResourceSpans getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResourceSpans>(create);
  static ResourceSpans? _defaultInstance;

  /// The resource for the spans in this message.
  /// If this field is not set then no resource info is known.
  @$pb.TagNumber(1)
  $1.Resource get resource => $_getN(0);
  @$pb.TagNumber(1)
  set resource($1.Resource v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResource() => $_has(0);
  @$pb.TagNumber(1)
  void clearResource() => clearField(1);
  @$pb.TagNumber(1)
  $1.Resource ensureResource() => $_ensure(0);

  /// A list of ScopeSpans that originate from a resource.
  @$pb.TagNumber(2)
  $core.List<ScopeSpans> get scopeSpans => $_getList(1);

  /// The Schema URL, if known. This is the identifier of the Schema that the resource data
  /// is recorded in. To learn more about Schema URL see
  /// https://opentelemetry.io/docs/specs/otel/schemas/#schema-url
  /// This schema_url applies to the data in the "resource" field. It does not apply
  /// to the data in the "scope_spans" field which have their own schema_url field.
  @$pb.TagNumber(3)
  $core.String get schemaUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set schemaUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSchemaUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSchemaUrl() => clearField(3);
}

/// A collection of Spans produced by an InstrumentationScope.
class ScopeSpans extends $pb.GeneratedMessage {
  factory ScopeSpans({
    $0.InstrumentationScope? scope,
    $core.Iterable<Span>? spans,
    $core.String? schemaUrl,
  }) {
    final $result = create();
    if (scope != null) {
      $result.scope = scope;
    }
    if (spans != null) {
      $result.spans.addAll(spans);
    }
    if (schemaUrl != null) {
      $result.schemaUrl = schemaUrl;
    }
    return $result;
  }
  ScopeSpans._() : super();
  factory ScopeSpans.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScopeSpans.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScopeSpans', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..aOM<$0.InstrumentationScope>(1, _omitFieldNames ? '' : 'scope', subBuilder: $0.InstrumentationScope.create)
    ..pc<Span>(2, _omitFieldNames ? '' : 'spans', $pb.PbFieldType.PM, subBuilder: Span.create)
    ..aOS(3, _omitFieldNames ? '' : 'schemaUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScopeSpans clone() => ScopeSpans()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScopeSpans copyWith(void Function(ScopeSpans) updates) => super.copyWith((message) => updates(message as ScopeSpans)) as ScopeSpans;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScopeSpans create() => ScopeSpans._();
  ScopeSpans createEmptyInstance() => create();
  static $pb.PbList<ScopeSpans> createRepeated() => $pb.PbList<ScopeSpans>();
  @$core.pragma('dart2js:noInline')
  static ScopeSpans getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScopeSpans>(create);
  static ScopeSpans? _defaultInstance;

  /// The instrumentation scope information for the spans in this message.
  /// Semantically when InstrumentationScope isn't set, it is equivalent with
  /// an empty instrumentation scope name (unknown).
  @$pb.TagNumber(1)
  $0.InstrumentationScope get scope => $_getN(0);
  @$pb.TagNumber(1)
  set scope($0.InstrumentationScope v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasScope() => $_has(0);
  @$pb.TagNumber(1)
  void clearScope() => clearField(1);
  @$pb.TagNumber(1)
  $0.InstrumentationScope ensureScope() => $_ensure(0);

  /// A list of Spans that originate from an instrumentation scope.
  @$pb.TagNumber(2)
  $core.List<Span> get spans => $_getList(1);

  /// The Schema URL, if known. This is the identifier of the Schema that the span data
  /// is recorded in. To learn more about Schema URL see
  /// https://opentelemetry.io/docs/specs/otel/schemas/#schema-url
  /// This schema_url applies to all spans and span events in the "spans" field.
  @$pb.TagNumber(3)
  $core.String get schemaUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set schemaUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSchemaUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSchemaUrl() => clearField(3);
}

/// Event is a time-stamped annotation of the span, consisting of user-supplied
/// text description and key-value pairs.
class Span_Event extends $pb.GeneratedMessage {
  factory Span_Event({
    $fixnum.Int64? timeUnixNano,
    $core.String? name,
    $core.Iterable<$0.KeyValue>? attributes,
    $core.int? droppedAttributesCount,
  }) {
    final $result = create();
    if (timeUnixNano != null) {
      $result.timeUnixNano = timeUnixNano;
    }
    if (name != null) {
      $result.name = name;
    }
    if (attributes != null) {
      $result.attributes.addAll(attributes);
    }
    if (droppedAttributesCount != null) {
      $result.droppedAttributesCount = droppedAttributesCount;
    }
    return $result;
  }
  Span_Event._() : super();
  factory Span_Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Span_Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Span.Event', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'timeUnixNano', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<$0.KeyValue>(3, _omitFieldNames ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: $0.KeyValue.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'droppedAttributesCount', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Span_Event clone() => Span_Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Span_Event copyWith(void Function(Span_Event) updates) => super.copyWith((message) => updates(message as Span_Event)) as Span_Event;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Span_Event create() => Span_Event._();
  Span_Event createEmptyInstance() => create();
  static $pb.PbList<Span_Event> createRepeated() => $pb.PbList<Span_Event>();
  @$core.pragma('dart2js:noInline')
  static Span_Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Span_Event>(create);
  static Span_Event? _defaultInstance;

  /// time_unix_nano is the time the event occurred.
  @$pb.TagNumber(1)
  $fixnum.Int64 get timeUnixNano => $_getI64(0);
  @$pb.TagNumber(1)
  set timeUnixNano($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimeUnixNano() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeUnixNano() => clearField(1);

  /// name of the event.
  /// This field is semantically required to be set to non-empty string.
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  /// attributes is a collection of attribute key/value pairs on the event.
  /// Attribute keys MUST be unique (it is not allowed to have more than one
  /// attribute with the same key).
  @$pb.TagNumber(3)
  $core.List<$0.KeyValue> get attributes => $_getList(2);

  /// dropped_attributes_count is the number of dropped attributes. If the value is 0,
  /// then no attributes were dropped.
  @$pb.TagNumber(4)
  $core.int get droppedAttributesCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set droppedAttributesCount($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDroppedAttributesCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearDroppedAttributesCount() => clearField(4);
}

/// A pointer from the current span to another span in the same trace or in a
/// different trace. For example, this can be used in batching operations,
/// where a single batch handler processes multiple requests from different
/// traces or when the handler receives a request from a different project.
class Span_Link extends $pb.GeneratedMessage {
  factory Span_Link({
    $core.List<$core.int>? traceId,
    $core.List<$core.int>? spanId,
    $core.String? traceState,
    $core.Iterable<$0.KeyValue>? attributes,
    $core.int? droppedAttributesCount,
    $core.int? flags,
  }) {
    final $result = create();
    if (traceId != null) {
      $result.traceId = traceId;
    }
    if (spanId != null) {
      $result.spanId = spanId;
    }
    if (traceState != null) {
      $result.traceState = traceState;
    }
    if (attributes != null) {
      $result.attributes.addAll(attributes);
    }
    if (droppedAttributesCount != null) {
      $result.droppedAttributesCount = droppedAttributesCount;
    }
    if (flags != null) {
      $result.flags = flags;
    }
    return $result;
  }
  Span_Link._() : super();
  factory Span_Link.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Span_Link.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Span.Link', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'traceId', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'spanId', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'traceState')
    ..pc<$0.KeyValue>(4, _omitFieldNames ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: $0.KeyValue.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'droppedAttributesCount', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.OF3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Span_Link clone() => Span_Link()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Span_Link copyWith(void Function(Span_Link) updates) => super.copyWith((message) => updates(message as Span_Link)) as Span_Link;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Span_Link create() => Span_Link._();
  Span_Link createEmptyInstance() => create();
  static $pb.PbList<Span_Link> createRepeated() => $pb.PbList<Span_Link>();
  @$core.pragma('dart2js:noInline')
  static Span_Link getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Span_Link>(create);
  static Span_Link? _defaultInstance;

  /// A unique identifier of a trace that this linked span is part of. The ID is a
  /// 16-byte array.
  @$pb.TagNumber(1)
  $core.List<$core.int> get traceId => $_getN(0);
  @$pb.TagNumber(1)
  set traceId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTraceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTraceId() => clearField(1);

  /// A unique identifier for the linked span. The ID is an 8-byte array.
  @$pb.TagNumber(2)
  $core.List<$core.int> get spanId => $_getN(1);
  @$pb.TagNumber(2)
  set spanId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSpanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpanId() => clearField(2);

  /// The trace_state associated with the link.
  @$pb.TagNumber(3)
  $core.String get traceState => $_getSZ(2);
  @$pb.TagNumber(3)
  set traceState($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTraceState() => $_has(2);
  @$pb.TagNumber(3)
  void clearTraceState() => clearField(3);

  /// attributes is a collection of attribute key/value pairs on the link.
  /// Attribute keys MUST be unique (it is not allowed to have more than one
  /// attribute with the same key).
  @$pb.TagNumber(4)
  $core.List<$0.KeyValue> get attributes => $_getList(3);

  /// dropped_attributes_count is the number of dropped attributes. If the value is 0,
  /// then no attributes were dropped.
  @$pb.TagNumber(5)
  $core.int get droppedAttributesCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set droppedAttributesCount($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDroppedAttributesCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearDroppedAttributesCount() => clearField(5);

  ///  Flags, a bit field. 8 least significant bits are the trace
  ///  flags as defined in W3C Trace Context specification. Readers
  ///  MUST not assume that 24 most significant bits will be zero.
  ///  When creating new spans, the most-significant 24-bits MUST be
  ///  zero.  To read the 8-bit W3C trace flag (use flags &
  ///  SPAN_FLAGS_TRACE_FLAGS_MASK).  [Optional].
  ///
  ///  See https://www.w3.org/TR/trace-context-2/#trace-flags for the flag definitions.
  @$pb.TagNumber(6)
  $core.int get flags => $_getIZ(5);
  @$pb.TagNumber(6)
  set flags($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFlags() => $_has(5);
  @$pb.TagNumber(6)
  void clearFlags() => clearField(6);
}

///  A Span represents a single operation performed by a single component of the system.
///
///  The next available field id is 17.
class Span extends $pb.GeneratedMessage {
  factory Span({
    $core.List<$core.int>? traceId,
    $core.List<$core.int>? spanId,
    $core.String? traceState,
    $core.List<$core.int>? parentSpanId,
    $core.String? name,
    Span_SpanKind? kind,
    $fixnum.Int64? startTimeUnixNano,
    $fixnum.Int64? endTimeUnixNano,
    $core.Iterable<$0.KeyValue>? attributes,
    $core.int? droppedAttributesCount,
    $core.Iterable<Span_Event>? events,
    $core.int? droppedEventsCount,
    $core.Iterable<Span_Link>? links,
    $core.int? droppedLinksCount,
    Status? status,
    $core.int? flags,
  }) {
    final $result = create();
    if (traceId != null) {
      $result.traceId = traceId;
    }
    if (spanId != null) {
      $result.spanId = spanId;
    }
    if (traceState != null) {
      $result.traceState = traceState;
    }
    if (parentSpanId != null) {
      $result.parentSpanId = parentSpanId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (startTimeUnixNano != null) {
      $result.startTimeUnixNano = startTimeUnixNano;
    }
    if (endTimeUnixNano != null) {
      $result.endTimeUnixNano = endTimeUnixNano;
    }
    if (attributes != null) {
      $result.attributes.addAll(attributes);
    }
    if (droppedAttributesCount != null) {
      $result.droppedAttributesCount = droppedAttributesCount;
    }
    if (events != null) {
      $result.events.addAll(events);
    }
    if (droppedEventsCount != null) {
      $result.droppedEventsCount = droppedEventsCount;
    }
    if (links != null) {
      $result.links.addAll(links);
    }
    if (droppedLinksCount != null) {
      $result.droppedLinksCount = droppedLinksCount;
    }
    if (status != null) {
      $result.status = status;
    }
    if (flags != null) {
      $result.flags = flags;
    }
    return $result;
  }
  Span._() : super();
  factory Span.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Span.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Span', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'traceId', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'spanId', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'traceState')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'parentSpanId', $pb.PbFieldType.OY)
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..e<Span_SpanKind>(6, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE, defaultOrMaker: Span_SpanKind.SPAN_KIND_UNSPECIFIED, valueOf: Span_SpanKind.valueOf, enumValues: Span_SpanKind.values)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'startTimeUnixNano', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'endTimeUnixNano', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<$0.KeyValue>(9, _omitFieldNames ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: $0.KeyValue.create)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'droppedAttributesCount', $pb.PbFieldType.OU3)
    ..pc<Span_Event>(11, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: Span_Event.create)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'droppedEventsCount', $pb.PbFieldType.OU3)
    ..pc<Span_Link>(13, _omitFieldNames ? '' : 'links', $pb.PbFieldType.PM, subBuilder: Span_Link.create)
    ..a<$core.int>(14, _omitFieldNames ? '' : 'droppedLinksCount', $pb.PbFieldType.OU3)
    ..aOM<Status>(15, _omitFieldNames ? '' : 'status', subBuilder: Status.create)
    ..a<$core.int>(16, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.OF3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Span clone() => Span()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Span copyWith(void Function(Span) updates) => super.copyWith((message) => updates(message as Span)) as Span;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Span create() => Span._();
  Span createEmptyInstance() => create();
  static $pb.PbList<Span> createRepeated() => $pb.PbList<Span>();
  @$core.pragma('dart2js:noInline')
  static Span getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Span>(create);
  static Span? _defaultInstance;

  ///  A unique identifier for a trace. All spans from the same trace share
  ///  the same `trace_id`. The ID is a 16-byte array. An ID with all zeroes OR
  ///  of length other than 16 bytes is considered invalid (empty string in OTLP/JSON
  ///  is zero-length and thus is also invalid).
  ///
  ///  This field is required.
  @$pb.TagNumber(1)
  $core.List<$core.int> get traceId => $_getN(0);
  @$pb.TagNumber(1)
  set traceId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTraceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTraceId() => clearField(1);

  ///  A unique identifier for a span within a trace, assigned when the span
  ///  is created. The ID is an 8-byte array. An ID with all zeroes OR of length
  ///  other than 8 bytes is considered invalid (empty string in OTLP/JSON
  ///  is zero-length and thus is also invalid).
  ///
  ///  This field is required.
  @$pb.TagNumber(2)
  $core.List<$core.int> get spanId => $_getN(1);
  @$pb.TagNumber(2)
  set spanId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSpanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpanId() => clearField(2);

  /// trace_state conveys information about request position in multiple distributed tracing graphs.
  /// It is a trace_state in w3c-trace-context format: https://www.w3.org/TR/trace-context/#tracestate-header
  /// See also https://github.com/w3c/distributed-tracing for more details about this field.
  @$pb.TagNumber(3)
  $core.String get traceState => $_getSZ(2);
  @$pb.TagNumber(3)
  set traceState($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTraceState() => $_has(2);
  @$pb.TagNumber(3)
  void clearTraceState() => clearField(3);

  /// The `span_id` of this span's parent span. If this is a root span, then this
  /// field must be empty. The ID is an 8-byte array.
  @$pb.TagNumber(4)
  $core.List<$core.int> get parentSpanId => $_getN(3);
  @$pb.TagNumber(4)
  set parentSpanId($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasParentSpanId() => $_has(3);
  @$pb.TagNumber(4)
  void clearParentSpanId() => clearField(4);

  ///  A description of the span's operation.
  ///
  ///  For example, the name can be a qualified method name or a file name
  ///  and a line number where the operation is called. A best practice is to use
  ///  the same display name at the same call point in an application.
  ///  This makes it easier to correlate spans in different traces.
  ///
  ///  This field is semantically required to be set to non-empty string.
  ///  Empty value is equivalent to an unknown span name.
  ///
  ///  This field is required.
  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => clearField(5);

  /// Distinguishes between spans generated in a particular context. For example,
  /// two spans with the same name may be distinguished using `CLIENT` (caller)
  /// and `SERVER` (callee) to identify queueing latency associated with the span.
  @$pb.TagNumber(6)
  Span_SpanKind get kind => $_getN(5);
  @$pb.TagNumber(6)
  set kind(Span_SpanKind v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasKind() => $_has(5);
  @$pb.TagNumber(6)
  void clearKind() => clearField(6);

  ///  start_time_unix_nano is the start time of the span. On the client side, this is the time
  ///  kept by the local machine where the span execution starts. On the server side, this
  ///  is the time when the server's application handler starts running.
  ///  Value is UNIX Epoch time in nanoseconds since 00:00:00 UTC on 1 January 1970.
  ///
  ///  This field is semantically required and it is expected that end_time >= start_time.
  @$pb.TagNumber(7)
  $fixnum.Int64 get startTimeUnixNano => $_getI64(6);
  @$pb.TagNumber(7)
  set startTimeUnixNano($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStartTimeUnixNano() => $_has(6);
  @$pb.TagNumber(7)
  void clearStartTimeUnixNano() => clearField(7);

  ///  end_time_unix_nano is the end time of the span. On the client side, this is the time
  ///  kept by the local machine where the span execution ends. On the server side, this
  ///  is the time when the server application handler stops running.
  ///  Value is UNIX Epoch time in nanoseconds since 00:00:00 UTC on 1 January 1970.
  ///
  ///  This field is semantically required and it is expected that end_time >= start_time.
  @$pb.TagNumber(8)
  $fixnum.Int64 get endTimeUnixNano => $_getI64(7);
  @$pb.TagNumber(8)
  set endTimeUnixNano($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEndTimeUnixNano() => $_has(7);
  @$pb.TagNumber(8)
  void clearEndTimeUnixNano() => clearField(8);

  ///  attributes is a collection of key/value pairs. Note, global attributes
  ///  like server name can be set using the resource API. Examples of attributes:
  ///
  ///      "/http/user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
  ///      "/http/server_latency": 300
  ///      "example.com/myattribute": true
  ///      "example.com/score": 10.239
  ///
  ///  The OpenTelemetry API specification further restricts the allowed value types:
  ///  https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/common/README.md#attribute
  ///  Attribute keys MUST be unique (it is not allowed to have more than one
  ///  attribute with the same key).
  @$pb.TagNumber(9)
  $core.List<$0.KeyValue> get attributes => $_getList(8);

  /// dropped_attributes_count is the number of attributes that were discarded. Attributes
  /// can be discarded because their keys are too long or because there are too many
  /// attributes. If this value is 0, then no attributes were dropped.
  @$pb.TagNumber(10)
  $core.int get droppedAttributesCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set droppedAttributesCount($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDroppedAttributesCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearDroppedAttributesCount() => clearField(10);

  /// events is a collection of Event items.
  @$pb.TagNumber(11)
  $core.List<Span_Event> get events => $_getList(10);

  /// dropped_events_count is the number of dropped events. If the value is 0, then no
  /// events were dropped.
  @$pb.TagNumber(12)
  $core.int get droppedEventsCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set droppedEventsCount($core.int v) { $_setUnsignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDroppedEventsCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearDroppedEventsCount() => clearField(12);

  /// links is a collection of Links, which are references from this span to a span
  /// in the same or different trace.
  @$pb.TagNumber(13)
  $core.List<Span_Link> get links => $_getList(12);

  /// dropped_links_count is the number of dropped links after the maximum size was
  /// enforced. If this value is 0, then no links were dropped.
  @$pb.TagNumber(14)
  $core.int get droppedLinksCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set droppedLinksCount($core.int v) { $_setUnsignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDroppedLinksCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearDroppedLinksCount() => clearField(14);

  /// An optional final status for this span. Semantically when Status isn't set, it means
  /// span's status code is unset, i.e. assume STATUS_CODE_UNSET (code = 0).
  @$pb.TagNumber(15)
  Status get status => $_getN(14);
  @$pb.TagNumber(15)
  set status(Status v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => clearField(15);
  @$pb.TagNumber(15)
  Status ensureStatus() => $_ensure(14);

  ///  Flags, a bit field. 8 least significant bits are the trace
  ///  flags as defined in W3C Trace Context specification. Readers
  ///  MUST not assume that 24 most significant bits will be zero.
  ///  To read the 8-bit W3C trace flag, use `flags & SPAN_FLAGS_TRACE_FLAGS_MASK`.
  ///
  ///  When creating span messages, if the message is logically forwarded from another source
  ///  with an equivalent flags fields (i.e., usually another OTLP span message), the field SHOULD
  ///  be copied as-is. If creating from a source that does not have an equivalent flags field
  ///  (such as a runtime representation of an OpenTelemetry span), the high 24 bits MUST
  ///  be set to zero.
  ///
  ///  [Optional].
  ///
  ///  See https://www.w3.org/TR/trace-context-2/#trace-flags for the flag definitions.
  @$pb.TagNumber(16)
  $core.int get flags => $_getIZ(15);
  @$pb.TagNumber(16)
  set flags($core.int v) { $_setUnsignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFlags() => $_has(15);
  @$pb.TagNumber(16)
  void clearFlags() => clearField(16);
}

/// The Status type defines a logical error model that is suitable for different
/// programming environments, including REST APIs and RPC APIs.
class Status extends $pb.GeneratedMessage {
  factory Status({
    $core.String? message,
    Status_StatusCode? code,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (code != null) {
      $result.code = code;
    }
    return $result;
  }
  Status._() : super();
  factory Status.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Status.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Status', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.trace.v1'), createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<Status_StatusCode>(3, _omitFieldNames ? '' : 'code', $pb.PbFieldType.OE, defaultOrMaker: Status_StatusCode.STATUS_CODE_UNSET, valueOf: Status_StatusCode.valueOf, enumValues: Status_StatusCode.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Status clone() => Status()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Status copyWith(void Function(Status) updates) => super.copyWith((message) => updates(message as Status)) as Status;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Status create() => Status._();
  Status createEmptyInstance() => create();
  static $pb.PbList<Status> createRepeated() => $pb.PbList<Status>();
  @$core.pragma('dart2js:noInline')
  static Status getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Status>(create);
  static Status? _defaultInstance;

  /// A developer-facing human readable error message.
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  /// The status code.
  @$pb.TagNumber(3)
  Status_StatusCode get code => $_getN(1);
  @$pb.TagNumber(3)
  set code(Status_StatusCode v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
