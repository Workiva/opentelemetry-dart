// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:test/test.dart';

void main() {
  test('Verify context create root by default', () {
    final logRecord = api.LogRecord();
    expect(logRecord.context, api.Context.root);
  });

  test('Verify context from span', () {
    final tracer = sdk.TracerProviderBase().getTracer('test');
    final parent = tracer.startSpan('parent');
    final context = api.contextWithSpan(api.Context.current, parent);
    final logRecord = api.LogRecord(context: context);
    expect(logRecord.context, context);
  });

  test('Verify attribute null create attribute empty', () {
    final logRecord = api.LogRecord();
    expect(logRecord.attributes.keys, sdk.Attributes.empty().keys);
  });
}
