// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

abstract class SpanProcessor {
  void onStart(sdk.ReadWriteSpan span, api.Context parentContext);

  void onEnd(sdk.ReadOnlySpan span);

  void shutdown();

  void forceFlush();
}
