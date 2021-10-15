import 'package:opentelemetry/sdk.dart';
import 'package:test/test.dart';

void main() {
  test('inject null carrier', () {
    MapInjector().set(null, 'foo', 'bar');
  });

  test('inject carrier', () {
    final map = {};
    MapInjector().set(map, 'foo', 'bar');

    expect(map['foo'], 'bar');
  });

  test('extract null carrier', () {
    expect(MapExtractor().get(null, 'foo'), isNull);
  });

  test('extract carrier', () {
    final map = {'foo': 'bar'};

    expect(MapExtractor().get(map, 'foo'), 'bar');
  });

  test('extract keys', () {
    final map = {'foo': 'bar', 'baz': 'qux'};

    expect(MapExtractor().keys(map), ['foo', 'baz']);
  });
}
