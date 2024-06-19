import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart'
    show ConsoleExporter, SimpleSpanProcessor, TracerProviderBase;
import 'package:opentelemetry/src/experimental_api.dart'
    show globalContextManager, NoopContextManager, registerGlobalContextManager;

class MapSetter implements TextMapSetter<Map> {
  @override
  void set(Map carrier, String key, String value) {
    carrier[key] = value;
  }
}

class MapGetter implements TextMapGetter<Map> {
  @override
  String? get(Map? carrier, String key) {
    return (carrier == null) ? null : carrier[key];
  }

  @override
  Iterable<String> keys(Map carrier) {
    return carrier.keys.map((key) => key.toString());
  }
}

void main(List<String> args) async {
  final tp =
      TracerProviderBase(processors: [SimpleSpanProcessor(ConsoleExporter())]);
  registerGlobalTracerProvider(tp);

  final cm = NoopContextManager();
  registerGlobalContextManager(cm);

  final tmp = W3CTraceContextPropagator();
  registerGlobalTextMapPropagator(tmp);

  final span = tp.getTracer('instrumentation-name').startSpan('test-span-0');
  final carrier = <String, String>{};
  tmp.inject(contextWithSpan(cm.active, span), carrier, MapSetter());
  await test(carrier);
  span.end();
}

Future test(Map<String, String> carrier) async {
  globalTracerProvider
      .getTracer('instrumentation-name')
      .startSpan('test-span-1',
          context: globalTextMapPropagator.extract(
              globalContextManager.active, carrier, MapGetter()))
      .end();
}
