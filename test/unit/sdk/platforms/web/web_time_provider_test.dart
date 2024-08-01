// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('chrome')

import 'package:fixnum/fixnum.dart';
import 'package:opentelemetry/src/sdk/platforms/web/time_providers/web_time_provider.dart';
import 'package:test/test.dart';

void main() {
  group('msToNs', () {
    test('msToNs rounds large fractions', () {
      final cases = [
        [809.2223347138977, Int64(809222335)],
        [821.5999999046326, Int64(821600000)],
        [1427.1999998092651, Int64(1427200000)],
      ];
      for (final c in cases) {
        final expected = c[1];
        expect(msToNs(c[0] as double), expected);
      }
    });
    test('msToNs rounds large wholes', () {
      final cases = [
        [1722291888610.5, Int64(17222918886105000) * 100],
        [1722292170313.4, Int64(17222921703134000) * 100],
        [1722292193622.1, Int64(17222921936221000) * 100],
      ];
      for (final c in cases) {
        final expected = c[1];
        expect(msToNs(c[0] as double, fractionDigits: 1), expected);
      }
    });
  });
}
