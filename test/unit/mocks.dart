// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/span_exporter.dart';
import 'package:opentelemetry/src/sdk/trace/read_only_span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';

@GenerateNiceMocks([
  MockSpec<Context>(),
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<Span>(),
  MockSpec<ReadOnlySpan>(),
  MockSpec<SpanExporter>(),
  MockSpec<SpanProcessor>()
])
export 'mocks.mocks.dart';
