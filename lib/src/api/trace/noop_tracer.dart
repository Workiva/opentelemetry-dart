import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A [api.Tracer] class which yields [api.NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements api.Tracer {
  @override
  api.Span startSpan(String name,
      {api.Context context, api.Attributes attributes}) {
    final parentContext = context.spanContext;

    return api.NonRecordingSpan(
        (parentContext.isValid) ? parentContext : sdk.SpanContext.invalid());
  }

  @override
  Future<R> traceAsync<R>(String name, Future<R> Function() fn,
      {api.Context context}) async {
    return await (context ?? api.Context.current).execute(fn);
  }

  @override
  R traceSync<R>(String name, R Function() fn, {api.Context context}) {
    return (context ?? api.Context.current).execute(fn);
  }
}
