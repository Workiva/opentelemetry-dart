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

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart';
import 'package:test/test.dart';

void main() {
  test('Resource attributes value is not String', () {
    expect(
        () => Resource([Attribute.fromBoolean('foo', true)]),
        throwsA(isA<ArgumentError>().having((error) => error.message, 'message',
            'Attributes value must be String.')));
  });
}
