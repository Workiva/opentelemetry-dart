///
//  Generated code. Do not modify.
//  source: opentelemetry/proto/common/v1/common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use anyValueDescriptor instead')
const AnyValue$json = const {
  '1': 'AnyValue',
  '2': const [
    const {'1': 'string_value', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    const {'1': 'bool_value', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    const {'1': 'int_value', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'intValue'},
    const {'1': 'double_value', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'doubleValue'},
    const {'1': 'array_value', '3': 5, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.ArrayValue', '9': 0, '10': 'arrayValue'},
    const {'1': 'kvlist_value', '3': 6, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValueList', '9': 0, '10': 'kvlistValue'},
    const {'1': 'bytes_value', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'bytesValue'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `AnyValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anyValueDescriptor = $convert.base64Decode('CghBbnlWYWx1ZRIjCgxzdHJpbmdfdmFsdWUYASABKAlIAFILc3RyaW5nVmFsdWUSHwoKYm9vbF92YWx1ZRgCIAEoCEgAUglib29sVmFsdWUSHQoJaW50X3ZhbHVlGAMgASgDSABSCGludFZhbHVlEiMKDGRvdWJsZV92YWx1ZRgEIAEoAUgAUgtkb3VibGVWYWx1ZRJMCgthcnJheV92YWx1ZRgFIAEoCzIpLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLkFycmF5VmFsdWVIAFIKYXJyYXlWYWx1ZRJQCgxrdmxpc3RfdmFsdWUYBiABKAsyKy5vcGVudGVsZW1ldHJ5LnByb3RvLmNvbW1vbi52MS5LZXlWYWx1ZUxpc3RIAFILa3ZsaXN0VmFsdWUSIQoLYnl0ZXNfdmFsdWUYByABKAxIAFIKYnl0ZXNWYWx1ZUIHCgV2YWx1ZQ==');
@$core.Deprecated('Use arrayValueDescriptor instead')
const ArrayValue$json = const {
  '1': 'ArrayValue',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.AnyValue', '10': 'values'},
  ],
};

/// Descriptor for `ArrayValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arrayValueDescriptor = $convert.base64Decode('CgpBcnJheVZhbHVlEj8KBnZhbHVlcxgBIAMoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLkFueVZhbHVlUgZ2YWx1ZXM=');
@$core.Deprecated('Use keyValueListDescriptor instead')
const KeyValueList$json = const {
  '1': 'KeyValueList',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 11, '6': '.opentelemetry.proto.common.v1.KeyValue', '10': 'values'},
  ],
};

/// Descriptor for `KeyValueList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyValueListDescriptor = $convert.base64Decode('CgxLZXlWYWx1ZUxpc3QSPwoGdmFsdWVzGAEgAygLMicub3BlbnRlbGVtZXRyeS5wcm90by5jb21tb24udjEuS2V5VmFsdWVSBnZhbHVlcw==');
@$core.Deprecated('Use keyValueDescriptor instead')
const KeyValue$json = const {
  '1': 'KeyValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.opentelemetry.proto.common.v1.AnyValue', '10': 'value'},
  ],
};

/// Descriptor for `KeyValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyValueDescriptor = $convert.base64Decode('CghLZXlWYWx1ZRIQCgNrZXkYASABKAlSA2tleRI9CgV2YWx1ZRgCIAEoCzInLm9wZW50ZWxlbWV0cnkucHJvdG8uY29tbW9uLnYxLkFueVZhbHVlUgV2YWx1ZQ==');
@$core.Deprecated('Use stringKeyValueDescriptor instead')
const StringKeyValue$json = const {
  '1': 'StringKeyValue',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'3': true},
};

/// Descriptor for `StringKeyValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringKeyValueDescriptor = $convert.base64Decode('Cg5TdHJpbmdLZXlWYWx1ZRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AhgB');
@$core.Deprecated('Use instrumentationLibraryDescriptor instead')
const InstrumentationLibrary$json = const {
  '1': 'InstrumentationLibrary',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `InstrumentationLibrary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instrumentationLibraryDescriptor = $convert.base64Decode('ChZJbnN0cnVtZW50YXRpb25MaWJyYXJ5EhIKBG5hbWUYASABKAlSBG5hbWUSGAoHdmVyc2lvbhgCIAEoCVIHdmVyc2lvbg==');
