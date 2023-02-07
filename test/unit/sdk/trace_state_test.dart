// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('create empty', () {
    final testTraceState = TraceState.empty();

    expect(testTraceState.toString(), equals(''));
    expect(testTraceState.isEmpty, isTrue);
    expect(testTraceState.size, equals(0));
  });

  test('create from string', () {
    final testTraceState = TraceState.fromString('key1=value2,key@2=value1');

    expect(testTraceState.get('key1'), equals('value2')); // Regular key.
    expect(testTraceState.get('key@2'), equals('value1')); // Vendor key.
    expect(testTraceState.toString(), equals('key1=value2,key@2=value1'));
    expect(testTraceState.isEmpty, isFalse);
    expect(testTraceState.size, equals(2));
  });

  test('get default', () {
    final testTraceState = TraceState.getDefault();

    expect(testTraceState.toString(), equals(''));
    expect(testTraceState.isEmpty, isTrue);
    expect(testTraceState.size, equals(0));
  });

  test('put valid values', () {
    final testTraceState = TraceState.empty()
      ..put('key_0-1', 'value@2')
      ..put('key_0-2', 'value@1')
      ..put('key_@vendor', 'value@3');

    expect(testTraceState.get('key_0-1'), equals('value@2'));
    expect(testTraceState.get('key_0-2'), equals('value@1'));
    expect(testTraceState.get('key_@vendor'), equals('value@3'));
    expect(testTraceState.toString(),
        equals('key_0-1=value@2,key_0-2=value@1,key_@vendor=value@3'));
    expect(testTraceState.isEmpty, isFalse);
    expect(testTraceState.size, equals(3));
  });

  test('create from string with invalid values', () {
    final testTraceState = TraceState.fromString(
        'key_0-1=0,value2,key&0-2=value@1,key_@thisisalotlongerthan13characters=value@3');

    expect(testTraceState.get('key_0-1'), isNull); // Invalid value, comma.
    expect(testTraceState.get('key&0-2'), isNull); // Invalid key.
    expect(testTraceState.get('key_@thisisalotlongerthan13characters'),
        isNull); // Invalid vendor key.
    expect(testTraceState.toString(), equals(''));
    expect(testTraceState.isEmpty, isTrue);
    expect(testTraceState.size, equals(0));
  });

  test('put invalid values', () {
    final testTraceState = TraceState.empty()
      ..put('key_0-1', '0,value=2') // Invalid value.
      ..put('key&0-2', 'value@1') // Invalid key.
      ..put('key_@thisisalotlongerthan13characters',
          'value@3'); // Invalid vendor key.

    expect(testTraceState.get('key_0-1'), isNull);
    expect(testTraceState.get('key_0-2'), isNull);
    expect(testTraceState.get('key_@thisisalotlongerthan13characters'), isNull);
    expect(testTraceState.toString(), equals(''));
    expect(testTraceState.isEmpty, isTrue);
    expect(testTraceState.size, equals(0));
  });

  test('remove valid value', () {
    final testTraceState = TraceState.empty()
      ..put('key_0-1', 'value@2')
      ..put('key_0-2', 'value@1')
      ..put('key_@vendor', 'value@3')
      ..remove('key_@vendor');

    expect(testTraceState.get('key_0-1'), equals('value@2'));
    expect(testTraceState.get('key_0-2'), equals('value@1'));
    expect(testTraceState.get('key_@vendor'), isNull);
    expect(
        testTraceState.toString(), equals('key_0-1=value@2,key_0-2=value@1'));
    expect(testTraceState.isEmpty, isFalse);
    expect(testTraceState.size, equals(2));
  });

  test('key regex, valid key', () {
    final matchResult = TraceState.validKeyRegex.matchAsPrefix('key_0-1')!;

    expect(matchResult, isNotNull);
    expect(matchResult.group(0), equals('key_0-1'));
  });

  test('key regex, valid vendor key', () {
    final matchResult = TraceState.validKeyRegex.matchAsPrefix('key_@vendor')!;

    expect(matchResult, isNotNull);
    expect(matchResult.group(0), equals('key_@vendor'));
  });

  test('value regex, valid value', () {
    final matchResult = TraceState.validValueRegex.matchAsPrefix('value@2')!;

    expect(matchResult, isNotNull);
    expect(matchResult.group(0), equals('value@2'));
  });

  test('key regex, invalid key', () {
    final matchResult = TraceState.validKeyRegex.matchAsPrefix('key&0-2');

    expect(matchResult, isNull);
  });

  test('key regex, invalid vendor key', () {
    final matchResult = TraceState.validKeyRegex
        .matchAsPrefix('key_@thisisalotlongerthan13characters');

    expect(matchResult, isNull);
  });

  test('value regex, invalid value', () {
    final matchResult = TraceState.validValueRegex.matchAsPrefix('0,value=2');

    expect(matchResult, isNull);
  });
}
