import '../../../api.dart' as api;
import 'package:fixnum/fixnum.dart';
abstract class LogTracer {
  /// Starts a new [api.Span] without setting it as the current span in this
  /// tracer's context.
  ///
  ///
  api.ReadableLogRecord setLog(
      DateTime? observedTimestamp,
      String name,
      {api.Context? context,
        api.SpanKind kind = api.SpanKind.internal,
        List<api.Attribute> attributes = const [],
        List<api.SpanLink> links = const [],
        Int64? startTime});
}
