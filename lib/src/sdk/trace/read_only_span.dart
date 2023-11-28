// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import '../../sdk/common/attributes.dart';

/// A representation of the readable portions of a single operation
/// within a trace.
///
/// Warning: methods may be added to this interface in minor releases.
abstract class ReadOnlySpan {
  /// The name of the span.
  String get name;

  /// The kind of the span.
  api.SpanKind get kind;

  /// The context associated with this span.
  ///
  /// This context is an immutable, serializable identifier for this span that
  /// can be used to create new child spans and remains usable even after this
  /// span ends.
  api.SpanContext get spanContext;

  /// The parent span id.
  api.SpanId get parentSpanId;

  /// The time when the span was started.
  Int64 get startTime;

  /// The time when the span was closed, or null if still open.
  Int64? get endTime;

  /// The status of the span.
  api.SpanStatus get status;

  List<api.SpanEvent> get events;

  int get droppedEventsCount;

  /// The instrumentation library for the span.
  sdk.InstrumentationScope get instrumentationScope;

  List<api.SpanLink> get links;

  Attributes get attributes;

  sdk.Resource get resource;
}
