import 'dart:js';

import '../../../api.dart';
import 'package:js/js.dart' as js;

import '../../api/context/context.dart';
import 'zone_js_interop.dart';

class ZoneJsContext implements Context {
  final JsContext _context;

  ZoneJsContext._(this._context);
  ZoneJsContext(this._context);

  static ZoneJsContext get current => active();

  static ZoneJsContext get root => ZoneJsContext(JsContext());

  static ZoneJsContext active() {
    return ZoneJsContext(JsContextAPI.active());
  }

  // Executes the supplied Dart function in the context of the current zone.
  // This could be an issue if the function is expecting to be executed within a Dart zone.
  @override
  R execute<R>(R Function() fn) {
    return JsContextAPI.execute(_context, allowInterop(fn));
  }

  @override
  T? getValue<T>(ContextKey key) {
    var value = _context.getValue(JsSymbol.SymbolFromRegistry(key.name));
    return value as T;
  }

  @override
  ZoneJsContext setValue(ContextKey key, Object value) {
    return ZoneJsContext._(
        _context.setValue(JsSymbol.SymbolFromRegistry(key.name), value));
  }

// Will need to convert JS span to Dart span.
// This is going to be a lot of interop mapping classes.
  @override
  Span get span => throw UnimplementedError();

  SpanContext getSpanContext() {
    var span = getValue(spanKey);
    if (span == null) {
      return SpanContext.invalid();
    }

    return SpanContext(
        TraceId.fromString(span.spanContext().traceId),
        SpanId.fromString(span.spanContext().spanId),
        span.spanContext().traceFlags,
        TraceState.empty());
  }

  @override
  SpanContext get spanContext => getSpanContext();

// TO-DO: update withSpan to convert Dart span to JS span.
//
// This currently doesn't work for dart -> js context propagation.
// A JS span trying to get a span from context will error because it is trying to cast to a JS Span object.
// This will need to be fixed by updating the dart context API to convert the Dart span to a JS span.
  @override
  Context withSpan(Span span) {
    final jsCtx = JsTraceAPI.setSpanContext(
        _context,
        JsSpanContext(
            traceId: span.spanContext.traceId.toString(),
            spanId: span.spanContext.spanId.toString(),
            traceFlags: span.spanContext.traceFlags));
    
    return ZoneJsContext(jsCtx);
  }
}
