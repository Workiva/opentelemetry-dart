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
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

void main() {
  final testSpanContext = sdk.SpanContext(api.TraceId([1, 2, 3]),
      api.SpanId([7, 8, 9]), api.TraceFlags.none, sdk.TraceState.empty());
  final testSpan = Span(
      'foo',
      testSpanContext,
      api.SpanId([4, 5, 6]),
      [],
      sdk.DateTimeTimeProvider(),
      sdk.Resource([]),
      sdk.InstrumentationLibrary('library_name', 'library_version'));

  group('get Span', () {
    test('returns Span when exists', () {
      final childContext = api.Context.current.withSpan(testSpan);

      expect(childContext.span, same(testSpan));
    });

    test('returns null when not exists', () {
      final context = api.Context.current;

      expect(context.span, isNull);
    });
  });

  group('get SpanContext', () {
    test('returns SpanContext when Span exists', () {
      final testContext = api.Context.current.withSpan(testSpan);

      expect(testContext.spanContext, same(testSpanContext));
    });

    test('returns null when Span not exists', () {
      final testContext = api.Context.current;

      expect(testContext.spanContext, isNull);
    });
  });
}
