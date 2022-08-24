import 'package:opentelemetry/api.dart';

abstract class MeterBuilder {
  Meter build();
  void setInstrumentationVersion(String instrumentationVersion);
  void setSchemaUrl(String schemaUrl);
}
