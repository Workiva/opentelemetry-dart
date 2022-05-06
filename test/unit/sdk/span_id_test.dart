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
import 'package:opentelemetry/api.dart' as api;
import 'package:test/test.dart';

class MockIdGenerator implements api.IdGenerator {
  @override
  List<int> generateSpanId() {
    return [1, 2, 3, 4, 5, 6, 7, 8];
  }

  @override
  List<int> generateTraceId() {
    throw UnimplementedError();
  }
}

void main() {
  test('create with int list', () {
    final testSpanId = api.SpanId([1, 2, 3]);

    expect(testSpanId.get(), equals([1, 2, 3]));
    expect(testSpanId.isValid, isTrue);
    expect(testSpanId.toString(), equals('010203'));
  });

  test('create from id generator', () {
    final testSpanId = api.SpanId.fromIdGenerator(MockIdGenerator());

    expect(testSpanId.get(), equals([1, 2, 3, 4, 5, 6, 7, 8]));
    expect(testSpanId.isValid, isTrue);
    expect(testSpanId.toString(), equals('0102030405060708'));
  });

  test('create from string', () {
    final testSpanId = api.SpanId.fromString('010203');

    expect(testSpanId.get(), equals([0, 0, 0, 0, 0, 1, 2, 3]));
    expect(testSpanId.isValid, isTrue);
    expect(testSpanId.toString(), equals('0000000000010203'));
  });

  test('create invalid id', () {
    final testSpanId = api.SpanId.invalid();

    expect(testSpanId.get(), equals([0, 0, 0, 0, 0, 0, 0, 0]));
    expect(testSpanId.isValid, isFalse);
    expect(testSpanId.toString(), equals('0000000000000000'));
  });

  test('create root id', () {
    final testSpanId = api.SpanId.root();

    expect(testSpanId.get(), equals([]));
    expect(testSpanId.isValid, true);
    expect(testSpanId.toString(), equals(''));
  });
}
