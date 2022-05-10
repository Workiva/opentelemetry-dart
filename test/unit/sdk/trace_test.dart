@TestOn('vm')
import 'package:opentelemetry/sdk.dart' show trace;
import 'package:test/test.dart';

void main() {
  test('trace returns value', () {
    final value = trace('foo', () => 'bar');
    expect(value, 'bar');
  });

  test('trace throws exception', () {
    final bang = Exception('bang!');
    expect(() => trace('foo', () => throw bang), throwsA(bang));
  });

  test('trace returns future value', () async {
    await expectLater(trace('foo', () async => 'bar'), completion('bar'));
  });

  test('trace throws future error', () async {
    // Exception thrown from synchronous code in async function.
    final bang = Exception('bang!');
    await expectLater(trace('foo', () async => throw bang), throwsA(bang));

    // Exception thrown from asynchronous code in async function.
    final buzz = Exception('buzz!!');
    await expectLater(trace('foo', () async => Future.error(buzz)), throwsA(buzz));
  });
}