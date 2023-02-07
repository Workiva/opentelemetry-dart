// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

/// Representation of the state of a trace.
///
/// See W3C documentation: https://www.w3.org/TR/trace-context/#tracestate-header
class TraceState implements api.TraceState {
  static const int _MAX_KEY_VALUE_PAIRS = 32;
  static const int _KEY_MAX_SIZE = 256;
  static const int _VALUE_MAX_SIZE = 256;
  static final RegExp validKeyRegex = RegExp(
      r'^[a-z][\w\-\*\/]{0,255}$|^[a-z0-9][\w\-\*\/]{0,239}\@[\w\-\*\/]{0,13}$');
  static final RegExp validValueRegex = RegExp(
      r'^[\w\"\@\#\$\%\^\&\*\(\)\+\-\.\/\:\;\<\>\?\[\]\\\`\{\|\}]{1,256}$');
  final Map<String, String> _state = {};

  TraceState.empty();

  TraceState.fromString(String traceState) {
    final stateElements = traceState.split(',');

    // Incoming state doesn't contain valid matchings of comma-separated
    // "key=value,key=value" pairs. Note: an invalid value with both a = and
    // a comma will still be converted, incorrectly.
    if (!stateElements.every((element) => element.contains('='))) {
      return;
    }

    for (final element in stateElements) {
      final entry = element.split('=');
      if (entry.length == 2) {
        put(entry.first, entry.last);
      }
    }
  }

  static TraceState getDefault() => TraceState.empty();

  /// Determine if the given key is valid.
  ///
  /// Key is an opaque string up to 256 characters printable. It MUST begin
  /// with a lowercase letter, and can only contain lowercase letters a-z,
  /// digits 0-9, underscores _, dashes -, asterisks *, and forward slashes /.
  /// For multi-tenant vendor scenarios, an at sign (@) can be used to prefix
  /// the vendor name. The tenant id (before the '@') is limited to 240
  /// characters and the vendor id is limited to 13 characters. If in the
  /// multi-tenant vendor format, then the first character may additionally
  /// be numeric.
  static bool _isValidKey(String key) {
    if (key.length > _KEY_MAX_SIZE || key.isEmpty) {
      return false;
    }

    final match = validKeyRegex.matchAsPrefix(key);

    return (match != null) && (match.group(0) == key);
  }

  /// Determine if the given value is valid.
  ///
  /// Value an is opaque string up to 256 characters printable ASCII RFC0020
  /// characters (i.e., the range 0x20 to 0x7E) except comma , and =.
  static bool _isValidValue(String value) {
    if (value.length > _VALUE_MAX_SIZE || value.isEmpty) {
      return false;
    }

    final match = validValueRegex.matchAsPrefix(value);

    return (match != null) && (match.group(0) == value);
  }

  @override
  String? get(String key) => _state[key];

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
  @override
  void put(String key, String value) {
    if (_isValidKey(key) &&
        _isValidValue(value) &&
        size < _MAX_KEY_VALUE_PAIRS) {
      _state[key] = value;
    }
  }

  /// Removes a key value pair from the TraceState.
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
  @override
  void remove(String key) {
    if (_isValidKey(key)) {
      _state.remove(key);
    }
  }

  @override
  String toString() {
    if (isEmpty) {
      return '';
    }

    final state_entries = _state.entries;
    var state = '${state_entries.first.key}=${state_entries.first.value}';

    state_entries.skip(1).forEach((entry) {
      state += ',${entry.key}=${entry.value}';
    });

    return state;
  }

  @override
  bool get isEmpty => _state.isEmpty;

  @override
  int get size => _state.length;
}
