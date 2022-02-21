import '../../../../api.dart' as api;

/// Interface that allows a [api.TextMapPropagator] to read propagated fields from a carrier.
abstract class TextMapGetter<C> {
  /// Returns all the keys in the given carrier.
  Iterable<String> keys(C carrier);

  /// Returns the first value of the given propagation [key] or returns null.
  String get(C carrier, String key);
}
