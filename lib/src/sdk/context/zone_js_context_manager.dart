import '../../../api.dart';
import '../../api/context/context_manager.dart';
import 'zone_js_context.dart';

class ZoneJsContextManager implements ContextManager{
  @override
  Context get active => ZoneJsContext.current;

  @override
  Context get root => ZoneJsContext.root;
}
