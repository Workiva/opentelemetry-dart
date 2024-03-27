//
//  Generated code. Do not modify.
//  source: opentelemetry/proto/common/v1/common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use anyValueDescriptor instead')
const AnyValue$json = {
  '1': 'AnyValue',
  '2': [
    {'1': 'string_value', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'bool_value', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {'1': 'int_value', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'intValue'},
    {'1': 'double_value', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    {'1': 'array_value', '3': 5, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.ArrayValue', '9': 0, '10': 'arrayValue'},
    {'1': 'kvlist_value', '3': 6, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValueList', '9': 0, '10': 'kvlistValue'},
    {'1': 'bytes_value', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `AnyValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anyValueDescriptor = $convert.base64Decode(
    'CghBbnlWYWx1ZRIjCgxzdHJpbmdfdmFsdWUYASABKAlIAFILc3RyaW5nVmFsdWUSHwoKYm9vbF'
    '92YWx1ZRgCIAEoCEgAUglib29sVmFsdWUSHQoJaW50X3ZhbHVlGAMgASgDSABSCGludFZhbHVl'
    'EiMKDGRvdWJsZV92YWx1ZRgEIAEoAUgAUgtkb3VibGVWYWx1ZRJMCgthcnJheV92YWx1ZRgFIA'
    'EoCzIpLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLkFycmF5VmFsdWVIAFIKYXJyYXlW'
    'YWx1ZRJQCgxrdmxpc3RfdmFsdWUYBiABKAsyKy5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbW1vbi'
    '52MS5LZXlWYWx1ZUxpc3RIAFILa3ZsaXN0VmFsdWUSIQoLYnl0ZXNfdmFsdWUYByABKAxIAFIK'
    'Ynl0ZXNWYWx1ZUIHCgV2YWx1ZQ==');

@$core.Deprecated('Use arrayValueDescriptor instead')
const ArrayValue$json = {
  '1': 'ArrayValue',
  '2': [
    {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.AnyValue', '10': 'values'},
  ],
};

/// Descriptor for `ArrayValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arrayValueDescriptor = $convert.base64Decode(
    'CgpBcnJheVZhbHVlEj8KBnZhbHVlcxgBIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW'
    '9uLnYxLkFueVZhbHVlUgZ2YWx1ZXM=');

@$core.Deprecated('Use keyValueListDescriptor instead')
const KeyValueList$json = {
  '1': 'KeyValueList',
  '2': [
    {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'values'},
  ],
};

/// Descriptor for `KeyValueList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyValueListDescriptor = $convert.base64Decode(
    'CgxLZXlWYWx1ZUxpc3QSPwoGdmFsdWVzGAEgAygLMicub3BlbnRlbGVtZXRyeS5wcm90by5jb2'
    '1tb24udjEuS2V5VmFsdWVSBnZhbHVlcw==');

@$core.Deprecated('Use keyValueDescriptor instead')
const KeyValue$json = {
  '1': 'KeyValue',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.AnyValue', '10': 'value'},
  ],
};

/// Descriptor for `KeyValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyValueDescriptor = $convert.base64Decode(
    'CghLZXlWYWx1ZRIQCgNrZXkYASABKAlSA2tleRI9CgV2YWx1ZRgCIAEoCzInLm9wZW50ZWxlbW'
    'V0cnkucHJvdG8uY29tbW9uLnYxLkFueVZhbHVlUgV2YWx1ZQ==');

@$core.Deprecated('Use instrumentationScopeDescriptor instead')
const InstrumentationScope$json = {
  '1': 'InstrumentationScope',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
    {'1': 'attributes', '3': 3, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'attributes'},
    {'1': 'dropped_attributes_count', '3': 4, '4': 1, '5': 13, '10': 'droppedAttributesCount'},
  ],
};

/// Descriptor for `InstrumentationScope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentationScopeDescriptor = $convert.base64Decode(
    'ChRJbnN0cnVtZW50YXRpb25TY29wZRISCgRuYW1lGAEgASgJUgRuYW1lEhgKB3ZlcnNpb24YAi'
    'ABKAlSB3ZlcnNpb24SRwoKYXR0cmlidXRlcxgDIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8u'
    'Y29tbW9uLnYxLktleVZhbHVlUgphdHRyaWJ1dGVzEjgKGGRyb3BwZWRfYXR0cmlidXRlc19jb3'
    'VudBgEIAEoDVIWZHJvcHBlZEF0dHJpYnV0ZXNDb3VudA==');

