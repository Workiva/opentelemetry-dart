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
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('span change name', () {
    final span = sdk.Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([api.Attribute.fromString('service-name', 'foo')]),
        sdk.InstrumentationLibrary('library_name', 'library_version'));
    expect(span.name, equals('foo'));

    span.name = 'bar';
    expect(span.name, equals('bar'));
    expect(span.resource.attributes.get('service-name'), equals('foo'));
  });
}
