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
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/exporters/span_exporter.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/simple_processor.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  SpanExporter exporter;
  SimpleSpanProcessor processor;
  Span span;

  setUp(() {
    exporter = MockSpanExporter();
    processor = SimpleSpanProcessor(exporter);
    span = MockSpan();
  });

  test('executes export', () {
    processor.onEnd(span);

    verify(exporter.export([span])).called(1);
  });

  test('flushes exporter on forced flush', () {
    processor.forceFlush();

    verify(exporter.forceFlush()).called(1);
  });

  test('does not export if shut down', () {
    processor
      ..shutdown()
      ..onEnd(span);

    verify(exporter.shutdown()).called(1);
    verify(exporter.forceFlush()).called(1);
    verifyNever(exporter.export([span]));
  });
}
