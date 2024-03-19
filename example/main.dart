import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart';

/// Applications use a tracer to create a trace with spans. There are several
/// steps needed to get a tracer.

/// Send span details to the console. Use [CollectorExporter] to export traces.
final exporter = ConsoleExporter();

/// Immediately export spans. Use [BatchSpanProcessor] to batch export.
final processor = SimpleSpanProcessor(exporter);

/// A native Dart tracer. Use WebTracerProvider for web applications.
final provider = TracerProviderBase(processors: [processor]);
final tracer = provider.getTracer('instrumentation-name');

/// Demonstrate creating/propagating a trace with a root and child spans.
///
/// The output to the console shows the trace propagation and the span details.
/// Example output:
/// Include headers on your outgoing request (http, grpc, etc):
///   {traceparent: 00-a6493775da5822fb964d2117f64d588f-df484a3f05b1946f-01,
///    tracestate: }
/// Using finally to ensure the child span is exported.
///   {traceId: a6493775da5822fb964d2117f64d588f, parentId: 365589c23f2e5d7c,
///    name: child-span, id: df484a3f05b1946f, timestamp: 1710865958436020000,
///    duration: 7032000, flags: 01, state: , status: StatusCode.unset}
/// The root span is ended and exported to the console.
///   {traceId: a6493775da5822fb964d2117f64d588f, parentId: , name: root-span,
///    id: 365589c23f2e5d7c, timestamp: 1710865958424782000, duration: 19892000,
///    flags: 01, state: , status: StatusCode.unset}
void main() {
  // The current span is available via the global Context.
  final context = Context.current;
  // A trace starts with a root span which has no parent.
  final rootSpan = tracer.startSpan('root-span');
  try {
    // A callback is required to set the rootSpan as the current context.
    context.withSpan(rootSpan).execute(() {
      final childSpan = tracer.startSpan('child-span',
          kind: SpanKind.client,
          attributes: [Attribute.fromString('key', 'useful information...')]);
      try {
        Context.current.withSpan(childSpan).execute(remoteProceedureCall);
        childSpan.addEvent('Some work was done!');
      } catch (e) {
        childSpan
          ..recordException(e)
          ..setStatus(StatusCode.error, 'An error occurred');
      } finally {
        print('Using finally to ensure the child span is exported.');
        childSpan.end();
      }
    });
  } finally {
    print('The root span is ended and exported to the console.');
    rootSpan.end();
  }
  rootSpan.end();
}

/// Simulate calling a remote process. The trace context needs to be propogated.
/// See https://www.w3.org/TR/trace-context/ 'traceparent' and 'tracestate'.
Future<void> remoteProceedureCall() async {
  final headers = <String, String>{};
  W3CTraceContextPropagator()
      .inject(Context.current, headers, _TextMapSetter());
  print('Include headers on your outgoing request (http, grpc, etc): $headers');
  // Use W3CTraceContextPropagator().extract to get the trace context on the
  // receiving side.
}

class _TextMapSetter implements TextMapSetter<Map<String, String>> {
  @override
  void set(Map<String, String> carrier, String key, String value) {
    carrier[key] = value;
  }
}
