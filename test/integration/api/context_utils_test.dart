import 'package:opentelemetry/api.dart';
import 'package:test/test.dart';

void main() {
  test('withContext attaches and detaches with sync fn', () {
    expect(withContext(Context.current, () => 42), equals(42));
  });

  test('withContext attaches and detaches with async fn', () async {
    expect(await withContext(Context.current, () async => 42), equals(42));
  });
}
