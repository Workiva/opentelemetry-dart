import 'dart:async';

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
  FutureOr<R> trace<R>(String name, FutureOr<R> Function() fn,
      {api.Context context}) async {
    return await (context ?? api.Context.current).execute(fn);
  }
}
