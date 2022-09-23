import 'package:opentelemetry/sdk.dart';
import 'package:opentelemetry/src/sdk/metrics/view/view_registry.dart';

class MeterProviderSharedState { 
  Resource resource ; 
  ViewRegistry viewRegistry = ViewRegistry() ; 
  List<MetricCollector > metricCollectors = [ ] ; 
  Map<String, MeterSharedState> meterSharedStates = new Map ( ) ; 
  
  MeterProviderSharedState ( this.resource ); 
  
  getMeterSharedState ( InstrumentationScope instrumentationScope ) 
  { 
    final id = instrumentationScopeId( instrumentationScope ) ; 
    var meterSharedState = this.meterSharedStates . get ( id ) ; 
    if ( meterSharedState == null ) 
    { 
      meterSharedState = new MeterSharedState ( this , instrumentationScope ) ; 
      this . meterSharedStates . set ( id , meterSharedState ) ; 
    } return meterSharedState ; 
  } 
  
  selectAggregations ( InstrumentType instrumentType ) { final List < > result = [ ] ; for ( final collector in this . metricCollectors ) { result . push ( [ collector , collector . selectAggregation ( instrumentType ) ] ) ; } return result ; } }