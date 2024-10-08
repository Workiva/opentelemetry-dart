// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

class SpanLink {
  final api.SpanContext context;
  final List<api.Attribute> attributes;
  final int droppedAttributes;

  SpanLink(this.context,
      {this.attributes = const [], this.droppedAttributes = 0});
}
