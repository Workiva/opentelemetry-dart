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
