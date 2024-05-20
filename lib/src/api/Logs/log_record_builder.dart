

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/Logs/severity.dart';
abstract class LogRecordBuilder {
  LogRecordBuilder setTimestamp(DateTime timestamp);
  LogRecordBuilder setObservedTimestamp(DateTime observed);
  LogRecordBuilder setSpanContext(SpanContext context);
  LogRecordBuilder setSeverity(Severity severity);
  LogRecordBuilder setBody(dynamic body);
  LogRecordBuilder setAttributes(Map<String, dynamic> attributes);
  void emit();
}
