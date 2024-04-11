// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/resource/v1/resource.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../common/v1/common.pb.dart' as $3;

/// Resource information.
class Resource extends $pb.GeneratedMessage {
  factory Resource({
    $core.Iterable<$3.KeyValue>? attributes,
    $core.int? droppedAttributesCount,
  }) {
    final $result = create();
    if (attributes != null) {
      $result.attributes.addAll(attributes);
    }
    if (droppedAttributesCount != null) {
      $result.droppedAttributesCount = droppedAttributesCount;
    }
    return $result;
  }
  Resource._() : super();
  factory Resource.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Resource.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Resource', package: const $pb.PackageName(_omitMessageNames ? '' : 'opentelemetry.proto.resource.v1'), createEmptyInstance: create)
    ..pc<$3.KeyValue>(1, _omitFieldNames ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: $3.KeyValue.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'droppedAttributesCount', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Resource clone() => Resource()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Resource copyWith(void Function(Resource) updates) => super.copyWith((message) => updates(message as Resource)) as Resource;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Resource create() => Resource._();
  Resource createEmptyInstance() => create();
  static $pb.PbList<Resource> createRepeated() => $pb.PbList<Resource>();
  @$core.pragma('dart2js:noInline')
  static Resource getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Resource>(create);
  static Resource? _defaultInstance;

  /// Set of attributes that describe the resource.
  /// Attribute keys MUST be unique (it is not allowed to have more than one
  /// attribute with the same key).
  @$pb.TagNumber(1)
  $core.List<$3.KeyValue> get attributes => $_getList(0);

  /// dropped_attributes_count is the number of dropped attributes. If the value is 0, then
  /// no attributes were dropped.
  @$pb.TagNumber(2)
  $core.int get droppedAttributesCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set droppedAttributesCount($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDroppedAttributesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearDroppedAttributesCount() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
