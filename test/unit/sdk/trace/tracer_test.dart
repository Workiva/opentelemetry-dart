// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:opentelemetry/src/sdk/trace/tracer_provider.dart';
import 'package:test/test.dart';

void main() {
  group('startSpan', () {
    final tracer = TracerProviderBase().getTracer('test');

    test('with newRoot true', () {
      final parent = tracer.startSpan('parent');
      final context = api.contextWithSpan(api.Context.current, parent);
      final span =
          (tracer as Tracer).startSpan('', newRoot: true, context: context);
      expect(span.parentSpanId.isValid, isFalse);
      expect(span.spanContext.traceId.isValid, isTrue);
      expect(
          span.spanContext.traceId, isNot(equals(parent.spanContext.traceId)));
    });

    test('with newRoot false', () {
      final parent = tracer.startSpan('parent');
      final context = api.contextWithSpan(api.Context.current, parent);
      final span =
          (tracer as Tracer).startSpan('', newRoot: false, context: context);
      expect(span.parentSpanId.isValid, isTrue);
      expect(span.parentSpanId, equals(parent.spanContext.spanId));
      expect(span.spanContext.traceId.isValid, isTrue);
      expect(span.spanContext.traceId, equals(parent.spanContext.traceId));
    });
  });
}
