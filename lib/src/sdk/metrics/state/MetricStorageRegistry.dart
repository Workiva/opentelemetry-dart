
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
 import 'metrics_storage.dart' show MetricStorage ; import "../InstrumentDescriptor.dart" show InstrumentDescriptor , isDescriptorCompatibleWith ; import "package:@opentelemetry/api.dart" as api ; import "../view/RegistrationConflicts.dart" show getConflictResolutionRecipe , getIncompatibilityDetails ; import "MetricCollector.dart" show MetricCollectorHandle ;
 /**
 * Internal class for storing [MetricStorage]
 */
 class MetricStorageRegistry { StorageMap _sharedRegistry = new Map ( ) ; var _perCollectorRegistry = new Map< MetricCollectorHandle , StorageMap > ( ) ; static create ( ) { return new MetricStorageRegistry ( ) ; } List < MetricStorage > getStorages ( MetricCollectorHandle collector ) { List < MetricStorage > storages = [ ] ; for ( final metricStorages in this . _sharedRegistry . values ( ) ) { storages = storages . concat ( metricStorages ) ; } final perCollectorStorages = this . _perCollectorRegistry . get ( collector ) ; if ( perCollectorStorages != null ) { for ( final metricStorages in perCollectorStorages . values ( ) ) { storages = storages . concat ( metricStorages ) ; } } return storages ; } register ( MetricStorage storage ) { this . _registerStorage ( storage , this . _sharedRegistry ) ; } registerForCollector ( MetricCollectorHandle collector , MetricStorage storage ) { var storageMap = this . _perCollectorRegistry . get ( collector ) ; if ( storageMap == null ) { storageMap = new Map ( ) ; this . _perCollectorRegistry . set ( collector , storageMap ) ; } this . _registerStorage ( storage , storageMap ) ; } dynamic /* T | null */ findOrUpdateCompatibleStorage /*< T >*/ ( InstrumentDescriptor expectedDescriptor ) { final storages = this . _sharedRegistry . get ( expectedDescriptor . name ) ; if ( identical ( storages , undefined ) ) { return null ; }
 // If the descriptor is compatible, the type of their metric storage

 // (either SyncMetricStorage or AsyncMetricStorage) must be compatible.
 return this . _findOrUpdateCompatibleStorage /*< T >*/ ( expectedDescriptor , storages ) ; } dynamic /* T | null */ findOrUpdateCompatibleCollectorStorage /*< T >*/ ( MetricCollectorHandle collector , InstrumentDescriptor expectedDescriptor ) { final storageMap = this . _perCollectorRegistry . get ( collector ) ; if ( identical ( storageMap , undefined ) ) { return null ; } final storages = this . _sharedRegistry . get ( expectedDescriptor . name ) ; if ( identical ( storages , undefined ) ) { return null ; }
 // If the descriptor is compatible, the type of their metric storage

 // (either SyncMetricStorage or AsyncMetricStorage) must be compatible.
 return this . _findOrUpdateCompatibleStorage /*< T >*/ ( expectedDescriptor , storages ) ; } _registerStorage ( MetricStorage storage , StorageMap storageMap ) { final descriptor = storage . getInstrumentDescriptor ( ) ; final storages = storageMap . get ( descriptor . name ) ; if ( identical ( storages , undefined ) ) { storageMap . set ( descriptor . name , [ storage ] ) ; return ; } storages . push ( storage ) ; } dynamic /* T | null */ _findOrUpdateCompatibleStorage /*< T >*/ ( InstrumentDescriptor expectedDescriptor , List < MetricStorage > existingStorages ) { var compatibleStorage = null ; for ( final existingStorage in existingStorages ) { final existingDescriptor = existingStorage . getInstrumentDescriptor ( ) ; if ( isDescriptorCompatibleWith ( existingDescriptor , expectedDescriptor ) ) {
 // Use the longer description if it does not match.
 if ( ! identical ( existingDescriptor . description , expectedDescriptor . description ) ) { if ( expectedDescriptor . description . length > existingDescriptor . description . length ) { existingStorage . updateDescription ( expectedDescriptor . description ) ; } api . diag . warn ( "A view or instrument with the name " , expectedDescriptor . name , " has already been registered, but has a different description and is incompatible with another registered view.\n" , "Details:\n" , getIncompatibilityDetails ( existingDescriptor , expectedDescriptor ) , "The longer description will be used.\nTo resolve the conflict:" , getConflictResolutionRecipe ( existingDescriptor , expectedDescriptor ) ) ; }
 // Storage is fully compatible. There will never be more than one pre-existing fully compatible storage.
 compatibleStorage = ; } else {
 // The implementation SHOULD warn about duplicate instrument registration

 // conflicts after applying View configuration.
 api . diag . warn ( "A view or instrument with the name " , expectedDescriptor . name , " has already been registered and is incompatible with another registered view.\n" , "Details:\n" , getIncompatibilityDetails ( existingDescriptor , expectedDescriptor ) , "To resolve the conflict:\n" , getConflictResolutionRecipe ( existingDescriptor , expectedDescriptor ) ) ; } } return compatibleStorage ; } }