// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart'
    show SpanContext, SpanId, SpanKind, TraceFlags, TraceId, TraceState;
import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

class TestSpanExporter extends SpanExporter {
  final spans = <ReadOnlySpan>[];

  bool isShutdown = false;

  @override
  void export(List<ReadOnlySpan> spans) {
    this.spans.addAll(spans);
  }

  @override
  void forceFlush() {}

  @override
  void shutdown() {
    isShutdown = true;
  }
}

void main() {
  final sampledSpanContext = SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
      TraceFlags.sampled, TraceState.empty());
  final sampledSpan = Span(
      'foo',
      sampledSpanContext,
      SpanId([4, 5, 6]),
      [],
      DateTimeTimeProvider(),
      Resource([]),
      InstrumentationScope(
          'library_name', 'library_version', 'url://schema', []),
      SpanKind.client,
      [],
      SpanLimits(),
      DateTimeTimeProvider().now);

  final unsampledSpanContext = SpanContext(TraceId([1, 2, 3]),
      SpanId([7, 8, 9]), TraceFlags.none, TraceState.empty());
  final unsampledSpan = Span(
      'foo',
      unsampledSpanContext,
      SpanId([4, 5, 6]),
      [],
      DateTimeTimeProvider(),
      Resource([]),
      InstrumentationScope(
          'library_name', 'library_version', 'url://schema', []),
      SpanKind.client,
      [],
      SpanLimits(),
      DateTimeTimeProvider().now);

  late TestSpanExporter exporter;
  late BatchSpanProcessor processor;

  setUp(() {
    exporter = TestSpanExporter();
    processor = BatchSpanProcessor(exporter,
        maxExportBatchSize: 2, scheduledDelayMillis: 60 * 60 * 1000);
  });

  group('onEnd', () {
    test('adds sampled span to buffer', () {
      processor.onEnd(sampledSpan);
      expect(exporter.spans, isEmpty);
      processor.forceFlush();
      expect(exporter.spans, [sampledSpan]);
    });

    test('does not add unsampled span to buffer', () {
      processor.onEnd(unsampledSpan);
      expect(exporter.spans, isEmpty);
      processor.forceFlush();
      expect(exporter.spans, isEmpty);
    });

    test('does not add span to buffer after shutdown', () {
      processor
        ..shutdown()
        ..onEnd(sampledSpan)
        ..forceFlush();
      expect(exporter.spans, isEmpty);
    });
  });

  group('forceFlush', () {
    test('flushes buffer', () {
      processor
        ..onEnd(sampledSpan)
        ..forceFlush();
      expect(exporter.spans, [sampledSpan]);
    });
  });

  group('shutdown', () {
    test('calls exporter.shutdown()', () {
      processor.shutdown();
      expect(exporter.isShutdown, isTrue);
    });
  });
}
