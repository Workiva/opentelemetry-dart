import 'package:opentelemetry/api.dart';

/// The [AttributesProcessor] is responsible for customizing which
/// attribute(s) are to be reported as metrics dimension(s) and adding
/// additional dimension(s) from the [Context].
abstract class AttributesProcessor {
  /// Process the metric instrument attributes.
  List<Attribute> process(List<Attribute> incoming, {Context context});
  static AttributesProcessor Noop() {
    return NOOP;
  }
}

class NoopAttributesProcessor extends AttributesProcessor {
  @override
  List<Attribute> process(List<Attribute> incoming, {Context context}) {
    return incoming;
  }
}

class FilteringAttributesProcessor extends AttributesProcessor {
  final List<String> _allowedAttributeNames;
  FilteringAttributesProcessor(this._allowedAttributeNames) : super();

  @override
  List<Attribute> process(List<Attribute> incoming, {Context context}) {
    final filteredAttributes = [];

    for (final attribute in incoming) {
      if (_allowedAttributeNames.contains(attribute.key)) {
        filteredAttributes.add(attribute);
      }
    }

    return filteredAttributes;
  }
}

final NOOP = NoopAttributesProcessor();
