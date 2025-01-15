// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

class ExportResult {
  final ExportResultCode code;
  final Exception? error;
  final StackTrace? stackTrace;

  ExportResult({required this.code, this.error, this.stackTrace});
}

enum ExportResultCode {
  success,
  failed,
}
