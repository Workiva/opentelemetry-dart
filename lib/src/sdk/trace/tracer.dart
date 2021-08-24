import '../../../src/api/context/context.dart';
import '../../../src/api/trace/context_utils.dart';
import '../../../src/api/trace/trace_state.dart';
import '../../../src/api/trace/tracer.dart' as tracer_api;
import 'id_generator.dart';
import 'span.dart';
import 'span_context.dart';
import 'span_processors/span_processor.dart';

/// An interface for creating [Span]s and propagating context in-process.
class Tracer implements tracer_api.Tracer {
  final String _name;
  final IdGenerator _idGenerator = IdGenerator();
  final List<SpanProcessor> _processors;

  Tracer(this._name, this._processors);

  @override
  String get name => _name;

  @override
  Span startSpan(String name, {Context context}) {
    context ??= Context.current;

    List<int> parentSpanId;
    List<int> traceId;
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

    return Span(name, spanContext, parentSpanId, _processors, this);
  }
}
