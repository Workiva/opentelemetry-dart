import 'package:opentelemetry/api.dart';

abstract class ContextManager{
  Context get root;

  Context get active;
}
