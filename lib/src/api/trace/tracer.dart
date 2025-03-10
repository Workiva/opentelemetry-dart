// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;

/// An interface for creating [api.Span]s and propagating context in-process.
///
/// Users may choose to use manual or automatic Context propagation. Because of
/// that, this class offers APIs to facilitate both usages.
///
/// Warning: methods may be added to this interface in minor releases.
abstract class Tracer {
  /// Starts a [api.Span].
  ///
  /// The [api.Span] is created with the provided name and as a child of any
  /// existing span context found in the passed context.
  api.Span startSpan(String name,
      {api.Context? context,
      api.SpanKind kind = api.SpanKind.internal,
      List<api.Attribute> attributes = const [],
      List<api.SpanLink> links = const [],
      Int64? startTime,
      bool newRoot = false});
}
