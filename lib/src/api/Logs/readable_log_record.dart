import 'dart:ffi';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import '../../sdk/common/attributes.dart';

import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';


abstract class ReadableLogRecord {
  sdk.Resource get resource;
  late final DateTime observedTimestamp;
  late final DateTime recordTime;
  late final api.Severity severity;
  late final api.Attribute body;
  Attributes get attributes;
  sdk.InstrumentationScope get instrumentationScope;
  api.SpanContext get spanContext;


}