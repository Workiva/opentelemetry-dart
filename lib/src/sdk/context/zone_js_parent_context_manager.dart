import 'package:opentelemetry/src/sdk/context/zone_js_interop.dart';
import 'package:opentelemetry/src/sdk/context/zone_js_parent_context.dart';

import '../../../api.dart';
import '../../api/context/context_manager.dart';
import 'zone_context.dart';
import 'package:js/js.dart';

@JS('get_dart_zone')
external set get_dart_zone(JsSpanContext Function() f);

class ZoneJsParentContextManager implements ContextManager {
  /// Allows assigning a function to be callable from `window.functionName()`

  ZoneJsParentContextManager() {
    get_dart_zone = allowInterop(ZoneJsParentContext.getActiveAsJs);
  }

  @override
  Context get active => ZoneJsParentContext.current;

  @override
  Context get root => ZoneJsParentContext.root;
}
