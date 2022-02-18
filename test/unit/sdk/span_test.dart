@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

void main() {
  test('span change name', () {
    final span = Span(
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
