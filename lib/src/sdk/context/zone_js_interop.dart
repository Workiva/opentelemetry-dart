import 'dart:html';
import 'dart:js';

import 'package:js/js.dart';
import 'package:opentelemetry/api.dart';

// For the purpose of demoing the window.otel_context_api var was set by the synthetic test script.
@JS('window.otel_context_api')
class JsContextAPI {
  external static JsContext active();
  @JS('with')
  external static execute(JsContext context, Function() fn);
  @JS('bind')
  external static bind(JsContext context, Function() fn);
}


@JS('window.rootSpanContext')
class JsContext {
  external getValue(JsSymbol key);
  external JsContext setValue(JsSymbol key, value);
  external JsContext deleteValue(JsSymbol key);
}

@JS('Symbol')
class JsSymbol {
  @JS('for')
  external static JsSymbol SymbolFromRegistry(String key);
}

@JS()
class JsSpan {
  @JS('_spanContext')
  external JsSpanContext spanContext();
}

@JS()
@anonymous
class JsSpanContext {
  external String traceId;
  external String spanId;
  external int traceFlags;

  external factory JsSpanContext(
      {String traceId, String spanId, int traceFlags});
}

@JS('window.otel_trace_api')
class JsTraceAPI {
  external static JsContext setSpanContext(
      JsContext context, JsSpanContext spanContext);
}
