
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
 import "package:@opentelemetry/core.dart" show InstrumentationScope ; import "package:@opentelemetry/resources.dart" show Resource ; import "package:...dart" show Aggregation , InstrumentType ; import "../utils.dart" show instrumentationScopeId ; import "../view/ViewRegistry.dart" show ViewRegistry ; import "MeterSharedState.dart" show MeterSharedState ; import "MetricCollector.dart" show MetricCollector , MetricCollectorHandle ;
 /**
 * An internal record for shared meter provider states.
 */
 class MeterProviderSharedState { Resource resource ; var viewRegistry = new ViewRegistry ( ) ; List < MetricCollector > metricCollectors = [ ] ; Map< String , MeterSharedState > meterSharedStates = new Map ( ) ; MeterProviderSharedState ( this . resource ) { } getMeterSharedState ( InstrumentationScope instrumentationScope ) { final id = instrumentationScopeId ( instrumentationScope ) ; var meterSharedState = this . meterSharedStates . get ( id ) ; if ( meterSharedState == null ) { meterSharedState = new MeterSharedState ( this , instrumentationScope ) ; this . meterSharedStates . set ( id , meterSharedState ) ; } return meterSharedState ; } selectAggregations ( InstrumentType instrumentType ) { final List < > result = [ ] ; for ( final collector in this . metricCollectors ) { result . push ( [ collector , collector . selectAggregation ( instrumentType ) ] ) ; } return result ; } }