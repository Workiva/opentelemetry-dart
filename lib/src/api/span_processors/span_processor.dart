// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

@Deprecated(
    'This class will be moved to the SDK package in 0.19.0. Use [SpanExporter] from SDK instead.')
abstract class SpanProcessor {
  void onStart(api.Span span, api.Context parentContext);

  void onEnd(api.Span span);

  void shutdown();

  void forceFlush();
}
