import 'dart:ffi';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import '../../sdk/common/attributes.dart';

import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';


abstract class ReadableLogRecord {
  sdk.Resource get resource;
  late final DateTime observedTimestamp;
  late final DateTime recordTime;
  late final api.Severity? severity;
  api.Attribute get body;
  Attributes get attributes;
  sdk.InstrumentationScope get instrumentationScope;
  api.SpanContext get spanContext;


  void setAttribute(api.Attribute attribute);
  void setBody(api.Attribute attribute);
  void setSevarity(api.Severity severity);
  void emit();

}