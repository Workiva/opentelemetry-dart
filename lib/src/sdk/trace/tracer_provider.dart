import '../../../sdk.dart';
import '../../api/span_processors/span_processor.dart';
import '../../api/trace/sampler.dart';
import '../../api/trace/tracer_provider.dart' as api;
import '../instrumentation_library.dart';
import '../resource/resource.dart';
import 'id_generator.dart';
import 'samplers/parent_based_sampler.dart';
import 'tracer.dart';

/// A registry for creating named [Tracer]s.
class TracerProvider implements api.TracerProvider {
  final Map<String, Tracer> _tracers = {};
  List<SpanProcessor> _processors;
  Resource _resource;
  Sampler _sampler;
  IdGenerator _idGenerator;

  TracerProvider(
      {List<SpanProcessor> processors,
      Resource resource,
      Sampler sampler,
      IdGenerator idGenerator}) {
    _processors = processors ?? []; // Default to a no-op TracerProvider.
    _resource = resource ?? Resource(Attributes.empty());
    _sampler = sampler ?? ParentBasedSampler(AlwaysOnSampler());
    _idGenerator = idGenerator ?? IdGenerator();
  }

  List<SpanProcessor> get spanProcessors => _processors;

  @override
  Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(
        key,
        () => Tracer(_processors, _resource, _sampler, _idGenerator,
            InstrumentationLibrary(name, version)));
  }

  @override
  void forceFlush() {
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].forceFlush();
    }
  }

  @override
  void shutdown() {
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].shutdown();
    }
  }
}
