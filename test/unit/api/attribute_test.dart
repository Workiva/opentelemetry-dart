// Copyright 2021-2022 Workiva Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@TestOn('vm')

import 'package:opentelemetry/api.dart';
import 'package:test/test.dart';

void main() {
  test("test bool key can't be null", () {
    expect(
        () => Attribute.fromBoolean(null, true),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });

  test("test int key can't be null", () {
    expect(
        () => Attribute.fromInt(null, 2),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });

  test("test String key can't be null", () {
    expect(
        () => Attribute.fromString(null, 'abc'),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });

  test("test double key can't be null", () {
    expect(
        () => Attribute.fromDouble(null, 0.1),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });
  test("test BoolList key can't be null", () {
    expect(
        () => Attribute.fromBooleanList(null, [true, false]),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });

  test("test IntList key can't be null", () {
    expect(
        () => Attribute.fromIntList(null, [2, 3]),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });
  test("test StringList key can't be null", () {
    expect(
        () => Attribute.fromStringList(null, ['1', '2']),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });

  test("test DoubleList key can't be null", () {
    expect(
        () => Attribute.fromDoubleList(null, [0.2, 0.1]),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, 'message', "key can't be null.")));
  });
}
