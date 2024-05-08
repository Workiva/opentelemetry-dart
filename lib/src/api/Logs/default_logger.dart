// import 'package:opentelemetry/api.dart';
//
// class DefaultLogger implements Logger {
//   static final DefaultLogger instanceWithDomain = DefaultLogger(true);
//   static final DefaultLogger instanceNoDomain = DefaultLogger(false);
//   static final NoopLogRecordBuilder noopLogRecordBuilder = NoopLogRecordBuilder();
//
//   final bool hasDomain;
//
//   DefaultLogger(this.hasDomain);
//
//   static Logger getInstance(bool hasDomain) {
//     return hasDomain ? instanceWithDomain : instanceNoDomain;
//   }
//
//   @override
//   EventBuilder eventBuilder(String name) {
//     if (!hasDomain) {
//       // log error
//     }
//     return noopLogRecordBuilder;
//   }
//
//   @override
//   LogRecordBuilder logRecordBuilder() {
//     return noopLogRecordBuilder;
//   }
//
//   static class NoopLogRecordBuilder implements EventBuilder {
//   @override
//   NoopLogRecordBuilder setTimestamp(DateTime timestamp) => this;
//
//   @override
//   NoopLogRecordBuilder setObservedTimestamp(DateTime observed) => this;
//
//   @override
//   NoopLogRecordBuilder setSpanContext(SpanContext context) => this;
//
//   @override
//   NoopLogRecordBuilder setSeverity(Severity severity) => this;
//
//   @override
//   NoopLogRecordBuilder setBody(dynamic body) => this;
//
//   @override
//   NoopLogRecordBuilder setAttributes(Map<String, dynamic> attributes) => this;
//
//   @override
//   NoopLogRecordBuilder setData(Map<String, dynamic> attributes) => this;
//
//   @override
//   void emit() {}
//   }
// }
