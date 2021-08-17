/// The set of canonical status codes.
enum StatusCode {
  /// The default status.
  UNSET,

  /// The operation contains an error.
  ERROR,

  /// The operation has been validated by an Application developers or
  /// Operator to have completed successfully.
  OK,
}

/// A representation of the status of a Span.
class SpanStatus {
  StatusCode code = StatusCode.UNSET;
  String description;
}
