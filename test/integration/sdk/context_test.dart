// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart';
import 'package:test/test.dart';

void main() {
  test('setValue and getValue', () {
    final testKey = Context.createKey('Set Key');

    final parentContext = ContextManager.current;
    final childContext = parentContext.setValue(testKey, 'bar');
    expect(parentContext.getValue(testKey), isNull);
    expect(childContext.getValue(testKey), equals('bar'));
  });

  test('execute runs sync fn', () {
    expect(ContextManager.current.execute(() => 42), equals(42));
  });

  test('execute runs async fn', () async {
    expect(await ContextManager.current.execute(() async => 42), equals(42));
  });
}
