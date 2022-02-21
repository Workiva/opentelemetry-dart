import '../../../../api.dart' as api;

/// Class that allows a [api.TextMapPropagator] to set propagated fields into a carrier.
abstract class TextMapSetter<C> {
  /// Sets [value] for [key] on [carrier].
  void set(C carrier, String key, String value);
}
