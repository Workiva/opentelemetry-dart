import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A registry for creating named [api.Tracer]s.
class TracerProvider implements api.TracerProvider {
  final Map<String, api.Tracer> _tracers = {};
  List<api.SpanProcessor> _processors;
  sdk.Resource _resource;
  sdk.Sampler _sampler;
  api.IdGenerator _idGenerator;
  sdk.SpanLimits _spanLimits;

  TracerProvider(
      {List<api.SpanProcessor> processors,
      sdk.Resource resource,
      sdk.Sampler sampler,
      api.IdGenerator idGenerator,
      sdk.SpanLimits spanLimits}) {
    _processors = processors ?? []; // Default to a no-op TracerProvider.
    _resource = resource ?? sdk.Resource(sdk.Attributes.empty());
    _sampler = sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler());
    _idGenerator = idGenerator ?? sdk.IdGenerator();
    _spanLimits = spanLimits ?? sdk.SpanLimits();
  }

  List<api.SpanProcessor> get spanProcessors => _processors;

  @override
  api.Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(
        key,
        () => sdk.Tracer(_processors, _resource, _sampler, _idGenerator,
            sdk.InstrumentationLibrary(name, version),
            spanLimits: _spanLimits));
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
