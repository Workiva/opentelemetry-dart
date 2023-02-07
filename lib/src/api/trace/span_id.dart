// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

/// Class representing an ID for a single [api.Span].
/// See https://www.w3.org/TR/trace-context/#parent-id for full specification.
class SpanId {
  static const sizeBits = 16;
  static const sizeBytes = 8;

  List<int>? _id;

  SpanId(this._id);
  SpanId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateSpanId();
  }
  SpanId.fromString(String id) {
    _id = [];
    id = id.padLeft(api.SpanId.sizeBits, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id!.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  SpanId.invalid() : this(List<int>.filled(sizeBytes, 0));
  SpanId.root() : this([]);

  /// Retrieve this SpanId as a list of byte values.
  List<int>? get() => _id;

  /// Whether this ID represents a valid [api.Span].
  bool get isValid => _id!.isEmpty || !_id!.every((i) => i == 0);

  /// Retrieve this SpanId as a human-readable ID.
  @override
  String toString() =>
      _id!.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
