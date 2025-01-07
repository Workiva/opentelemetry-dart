// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

abstract class LogRecordProcessor {
  void onEmit(sdk.LogRecord logRecord);

  Future<void> forceFlush();

  Future<void> shutdown();
}
