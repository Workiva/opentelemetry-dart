import 'package:frugal/frugal.dart';
import '../../../../api/propagation/extractors/text_map_getter.dart';

class FContextExtractor implements TextMapGetter<FContext> {
  @override
  String get(FContext carrier, String key) {
    return (carrier == null) ? null : carrier.requestHeader(key);
  }

  @override
  Iterable<String> keys(FContext carrier) {
    final map = carrier.requestHeaders();
    return map.keys;
  }
}
