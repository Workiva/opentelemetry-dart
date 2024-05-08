import 'dart:ffi';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';

class LogLimits {
  static const int defaultMaxAttributeCount = 128;
  static const int defaultMaxAttributeLength = 4294967296;

  final int maxAttributeCount;
  final int maxAttributeLength;


  LogLimits(
      {this.maxAttributeCount = defaultMaxAttributeCount,
        this.maxAttributeLength = defaultMaxAttributeLength});


}
