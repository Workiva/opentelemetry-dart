// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/experimental_sdk.dart';

class MockContext extends Mock implements Context {}

class MockHttpClient extends Mock implements http.Client {}

class MockSpan extends Mock implements Span {}

class MockReadOnlySpan extends Mock implements ReadOnlySpan {}

class MockSpanProcessor extends Mock implements SpanProcessor {}

class MockLogRecordProcessor extends Mock implements LogRecordProcessor {}

class MockLogRecordExporter extends Mock implements LogRecordExporter {}

class FakeTimeProvider extends Mock implements TimeProvider {
  FakeTimeProvider({required Int64 now}) : _now = now;
  final Int64 _now;

  @override
  Int64 get now => _now;
}

// reference: https://stackoverflow.com/a/38709440/7676003
void Function() overridePrint(void Function() testFn, Function(String msg) onPrint) => () {
      final spec = ZoneSpecification(print: (_, __, ___, msg) {
        // Add to log instead of printing to stdout
        onPrint(msg);
      });
      return Zone.current.fork(specification: spec).run<void>(testFn);
    };
