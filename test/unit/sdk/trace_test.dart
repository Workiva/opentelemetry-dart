// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:async';
import 'package:opentelemetry/src/api/open_telemetry.dart';
import 'package:test/test.dart';

void main() {
  test('traceSync returns value', () {
    final value = traceContextSync('foo', (_) => 'bar');
    expect(value, 'bar');
  });

  test('traceSync throws exception', () {
    final bang = Exception('bang!');
    expect(() => traceContextSync('foo', (_) => throw bang), throwsA(bang));
  });

  test('traceSync wants you to use trace instead', () {
    expect(() => traceContextSync('foo', (_) async => ''), throwsArgumentError);
    expect(() => traceContextSync('foo', Future.value), throwsArgumentError);
  });

  test('trace returns future value', () async {
    await expectLater(
        traceContext('foo', (_) async => 'bar'), completion('bar'));
    await expectLater(
        traceContext('foo', (_) => Future.value('baz')), completion('baz'));
  });

  test('trace throws future error', () async {
    final bang = Exception('bang!');
    await expectLater(
        traceContext('foo', (_) async => throw bang), throwsA(bang));
  });
}
