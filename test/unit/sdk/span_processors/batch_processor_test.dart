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
import 'package:opentelemetry/src/sdk/trace/span_processors/batch_processor.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  BatchSpanProcessor processor;
  SpanExporter mockExporter;
  Span mockSpan1, mockSpan2, mockSpan3;

  setUp(() {
    mockSpan1 = MockSpan();
    mockSpan2 = MockSpan();
    mockSpan3 = MockSpan();

    mockExporter = MockSpanExporter();
    processor = BatchSpanProcessor(mockExporter,
        maxExportBatchSize: 2, scheduledDelayMillis: 100);
  });

  tearDown(() {
    processor.shutdown();
    reset(mockExporter);
  });

  test('forceFlush', () {
    processor
      ..onEnd(mockSpan1)
      ..onEnd(mockSpan2)
      ..onEnd(mockSpan3)
      ..forceFlush();

    verify(mockExporter.export([mockSpan1, mockSpan2])).called(1);
    verify(mockExporter.export([mockSpan3])).called(1);
    verify(mockExporter.forceFlush()).called(1);
  });

  test('shutdown shuts exporter down', () {
    processor.shutdown();

    verify(mockExporter.shutdown()).called(1);
    verify(mockExporter.forceFlush()).called(1);
  });
}
