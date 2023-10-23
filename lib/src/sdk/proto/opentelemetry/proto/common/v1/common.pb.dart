///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/common/v1/common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

enum AnyValue_Value {
  stringValue, 
  boolValue, 
  intValue, 
  doubleValue, 
  arrayValue, 
  kvlistValue, 
  bytesValue, 
  notSet
}

class AnyValue extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, AnyValue_Value> _AnyValue_ValueByTag = {
    1 : AnyValue_Value.stringValue,
    2 : AnyValue_Value.boolValue,
    3 : AnyValue_Value.intValue,
    4 : AnyValue_Value.doubleValue,
    5 : AnyValue_Value.arrayValue,
    6 : AnyValue_Value.kvlistValue,
    7 : AnyValue_Value.bytesValue,
    0 : AnyValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnyValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.common.v1'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stringValue')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boolValue')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intValue')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'doubleValue', $pb.PbFieldType.OD)
    ..aOM<ArrayValue>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'arrayValue', subBuilder: ArrayValue.create)
    ..aOM<KeyValueList>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'kvlistValue', subBuilder: KeyValueList.create)
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytesValue', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  AnyValue._() : super();
  factory AnyValue({
    $core.String? stringValue,
    $core.bool? boolValue,
    $fixnum.Int64? intValue,
    $core.double? doubleValue,
    ArrayValue? arrayValue,
    KeyValueList? kvlistValue,
    $core.List<$core.int>? bytesValue,
  }) {
    final _result = create();
    if (stringValue != null) {
      _result.stringValue = stringValue;
    }
    if (boolValue != null) {
      _result.boolValue = boolValue;
    }
    if (intValue != null) {
      _result.intValue = intValue;
    }
    if (doubleValue != null) {
      _result.doubleValue = doubleValue;
    }
    if (arrayValue != null) {
      _result.arrayValue = arrayValue;
    }
    if (kvlistValue != null) {
      _result.kvlistValue = kvlistValue;
    }
    if (bytesValue != null) {
      _result.bytesValue = bytesValue;
    }
    return _result;
  }
  factory AnyValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnyValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnyValue clone() => AnyValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnyValue copyWith(void Function(AnyValue) updates) => super.copyWith((message) => updates(message as AnyValue)) as AnyValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnyValue create() => AnyValue._();
  AnyValue createEmptyInstance() => create();
  static $pb.PbList<AnyValue> createRepeated() => $pb.PbList<AnyValue>();
  @$core.pragma('dart2js:noInline')
  static AnyValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnyValue>(create);
  static AnyValue? _defaultInstance;

  AnyValue_Value whichValue() => _AnyValue_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get boolValue => $_getBF(1);
  @$pb.TagNumber(2)
  set boolValue($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBoolValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearBoolValue() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get intValue => $_getI64(2);
  @$pb.TagNumber(3)
  set intValue($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIntValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearIntValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get doubleValue => $_getN(3);
  @$pb.TagNumber(4)
  set doubleValue($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDoubleValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearDoubleValue() => clearField(4);

  @$pb.TagNumber(5)
  ArrayValue get arrayValue => $_getN(4);
  @$pb.TagNumber(5)
  set arrayValue(ArrayValue v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasArrayValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearArrayValue() => clearField(5);
  @$pb.TagNumber(5)
  ArrayValue ensureArrayValue() => $_ensure(4);

  @$pb.TagNumber(6)
  KeyValueList get kvlistValue => $_getN(5);
  @$pb.TagNumber(6)
  set kvlistValue(KeyValueList v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasKvlistValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearKvlistValue() => clearField(6);
  @$pb.TagNumber(6)
  KeyValueList ensureKvlistValue() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.List<$core.int> get bytesValue => $_getN(6);
  @$pb.TagNumber(7)
  set bytesValue($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBytesValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearBytesValue() => clearField(7);
}

class ArrayValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ArrayValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.common.v1'), createEmptyInstance: create)
    ..pc<AnyValue>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.PM, subBuilder: AnyValue.create)
    ..hasRequiredFields = false
  ;

  ArrayValue._() : super();
  factory ArrayValue({
    $core.Iterable<AnyValue>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory ArrayValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArrayValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ArrayValue clone() => ArrayValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ArrayValue copyWith(void Function(ArrayValue) updates) => super.copyWith((message) => updates(message as ArrayValue)) as ArrayValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ArrayValue create() => ArrayValue._();
  ArrayValue createEmptyInstance() => create();
  static $pb.PbList<ArrayValue> createRepeated() => $pb.PbList<ArrayValue>();
  @$core.pragma('dart2js:noInline')
  static ArrayValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArrayValue>(create);
  static ArrayValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AnyValue> get values => $_getList(0);
}

class KeyValueList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KeyValueList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.common.v1'), createEmptyInstance: create)
    ..pc<KeyValue>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.PM, subBuilder: KeyValue.create)
    ..hasRequiredFields = false
  ;

  KeyValueList._() : super();
  factory KeyValueList({
    $core.Iterable<KeyValue>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory KeyValueList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyValueList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyValueList clone() => KeyValueList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyValueList copyWith(void Function(KeyValueList) updates) => super.copyWith((message) => updates(message as KeyValueList)) as KeyValueList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KeyValueList create() => KeyValueList._();
  KeyValueList createEmptyInstance() => create();
  static $pb.PbList<KeyValueList> createRepeated() => $pb.PbList<KeyValueList>();
  @$core.pragma('dart2js:noInline')
  static KeyValueList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyValueList>(create);
  static KeyValueList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<KeyValue> get values => $_getList(0);
}

class KeyValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KeyValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.common.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOM<AnyValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', subBuilder: AnyValue.create)
    ..hasRequiredFields = false
  ;

  KeyValue._() : super();
  factory KeyValue({
    $core.String? key,
    AnyValue? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory KeyValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyValue clone() => KeyValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyValue copyWith(void Function(KeyValue) updates) => super.copyWith((message) => updates(message as KeyValue)) as KeyValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KeyValue create() => KeyValue._();
  KeyValue createEmptyInstance() => create();
  static $pb.PbList<KeyValue> createRepeated() => $pb.PbList<KeyValue>();
  @$core.pragma('dart2js:noInline')
  static KeyValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyValue>(create);
  static KeyValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  AnyValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(AnyValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  AnyValue ensureValue() => $_ensure(1);
}

class InstrumentationScope extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InstrumentationScope', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'opentelemetry.proto.common.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version')
    ..pc<KeyValue>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: KeyValue.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'droppedAttributesCount', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  InstrumentationScope._() : super();
  factory InstrumentationScope({
    $core.String? name,
    $core.String? version,
    $core.Iterable<KeyValue>? attributes,
    $core.int? droppedAttributesCount,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (version != null) {
      _result.version = version;
    }
    if (attributes != null) {
      _result.attributes.addAll(attributes);
    }
    if (droppedAttributesCount != null) {
      _result.droppedAttributesCount = droppedAttributesCount;
    }
    return _result;
  }
  factory InstrumentationScope.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstrumentationScope.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstrumentationScope clone() => InstrumentationScope()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstrumentationScope copyWith(void Function(InstrumentationScope) updates) => super.copyWith((message) => updates(message as InstrumentationScope)) as InstrumentationScope; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstrumentationScope create() => InstrumentationScope._();
  InstrumentationScope createEmptyInstance() => create();
  static $pb.PbList<InstrumentationScope> createRepeated() => $pb.PbList<InstrumentationScope>();
  @$core.pragma('dart2js:noInline')
  static InstrumentationScope getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstrumentationScope>(create);
  static InstrumentationScope? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<KeyValue> get attributes => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get droppedAttributesCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set droppedAttributesCount($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDroppedAttributesCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearDroppedAttributesCount() => clearField(4);
}

