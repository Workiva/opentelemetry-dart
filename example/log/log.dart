// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/api/open_telemetry.dart';
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart';

void main() async {
  final processor = OTLPLogExporter(Uri.parse(''));
  final provider = LoggerProvider(
    processors: [
      BatchLogRecordProcessor(exporter: processor),
    ],
  );
  registerGlobalLogProvider(provider);

  globalLogProvider.get('test logger').emit(api.LogRecord(body: 'test otel log', severityNumber: api.Severity.error));

  await Future.delayed(const Duration(seconds: 10));
}
