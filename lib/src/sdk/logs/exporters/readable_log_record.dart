// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;

abstract class ReadableLogRecord {
  Int64? get hrTime;

  Int64? get hrTimeObserved;

  api.SpanContext? get spanContext;

  String? get severityText;

  set severityText(String? severity);

  api.Severity? get severityNumber;

  set severityNumber(api.Severity? severity);

  dynamic get body;

  set body(dynamic severity);

  sdk.Resource? get resource;

  sdk.InstrumentationScope? get instrumentationScope;

  sdk.Attributes? get attributes;

  int get droppedAttributesCount;
}
