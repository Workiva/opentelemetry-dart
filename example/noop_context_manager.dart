// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart'
    show ConsoleExporter, SimpleSpanProcessor, TracerProviderBase;
import 'package:opentelemetry/src/experimental_api.dart' show NoopContextManager;

void main(List<String> args) async {
  final tp =
      TracerProviderBase(processors: [SimpleSpanProcessor(ConsoleExporter())]);
  registerGlobalTracerProvider(tp);

  final cm = NoopContextManager();
  registerGlobalContextManager(cm);

  final span = tp.getTracer('instrumentation-name').startSpan('test-span-0');
  await test(contextWithSpan(cm.active, span));
  span.end();
}

Future test(Context context) async {
  spanFromContext(context).setStatus(StatusCode.error, 'test error');
  globalTracerProvider
      .getTracer('instrumentation-name')
      .startSpan('test-span-1', context: context)
      .end();
}
