import '../../api/span_processors/span_processor.dart';
import '../../api/trace/tracer_provider.dart' as api;
import '../instrumentation_library.dart';
import '../resource/resource.dart';
import 'id_generator.dart';
import 'tracer.dart';

/// A registry for creating named [Tracer]s.
class TracerProvider implements api.TracerProvider {
  final Map<String, Tracer> _tracers = {};
  List<SpanProcessor> _processors;
  Resource _resource;
  IdGenerator _idGenerator;

  TracerProvider(
      {List<SpanProcessor> processors,
      Resource resource,
      IdGenerator idGenerator}) {
    _processors = processors ?? []; // Default to a no-op TracerProvider.
    _resource = resource;
    _idGenerator = idGenerator ?? IdGenerator();
    // TODO: O11Y-1027: Per spec, a Sampler defaulted to ParentBased(root=AlwaysOn) added here.
  }

  List<SpanProcessor> get spanProcessors => _processors;

  @override
  Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(
        key,
        () => Tracer(_processors, _resource, _idGenerator,
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
