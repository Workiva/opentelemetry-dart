import 'package:opentelemetry/src/sdk/trace/tracer_provider.dart';
import 'package:test/test.dart';

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
  });
}
