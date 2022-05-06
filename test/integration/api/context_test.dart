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
  test('setValue and getValue', () {
    final testKey = Context.createKey('Set Key');

    final parentContext = Context.current;
    final childContext = parentContext.setValue(testKey, 'bar');
    expect(parentContext.getValue(testKey), isNull);
    expect(childContext.getValue(testKey), equals('bar'));
  });

  test('execute runs sync fn', () {
    expect(Context.current.execute(() => 42), equals(42));
  });

  test('execute runs async fn', () async {
    expect(await Context.current.execute(() async => 42), equals(42));
  });
}
