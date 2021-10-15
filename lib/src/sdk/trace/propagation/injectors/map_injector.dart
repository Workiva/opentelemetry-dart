import '../../../../api/propagation/injectors/text_map_setter.dart';

class MapInjector implements TextMapSetter<Map> {
  @override
  void set(Map carrier, String key, String value) {
    if (carrier != null) {
      carrier[key] = value;
    }
  }
}
