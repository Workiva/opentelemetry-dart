import 'package:opentelemetry/src/api/common/attribute.dart';

/// A representation of a collection of metadata attached to a trace span.
abstract class Attributes {
  /// Instantiate an empty Attributes.
  Attributes.empty();

  /// The size of this collection of Attributes.
  int get length;

  /// Whether this collection of Attributes is empty.
  bool get isEmpty;

  /// Retrieve the value associated with the Attribute with key [key].
  Object get(String key);

  /// Retrieve the keys of all Attributes in this collection.
  Iterable<String> get keys;

  /// Add an Attribute [attribute].
  /// If an Attribute with the same key already exists, it will be overwritten.
  void add(Attribute attribute);

  /// Add all Attributes in List [attributes].
  /// If an Attribute with the same key already exists, it will be overwritten.
  void addAll(List<Attribute> attributes);
}
