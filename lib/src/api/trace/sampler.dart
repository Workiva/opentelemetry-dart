import '../../../api.dart' as api;

/// Represents an entity which determines whether a [api.Span] should be sampled
/// and sent for collection.
abstract class Sampler {
  api.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String spanName,
      bool spanIsRemote, // ignore: avoid_positional_boolean_parameters
      api.Attributes spanAttributes);

  String get description;
}
