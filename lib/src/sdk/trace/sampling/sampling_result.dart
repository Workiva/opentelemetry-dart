import '../../../../api.dart' as api;

enum Decision {
  drop,
  recordOnly,
  recordAndSample,
}

class SamplingResult {
  final Decision decision;
  final List<api.Attribute> spanAttributes;
  final api.TraceState traceState;

  SamplingResult(this.decision, this.spanAttributes, this.traceState);
}
