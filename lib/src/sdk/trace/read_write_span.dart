// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry_wk/api.dart' as api;
import 'package:opentelemetry_wk/sdk.dart' as sdk;

abstract class ReadWriteSpan implements sdk.ReadOnlySpan, api.Span {}
