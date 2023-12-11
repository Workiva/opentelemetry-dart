// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:quiver/core.dart';

import '../../../api.dart' as api;
import '../../experimental_api.dart' as api;
import '../../experimental_sdk.dart' as sdk;
import '../common/instrumentation_scope.dart';

class MeterProvider implements api.MeterProvider {
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');

  @protected
  final Map<int, sdk.Meter> meters = {};

  @visibleForTesting
  final sdk.Resource resource;

  MeterProvider({sdk.Resource? resource})
      : resource = resource ?? sdk.Resource([]);

  @override
  api.Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    if (name.isEmpty) {
      _logger.warning('Invalid Meter Name', '', StackTrace.current);
    }

    return meters.putIfAbsent(
        hash3(name, version, schemaUrl),
        () => sdk.Meter(resource,
            InstrumentationScope(name, version, schemaUrl, attributes)));
  }
}
