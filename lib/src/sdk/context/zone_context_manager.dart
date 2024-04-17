import '../../../api.dart';
import '../../api/context/context_manager.dart';
import 'zone_context.dart';

class ZoneContextManager implements ContextManager{
  @override
  Context get active => ZoneContext.current;

  @override
  Context get root => ZoneContext.root;
}
