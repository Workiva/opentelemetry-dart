// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

/// Class representing an ID for a single Trace.
/// See https://www.w3.org/TR/trace-context/#trace-id for full specification.
class TraceId {
  static const sizeBits = 32;
  static const sizeBytes = 16;

  List<int>? _id;

  TraceId(this._id);
  TraceId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateTraceId();
  }
  TraceId.fromString(String id) {
    _id = [];
    id = id.padLeft(TraceId.sizeBits, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id!.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  TraceId.invalid() : this(List<int>.filled(sizeBytes, 0));

  /// Retrieve this TraceId as a list of byte values.
  List<int>? get() => _id;

  /// Whether this ID represents a valid Trace.
  bool get isValid => !_id!.every((i) => i == 0);

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString() =>
      _id!.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
