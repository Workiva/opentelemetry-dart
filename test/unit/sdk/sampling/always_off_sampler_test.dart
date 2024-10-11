// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

void main() {
  test('Context contains a Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final traceState = api.TraceState.fromString('test=one,two');
    final testSpan = Span(
        'foo',
        api.SpanContext(
            traceId, api.SpanId([7, 8, 9]), api.TraceFlags.none, traceState),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationScope(
            'library_name', 'library_version', 'url://schema', []),
        api.SpanKind.internal,
        [],
        sdk.SpanLimits(),
        sdk.DateTimeTimeProvider().now);
    final testContext = api.contextWithSpan(api.active, testSpan);

    final result = sdk.AlwaysOffSampler().shouldSample(
        testContext, traceId, testSpan.name, api.SpanKind.internal, [], []);

    expect(result.decision, equals(sdk.Decision.drop));
    expect(result.spanAttributes, equals([]));
    expect(result.traceState, same(traceState));
  });
  test('Context does not contain a Span', () {
    final traceId = api.TraceId([1, 2, 3]);
    final attributesList = [
      api.Attribute.fromBoolean('boolTest', true),
      api.Attribute.fromDouble('double', 0.3)
    ];
    final testSpan = Span(
        'foo',
        api.SpanContext(traceId, api.SpanId([7, 8, 9]), api.TraceFlags.none,
            api.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationScope(
            'library_name', 'library_version', 'url://schema', []),
        api.SpanKind.internal,
        [],
        sdk.SpanLimits(),
        sdk.DateTimeTimeProvider().now)
      ..setAttributes(attributesList);

    final result = sdk.AlwaysOffSampler().shouldSample(api.active, traceId,
        testSpan.name, api.SpanKind.internal, attributesList, []);

    expect(result.decision, equals(sdk.Decision.drop));
    expect(result.spanAttributes, attributesList);
    expect(result.traceState.isEmpty, isTrue);
  });
}
