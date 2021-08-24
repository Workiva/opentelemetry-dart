import '../../api/trace/tracer_provider.dart' as api;
import 'exporters/console_exporter.dart';
import 'span_processors/simple_processor.dart';
import 'span_processors/span_processor.dart';
import 'tracer.dart';

/// A registry for creating named [Tracer]s.
class TracerProvider implements api.TracerProvider {
  final Map<String, Tracer> _tracers = {};
  List<SpanProcessor> _processors;

  TracerProvider({List<SpanProcessor> processors}) {
    if (processors == null) {
      _processors = [SimpleSpanProcessor(ConsoleExporter())];
    } else {
      _processors = processors;
    }
  }

  List<SpanProcessor> get spanProcessors => _processors;

  @override
  Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(key, () => Tracer(name, _processors));
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
