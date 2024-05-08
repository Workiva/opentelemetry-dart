enum ExportResult {
  /// The export operation finished successfully.
  success,
  /// The export operation finished with an error.
  failure,
}

extension ExportResultExtension on ExportResult {
  /// Merges the current result code with other result code
  /// - Parameter newResultCode: the result code to merge with
  ExportResult mergeResultCode(ExportResult newResultCode) {
    // If both results are success then return success.
    if (this == ExportResult.success && newResultCode == ExportResult.success) {
      return ExportResult.success;
    } else {
      return ExportResult.failure;
    }
  }
}
