import '../../../../api/propagation/extractors/text_map_getter.dart';

class MapExtractor implements TextMapGetter<Map> {
  @override
  String get(Map carrier, String key) {
    return (carrier == null) ? null : carrier[key];
  }

  @override
  Iterable<String> keys(Map carrier) {
    return carrier.keys;
  }
}
