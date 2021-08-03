import '../../../src/api/context/context.dart';
import '../../../src/api/trace/context_utils.dart';
import '../../../src/api/trace/trace_state.dart';
import '../../../src/api/trace/tracer.dart' as tracer_api;
import 'id_generator.dart';
import 'span.dart';
import 'span_context.dart';

/// An interface for creating [Span]s and propagating context in-process.
class Tracer implements tracer_api.Tracer {
  final IdGenerator _idGenerator = IdGenerator();

  @override
  Span startSpan(String name, {Context context}) {
    context ??= Context.current;

    String parentSpanId;
    String traceId;
    TraceState traceState;
    
    final spanId = _idGenerator.generateSpanId();

    final parentSpanContext = getSpanContext(context);

    if (parentSpanContext == null) {
      traceId = _idGenerator.generateTraceId();
    } else {
      parentSpanId = parentSpanContext.spanId;
      traceId = parentSpanContext.traceId;
      traceState = parentSpanContext.traceState;
    }

    final spanContext = SpanContext(traceId, spanId, traceState);

    return Span(name, spanContext, parentSpanId);
  }
}
