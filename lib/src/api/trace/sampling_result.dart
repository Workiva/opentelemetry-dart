import '../../../api.dart' as api;

enum Decision {
  drop,
  recordOnly,
  recordAndSample,
}

/// Represents the result of a Sampler as to whether a Span should
/// be processed for collection.
abstract class SamplingResult {
  final api.Decision decision;
  final api.Attributes spanAttributes;
  final api.TraceState traceState;

  SamplingResult(this.decision, this.spanAttributes, this.traceState);
}
