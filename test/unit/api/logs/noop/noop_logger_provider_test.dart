// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:test/test.dart';

void main() {
  test('returns noop logger', () {
    final noopLoggerProvider = api.NoopLoggerProvider();
    expect(noopLoggerProvider.get('test'), const api.NoopLogger());
  });
}
