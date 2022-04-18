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
        sdk.Resource(sdk.Attributes.empty()),
        sdk.InstrumentationLibrary('library_name', 'library_version'));
    expect(span.name, 'foo');

    span.name = 'bar';
    expect(span.name, 'bar');
  });
}
