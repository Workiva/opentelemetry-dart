/*
 * Copyright The OpenTelemetry Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import "package:@opentelemetry/api.dart" show HrTime;
import "package:@opentelemetry/api-metrics.dart" show MetricAttributes;
import "package:@opentelemetry/core.dart" show InstrumentationScope;
import "package:@opentelemetry/resources.dart" show Resource;
import 'package:opentelemetry/src/sdk/common/attributes.dart';
import 'package:opentelemetry/src/sdk/metrics/instruments/instrument_descriptor.dart';

import '../AggregationTemporality.dart' show AggregationTemporality;
import '../../aggregator/types.dart' show Histogram;

/// Basic metric data fields.
abstract class MetricData {
  InstrumentDescriptor descriptor;
  AggregationTemporality aggregationTemporality;
  DataPointType dataPointType;
}

// /**
//  * Represents a metric data aggregated by either a LastValueAggregation or
//  * SumAggregation.
//  */
// abstract class SumMetricData implements MetricData {
//   DataPointType.SUM dataPointType;
//   List<DataPoint<num>> dataPoints;
//   bool isMonotonic;
// }

// abstract class GaugeMetricData implements MetricData {
//   DataPointType.GAUGE dataPointType;
//   List<DataPoint<num>> dataPoints;
// }

// /**
//  * Represents a metric data aggregated by a HistogramAggregation.
//  */
// abstract class HistogramMetricData implements MetricData {
//   DataPointType.HISTOGRAM dataPointType;
//   List<DataPoint<Histogram>> dataPoints;
// }

// /**
//  * Represents an aggregated metric data.
//  */
// abstract class ScopeMetrics {
//   InstrumentationScope scope;
//   List<MetricData> metrics;
// }

// abstract class ResourceMetrics {
//   Resource resource;
//   List<ScopeMetrics> scopeMetrics;
// }

// /**
//  * Represents the collection result of the metrics. If there are any
//  * non-critical errors in the collection, like throwing in a single observable
//  * callback, these errors are aggregated in the [CollectionResult.errors]
//  * array and other successfully collected metrics are returned.
//  */
// abstract class CollectionResult {
//   /**
//    * Collected metrics.
//    */
//   ResourceMetrics resourceMetrics;
//   /**
//    * Arbitrary JavaScript exception values.
//    */
//   List<unknown> errors;
// }

// /**
//  * The aggregated point data type.
//  */
enum DataPointType {
  /// A histogram data point contains a histogram statistics of collected
  /// values with a list of explicit bucket boundaries and statistics such
  /// as min, max, count, and sum of all collected values.
  HISTOGRAM,

  /// An exponential histogram data point contains a histogram statistics of
  /// collected values where bucket boundaries are automatically calculated
  /// using an exponential function, and statistics such as min, max, count,
  /// and sum of all collected values.
  EXPONENTIAL_HISTOGRAM,

  /// A gauge metric data point has only a single numeric value.
  GAUGE,

  /// A sum metric data point has a single numeric value and a
  /// monotonicity-indicator.
  SUM
}

// /**
//  * Represents an aggregated point data with start time, end time and their
//  * associated attributes and points.
//  */
abstract class DataPoint<T> {
  /// The start epoch timestamp of the DataPoint, usually the time when
  ///the metric was created when the preferred AggregationTemporality is
  /// CUMULATIVE, or last collection time otherwise.
  double startTime;

  /// The end epoch timestamp when data were collected, usually it represents
  /// the moment when `MetricReader.collect` was called.
  double endTime;

  ///The attributes associated with this DataPoint.
  Attributes attributes;

  /// The value for this DataPoint. The type of the value is indicated by the
  /// DataPointType.
  T value;
}
