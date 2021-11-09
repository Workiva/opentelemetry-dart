import '../../api/instrumentation_library.dart' as version_api;
import '../../api/span_processors/span_processor.dart';
import '../../api/trace/tracer_provider.dart' as api;
import '../instrumentation_library.dart';
import 'exporters/console_exporter.dart';
import 'id_generator.dart';
import 'span_processors/simple_processor.dart';
import 'tracer.dart';

/// A registry for creating named [Tracer]s.
class TracerProvider implements api.TracerProvider {
  final Map<String, Tracer> _tracers = {};
  final version_api.InstrumentationLibrary _libraryVersion =
      InstrumentationLibrary();
  List<SpanProcessor> _processors;
  IdGenerator _idGenerator;

  TracerProvider({List<SpanProcessor> processors, IdGenerator idGenerator}) {
    _processors = processors ?? [SimpleSpanProcessor(ConsoleExporter())];
    _idGenerator = idGenerator ?? IdGenerator();
    // TODO: O11Y-1027: Per spec, a Sampler defaulted to ParentBased(root=AlwaysOn) added here.
  }

  List<SpanProcessor> get spanProcessors => _processors;

  @override
  Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(
        key, () => Tracer(name, _processors, _idGenerator, _libraryVersion));
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
