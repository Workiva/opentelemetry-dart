// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

// https://opentelemetry.io/docs/specs/otel/logs/sdk/#loggerconfig
class LoggerConfig {
  /// If not explicitly set,
  /// the disabled parameter SHOULD default to false ( i.e. Loggers are enabled by default).
  /// If a Logger is disabled, it MUST behave equivalently to No-op Logger.
  final bool disabled;

  const LoggerConfig({
    this.disabled = false,
  });
}
