/// Representation of the state of a trace.
abstract class TraceState {
  /// Retrieve a value from the TraceState for a given key.
  String get(String key);

  /// Adds a key value pair to the TraceState.
  ///
  /// Key is an opaque string up to 256 characters printable. It MUST begin
  /// with a lowercase letter, and can only contain lowercase letters a-z,
  /// digits 0-9, underscores _, dashes -, asterisks *, and forward slashes /.
  /// For multi-tenant vendor scenarios, an at sign (@) can be used to prefix
  /// the vendor name. The tenant id (before the '@') is limited to 240
  /// characters and the vendor id is limited to 13 characters. If in the
  /// multi-tenant vendor format, then the first character may additionally
  /// be numeric.
  ///
  /// Value is opaque string up to 256 characters printable ASCII RFC0020
  /// characters (i.e., the range 0x20 to 0x7E) except comma , and =.
  void put(String key, String value);

  /// Removes a key value pairs from the TraceState.
  ///
  /// Key is an opaque string up to 256 characters printable. It MUST begin
  /// with a lowercase letter, and can only contain lowercase letters a-z,
  /// digits 0-9, underscores _, dashes -, asterisks *, and forward slashes /.
  /// For multi-tenant vendor scenarios, an at sign (@) can be used to prefix
  /// the vendor name. The tenant id (before the '@') is limited to 240
  /// characters and the vendor id is limited to 13 characters. If in the
  /// multi-tenant vendor format, then the first character may additionally
  /// be numeric.
  void remove(String key);

  /// The number of key/value pairs contained in this TraceState.
  int get size;

  /// Whether this TraceState is empty.
  bool get isEmpty;
}
