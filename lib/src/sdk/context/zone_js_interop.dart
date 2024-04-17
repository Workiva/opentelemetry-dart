import 'dart:html';

import 'package:js/js.dart';
import 'package:opentelemetry/api.dart';

// For the purpose of demoing the window.otel_context_api var was set by the synthetic test script.
@JS('window.otel_context_api')
class JsContextAPI {
  external static JsContext active();
  @JS('with')
  external static execute(dynamic context, Function() fn);
}

@JS()
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
abstract class JsSpan {
  @JS('_spanContext')
  external JsSpanContext spanContext();
}

@JS('_spanContext')
class JsSpanContext {
  external String traceId;
  external String spanId;
  external int traceFlags;
}
