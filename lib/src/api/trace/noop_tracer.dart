import '../../../api.dart' as api;
import '../../sdk/trace/span_context.dart';
import 'nonrecording_span.dart';
import 'tracer.dart' as api;

/// A [api.Tracer] class which yields [NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements api.Tracer {
  @override
  String get name => 'NOOP';

  @override
  api.Span startSpan(String name,
      {api.Context context, api.Attributes attributes}) {
    final SpanContext parentContext = api.getSpanContext(context);

    return NonRecordingSpan(
        (parentContext.isValid) ? parentContext : SpanContext.invalid());
  }
}
