import '../../../src/api/trace/tracer_provider.dart' as api;
import 'tracer.dart';

/// A registry for creating named [Tracer]s.
class TracerProvider implements api.TracerProvider {
  final Map<String, Tracer> _tracers = {};

  @override
  Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(key, () => Tracer());
  }
}
