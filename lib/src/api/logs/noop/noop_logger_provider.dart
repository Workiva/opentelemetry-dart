// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/api/common/attribute.dart';
import 'package:opentelemetry/src/api/logs/logger.dart';
import 'package:opentelemetry/src/api/logs/logger_provider.dart';
import 'package:opentelemetry/src/api/logs/noop/noop_logger.dart';

class NoopLoggerProvider implements LoggerProvider {
  @override
  Logger get(
    String name, {
    String version = '',
    String schemaUrl = '',
    List<Attribute> attributes = const [],
    bool? includeTraceContext,
  }) =>
      const NoopLogger();
}
