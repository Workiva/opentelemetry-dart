import '../text_map_propagator.dart';

/// Class that allows a [TextMapPropagator] to set propagated fields into a carrier.
abstract class TextMapSetter<C> {
  /// Sets [value] for [key] on [carrier].
  void set(C carrier, String key, String value);
}
