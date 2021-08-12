import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';
import 'package:opentelemetry/src/sdk/trace/tracer_provider.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  test('getTracer stores tracers by name', () {
    final provider = TracerProvider();
    final fooTracer = provider.getTracer('foo');
    final barTracer = provider.getTracer('bar');
    final fooWithVersionTracer = provider.getTracer('foo', version: '1.0');

    expect(fooTracer, allOf([
      isNot(barTracer),
      isNot(fooWithVersionTracer),
      same(provider.getTracer('foo'))
    ]));

    expect(provider.spanProcessors, isA<List<SpanProcessor>>());
  });

  test('tracerProvider custom span processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    final provider = TracerProvider(processors: [mockProcessor1, mockProcessor2]);

    expect(provider.spanProcessors, [mockProcessor1, mockProcessor2]);
  });
}
