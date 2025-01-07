// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class NoopLogRecordProcessor implements sdk.LogRecordProcessor {
  const NoopLogRecordProcessor();

  @override
  Future<void> forceFlush() async {}

  @override
  void onEmit(sdk.LogRecord logRecord) {}

  @override
  Future<void> shutdown() async {}
}
