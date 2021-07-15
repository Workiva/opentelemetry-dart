import 'package:opentelemetry_context/opentelemetry_context.dart';

final suppressInstrumentationKey = Context.createKey('OpenTelemetry suppress instrumentation');

Context suppressInstrumentation(Context context) =>
  context.setValue(suppressInstrumentationKey, true);

Context unsuppressInstrumentation(Context context) =>
  context.setValue(suppressInstrumentationKey, false);

bool isInstrumentationSuppressed(Context context) =>
  context.getValue(suppressInstrumentationKey) ?? false;
