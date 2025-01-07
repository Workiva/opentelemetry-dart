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
  late SimpleSpanProcessor processor;

  setUp(() {
    exporter = TestSpanExporter();
    processor = SimpleSpanProcessor(exporter);
  });

  group('onEnd', () {
    test('exports sampled span', () {
      processor.onEnd(sampledSpan);
      expect(exporter.spans, [sampledSpan]);
    });

    test('does not export unsampled span', () {
      processor.onEnd(unsampledSpan);
      expect(exporter.spans, isEmpty);
    });

    test('does not export after shutdown', () {
      processor
        ..shutdown()
        ..onEnd(sampledSpan);
      expect(exporter.spans, isEmpty);
    });
  });

  group('shutdown', () {
    test('calls exporter.shutdown()', () {
      processor.shutdown();
      expect(exporter.isShutdown, isTrue);
    });
  });
}
