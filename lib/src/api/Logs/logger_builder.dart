import 'package:opentelemetry/api.dart';

abstract class LoggerBuilder {
  LoggerBuilder setSchemaUrl(String schemaUrl);
  LoggerBuilder setInstrumentationVersion(String instrumentationVersion);
  LoggerBuilder setIncludeTraceContext(bool includeTraceContext);
  LoggerBuilder setAttributes(Map<String, Attribute> attributes);
}