// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

class SpanLink {
  final api.SpanContext? _context;
  final List<api.Attribute> _attributes;

  SpanLink(this._context, {List<api.Attribute>? attributes})
      : _attributes = attributes ?? [];

  List<api.Attribute> get attributes => _attributes;

  api.SpanContext? get context => _context;
}
