// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_provider_shared_state.dart';

const invalidMeterNameMessage = 'Invalid Meter Name';

class MeterProvider implements api.MeterProvider {
  final _logger = Logger('opentelemetry.sdk.metrics.meterprovider');
  final _shutdown = false;
  final MeterProviderSharedState _sharedState;

  sdk.Resource get resource => _sharedState.resource;

  MeterProvider(sdk.Resource resource)
      : _sharedState = MeterProviderSharedState(resource);

  @override
  api.Meter get(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    if (name.isEmpty) {
      _logger.warning(invalidMeterNameMessage, '', StackTrace.current);
    }

    if (_shutdown) {
      _logger.warning('A shutdown MeterProvider cannot provide a Meter', '',
          StackTrace.current);
      return api.NoopMeter();
    }

    return _sharedState
        .getMeterSharedState(
            InstrumentationScope(name, version, schemaUrl, attributes))
        .meter;
  }
}
