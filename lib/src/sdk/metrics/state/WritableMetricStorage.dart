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
import "package:@opentelemetry/api.dart" show Context, HrTime;
import "package:@opentelemetry/api-metrics.dart" show MetricAttributes;
import "HashMap.dart" show AttributeHashMap;

/**
 * Internal interface. Stores measurements and allows synchronous writes of
 * measurements.
 *
 * An interface representing SyncMetricStorage with type parameters removed.
 */
abstract class WritableMetricStorage {
  /** Records a measurement. */
  void record(num value, MetricAttributes attributes, Context context,
      HrTime recordTime);
}

/**
 * Internal interface. Stores measurements and allows asynchronous writes of
 * measurements.
 *
 * An interface representing AsyncMetricStorage with type parameters removed.
 */
abstract class AsyncWritableMetricStorage {
  /** Records a batch of measurements. */
  void record(AttributeHashMap<num> measurements, HrTime observationTime);
}
