import '../context/context.dart';
import 'extractors/text_map_getter.dart';
import 'injectors/text_map_setter.dart';

/// A class responsible for performing the injection and extraction of a
/// cross-cutting concern value as string key/values pairs into carriers that
/// travel across process boundaries.
///
/// See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/context/api-propagators.md#textmap-propagator
/// for full specification.
abstract class TextMapPropagator<C> {
  void inject(Context context, C carrier, TextMapSetter<C> setter);

  Context extract(Context context, C carrier, TextMapGetter<C> getter);
}
