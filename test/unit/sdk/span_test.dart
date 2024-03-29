// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

void main() {
  test('span change name', () {
    final span = Span(
        'foo',
        api.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, api.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([api.Attribute.fromString('service-name', 'foo')]),
        sdk.InstrumentationScope(
            'library_name', 'library_version', 'url://schema', []),
        api.SpanKind.internal,
        [],
        sdk.SpanLimits(),
        sdk.DateTimeTimeProvider().now);
    expect(span.name, equals('foo'));

    span.setName('bar');
    expect(span.name, equals('bar'));
    expect(span.resource.attributes.get('service-name'), equals('foo'));
  });
}
