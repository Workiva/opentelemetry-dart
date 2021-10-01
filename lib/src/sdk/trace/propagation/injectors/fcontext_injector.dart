import 'package:frugal/frugal.dart' show FContext;
import '../../../../api/propagation/injectors/text_map_setter.dart';

class FContextInjector implements TextMapSetter<FContext> {
  @override
  void set(FContext carrier, String key, String value) {
    if (carrier != null) {
      carrier.addRequestHeader(key, value);
    }
  }
}
