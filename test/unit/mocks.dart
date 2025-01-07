// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/read_only_span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class MockContext extends Mock implements Context {}

class MockHttpClient extends Mock implements http.Client {}

class MockSpan extends Mock implements Span {}

class MockReadOnlySpan extends Mock implements ReadOnlySpan {}

class MockSpanProcessor extends Mock implements SpanProcessor {}

class FakeTimeProvider extends Mock implements sdk.TimeProvider {
  FakeTimeProvider({required Int64 now}) : _now = now;
  final Int64 _now;

  @override
  Int64 get now => _now;
}
