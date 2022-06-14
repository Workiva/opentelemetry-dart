// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:async';
import 'package:opentelemetry/sdk.dart' show trace;
import 'package:opentelemetry/src/sdk/open_telemetry.dart';
import 'package:test/test.dart';

void main() {
  test('traceSync returns value', () {
    final value = traceSync('foo', () => 'bar');
    expect(value, 'bar');
  });

  test('traceSync throws exception', () {
    final bang = Exception('bang!');
    expect(() => traceSync('foo', () => throw bang), throwsA(bang));
  });

  test('traceSync wants you to use trace instead', () {
    expect(() => traceSync('foo', () async => ''), throwsArgumentError);
    expect(() => traceSync('foo', () => Future.value()), throwsArgumentError);
  });

  test('trace returns future value', () async {
    await expectLater(trace('foo', () async => 'bar'), completion('bar'));
    await expectLater(
        trace('foo', () => Future.value('bazz')), completion('bazz'));
  });

  test('trace throws future error', () async {
    // Exception thrown from synchronous code in async function.
    final bang = Exception('bang!');
    await expectLater(trace('foo', () async => throw bang), throwsA(bang));

    // Exception thrown from asynchronous code in async function.
    final buzz = Exception('buzz!!');
    await expectLater(
        trace('foo', () async => Future.error(buzz)), throwsA(buzz));

    // Exception thrown from asynchronous code in async function.
    final bazz = Exception('bazz!!');
    await expectLater(trace('foo', () => Future.error(bazz)), throwsA(bazz));
  });
}
