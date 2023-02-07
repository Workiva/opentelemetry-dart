// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

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
    expect(span.resource!.attributes.get('service-name'), equals('foo'));
  });
}
