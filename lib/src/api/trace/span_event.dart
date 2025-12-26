// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;

/// A representation of a collection of metadata attached to a trace span.
class SpanEvent {
  final Int64 timestamp;

  /// The name of the event.
  final String name;

  /// The attributes of the event.
  final Iterable<api.Attribute> attributes;

  /// Count of attributes of the event that were dropped due to collection limits
  final int droppedAttributesCount;

  SpanEvent({
    required this.timestamp,
    required this.name,
    required this.attributes,
    this.droppedAttributesCount = 0,
  });
}
