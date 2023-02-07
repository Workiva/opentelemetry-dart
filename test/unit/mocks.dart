// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/exporters/span_exporter.dart';
import 'package:opentelemetry/src/api/span_processors/span_processor.dart';
import 'package:opentelemetry/src/api/trace/span.dart';

@GenerateNiceMocks([
  MockSpec<Client>(as: #MockHTTPClient),
])
export 'mocks.mocks.dart';

class MockContext extends Mock implements Context {}

class MockSpan extends Mock implements Span {}

class MockSpanExporter extends Mock implements SpanExporter {}

class MockSpanProcessor extends Mock implements SpanProcessor {}
