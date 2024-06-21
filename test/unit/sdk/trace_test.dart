// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:async';
import 'package:opentelemetry/src/api/open_telemetry.dart';
import 'package:test/test.dart';

void main() {
  test('traceContextSync returns value', () {
    final value = traceContextSync('foo', (_) => 'bar');
    expect(value, 'bar');
  });

  test('traceContextSync throws exception', () {
    final bang = Exception('bang!');
    expect(() => traceContextSync('foo', (_) => throw bang), throwsA(bang));
  });

  test('traceContextSync wants you to use trace instead', () {
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
    // Exception thrown from synchronous code in async function.
    final bang = Exception('bang!');
    await expectLater(
        traceContext('foo', (_) async => throw bang), throwsA(bang));

    // Exception thrown from asynchronous code in async function.
    final buzz = Exception('buzz!!');
    await expectLater(
        traceContext('foo', (_) async => Future.error(buzz)), throwsA(buzz));

    // Exception thrown from asynchronous code in async function.
    final baz = Exception('baz!!');
    await expectLater(
        traceContext('foo', (_) => Future.error(baz)), throwsA(baz));
  });
}
