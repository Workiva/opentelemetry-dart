
import 'dart:ffi';

enum Severity {
  trace,
  trace2,
  trace3,
  trace4,
  debug,
  debug2,
  debug3,
  debug4,
  info,
  info2,
  info3,
  info4,
  warn,
  warn2,
  warn3,
  warn4,
  error,
  error2,
  error3,
  error4,
  fatal,
  fatal2,
  fatal3,
  fatal4
}

extension SeverityDescription on Severity {
  String get description {
    switch (this) {
      case Severity.trace:
        return "TRACE";
      case Severity.trace2:
        return "TRACE2";
      case Severity.trace3:
        return "TRACE3";
      case Severity.trace4:
        return "TRACE4";
      case Severity.debug:
        return "DEBUG";
      case Severity.debug2:
        return "DEBUG2";
      case Severity.debug3:
        return "DEBUG3";
      case Severity.debug4:
        return "DEBUG4";
      case Severity.info:
        return "INFO";
      case Severity.info2:
        return "INFO2";
      case Severity.info3:
        return "INFO3";
      case Severity.info4:
        return "INFO4";
      case Severity.warn:
        return "WARN";
      case Severity.warn2:
        return "WARN2";
      case Severity.warn3:
        return "WARN3";
      case Severity.warn4:
        return "WARN4";
      case Severity.error:
        return "ERROR";
      case Severity.error2:
        return "ERROR2";
      case Severity.error3:
        return "ERROR3";
      case Severity.error4:
        return "ERROR4";
      case Severity.fatal:
        return "FATAL";
      case Severity.fatal2:
        return "FATAL2";
      case Severity.fatal3:
        return "FATAL3";
      case Severity.fatal4:
        return "FATAL4";
      default:
        return "";
    }
  }
}
