// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:test/test.dart';

void main() {
  final generator = IdGenerator();

  test('generateSpanId is the correct length', () {
    expect(generator.generateSpanId().length, equals(8));
  });

  test('generateTraceId is the correct length', () {
    expect(generator.generateTraceId().length, equals(16));
  });
}
