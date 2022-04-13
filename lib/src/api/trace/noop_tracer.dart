import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A [api.Tracer] class which yields [api.NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements api.Tracer {
  @override
  api.Span startSpan(String name,
      {api.Context context, List<api.Attribute> attributes}) {
    final parentContext = context.spanContext;

    return api.NonRecordingSpan(
        (parentContext.isValid) ? parentContext : sdk.SpanContext.invalid());
  }
}
