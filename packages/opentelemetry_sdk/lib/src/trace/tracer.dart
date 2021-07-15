import 'package:logging/logging.dart';
import 'package:opentelemetry_api/opentelemetry_api.dart' as api;
import 'package:opentelemetry_context/opentelemetry_context.dart';
import 'package:opentelemetry_sdk/core.dart';

class Tracer implements api.Tracer {
  final InstrumentationLibrary instrumentationLibrary;
  final _log = Logger('opentelemetry_sdk.Tracer');

  Tracer(this.instrumentationLibrary);

  @override
  api.Span startSpan(String name, {Context context, api.SpanKind kind, DateTime startTime}) {
    context ??= Context.current;

    if (api.isInstrumentationSuppressed(context)) {
      _log.fine('Instrumentation suppressed, returning Noop Span');
      return api.noopSpan;
    }
  }
}
