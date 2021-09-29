import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/instrumentation_library.dart';
import 'package:opentelemetry/src/api/trace/sampling_result.dart';
import 'package:opentelemetry/src/api/trace/span.dart';

/// Represents an entity which determines whether a [Span] should be sampled
/// and sent for collection.
abstract class Sampler {
  SamplingResult shouldSample(
      Context context, Span span, InstrumentationLibrary library);

  String get decision;
}
