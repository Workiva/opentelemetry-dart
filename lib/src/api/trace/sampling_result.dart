import '../common/attributes.dart';
import 'trace_state.dart';

enum Decision {
  drop,
  recordOnly,
  recordAndSample,
}

/// Represents the result of a Sampler as to whether a Span should
/// be processed for collection.
abstract class SamplingResult {
  final Decision decision;
  final Attributes spanAttributes;
  final TraceState traceState;

  SamplingResult(this.decision, this.spanAttributes, this.traceState);
}
