import '../../api/trace/span.dart';
import '../context/context.dart';

/// [ContextKey] used to store spans in a [Context].
final ContextKey spanKey = Context.createKey('OpenTelemetry Context Key SPAN');

/// Get the [Span] attached to the [context].
dynamic getSpan(Context context) => context.getValue(spanKey);

/// Get the SpanContext of the [context].
dynamic getSpanContext(Context context) {
  final span = context.getValue(spanKey);
  return span?.spanContext;
}

/// Set the [span] onto the [context].
Context setSpan(Context context, Span span) => context.setValue(spanKey, span);

/// Execute a function [fn] within a [context].
///
/// [context] is set as the active context, and then reset after [fn] completes.
dynamic withContext(Context context, Function fn) {
  final scope = Context.attach(context);
  final result = fn();
  context.detach(scope);
  return result;
}
