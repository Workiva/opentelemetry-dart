// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')

import 'package:opentelemetry/api.dart';
import 'package:test/test.dart';

void main() {
  test("test bool key can't be empty", () {
    expect(
        () => Attribute.fromBoolean('', true),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });

  test("test int key can't be empty", () {
    expect(
        () => Attribute.fromInt('', 2),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });

  test("test String key can't be empty", () {
    expect(
        () => Attribute.fromString('', 'abc'),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });

  test("test double key can't be empty", () {
    expect(
        () => Attribute.fromDouble('', 0.1),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });
  test("test BoolList key can't be empty", () {
    expect(
        () => Attribute.fromBooleanList('', [true, false]),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });

  test("test IntList key can't be empty", () {
    expect(
        () => Attribute.fromIntList('', [2, 3]),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });
  test("test StringList key can't be empty", () {
    expect(
        () => Attribute.fromStringList('', ['1', '2']),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });

  test("test DoubleList key can't be empty", () {
    expect(
        () => Attribute.fromDoubleList('', [0.2, 0.1]),
        throwsA(isA<AssertionError>().having((error) => error.message,
            'message', "Attribute key can't be empty.")));
  });
}
