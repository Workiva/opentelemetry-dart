import 'dart:async';

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart'
    show ConsoleExporter, SimpleSpanProcessor, TracerProviderBase;
import 'package:opentelemetry/src/experimental_api.dart'
    show ZoneContext, ZoneContextManager;

void main(List<String> args) async {
  final tp =
      TracerProviderBase(processors: [SimpleSpanProcessor(ConsoleExporter())]);
  registerGlobalTracerProvider(tp);

  final cm = ZoneContextManager();
  registerGlobalContextManager(cm);

  final span = tp.getTracer('instrumentation-name').startSpan('test-span-0');
  await (contextWithSpan(cm.active, span) as ZoneContext).run((_) => test());
  span.end();
}

Future test() async {
  spanFromContext(globalContextManager.active)
      .setStatus(StatusCode.error, 'test error');
  globalTracerProvider
      .getTracer('instrumentation-name')
      .startSpan('test-span-1')
      .end();
}
