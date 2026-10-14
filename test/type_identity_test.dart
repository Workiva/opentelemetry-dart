// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart' as span;
import 'package:opentelemetry_wk/api.dart' as wk_api;
import 'package:opentelemetry_wk/sdk.dart' as wk_sdk;
// ignore: implementation_imports
import 'package:opentelemetry_wk/src/sdk/trace/span.dart' as wk_span;
import 'package:test/test.dart';

void main() {
  test('api types are the opentelemetry_wk types', () {
    expect(api.TracerProvider, wk_api.TracerProvider);
    expect(api.TextMapPropagator, wk_api.TextMapPropagator);
    expect(api.Context, wk_api.Context);
  });

  test('sdk types are the opentelemetry_wk types', () {
    expect(sdk.SpanProcessor, wk_sdk.SpanProcessor);
    expect(sdk.SpanExporter, wk_sdk.SpanExporter);
    expect(sdk.SimpleSpanProcessor, wk_sdk.SimpleSpanProcessor);
    expect(span.Span, wk_span.Span);
  });

  test('values cross the package boundary without conversion', () {
    final wk_sdk.SpanProcessor processor = sdk.SimpleSpanProcessor(
      sdk.ConsoleExporter(),
    );
    final List<sdk.SpanProcessor> processors = [
      wk_sdk.SimpleSpanProcessor(wk_sdk.ConsoleExporter()),
      processor,
    ];
    expect(processors, hasLength(2));
  });

  test('global tracer provider is shared', () {
    final provider = sdk.TracerProviderBase();
    api.registerGlobalTracerProvider(provider);
    expect(wk_api.globalTracerProvider, same(provider));
  });
}
