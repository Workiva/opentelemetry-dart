import '../internal/utils.dart';

class SpanLimits {
  final _DEFAULT_MAXNUM_ATTRIBUTES = 200;
  final _DEFAULT_MAXNUM_EVENTS = 128;
  final _DEFAULT_MAXNUM_LINKS = 128;
  final _DEFAULT_MAXNUM_ATTRIBUTE_PER_EVENT = 128;
  final _DEFAULT_MAXNUM_ATTRIBUTES_PER_LINK = 128;
  final _DEFAULT_MAXNUM_ATTRIBUTES_LENGTH = 1000;

  int _maxNumAttributes;
  int _maxNumEvents;
  int _maxNumLink;
  int _maxNumAttributesPerEvent;
  int _maxNumAttributesPerLink;
  int _maxNumAttributeLength;

  ///setters
  set maxNumAttributes(int maxNumberOfAttributes) {
    Utils.checkArgument(maxNumberOfAttributes >= 0,
        'maxNumberOfAttributes must be greater or equal to zero');
    _maxNumAttributes = maxNumberOfAttributes;
  }

  set maxNumEvents(int maxNumEvents) {
    Utils.checkArgument(
        maxNumEvents >= 0, 'maxNumEvents must be greater or equal to zero');
    _maxNumEvents = maxNumEvents;
  }

  set maxNumLink(int maxNumLink) {
    Utils.checkArgument(
        maxNumLink >= 0, 'maxNumLink must be greater or equal to zero');
    _maxNumLink = maxNumLink;
  }

  set maxNumAttributesPerEvent(int maxNumAttributesPerEvent) {
    Utils.checkArgument(maxNumAttributesPerEvent >= 0,
        'maxNumAttributesPerEvent must be greater or equal to zero');
    _maxNumAttributesPerEvent = maxNumAttributesPerEvent;
  }

  set maxNumAttributesPerLink(int maxNumAttributesPerLink) {
    Utils.checkArgument(maxNumAttributesPerLink >= 0,
        'maxNumAttributesPerLink must be greater or equal to zero');
    _maxNumAttributesPerLink = maxNumAttributesPerLink;
  }

  set maxNumAttributeLength(int maxNumAttributeLength) {
    Utils.checkArgument(maxNumAttributesPerLink >= 0,
        'maxNumAttributesPerLink must be greater or equal to zero');
    _maxNumAttributeLength = maxNumAttributeLength;
  }

  ///getters
  int get maxNumAttributes => _maxNumAttributes;
  int get maxNumEvents => _maxNumEvents;
  int get maxNumLink => _maxNumLink;
  int get maxNumAttributesPerEvent => _maxNumAttributesPerEvent;
  int get maxNumAttributesPerLink => _maxNumAttributesPerLink;
  int get maxNumAttributeLength => _maxNumAttributeLength;

  ///constructor
  ///https://docs.newrelic.com/docs/data-apis/manage-data/view-system-limits/
  ///https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk/trace/src/main/java/io/opentelemetry/sdk/trace/SpanLimitsBuilder.java
  SpanLimits(
      {int maxNumAttributes,
      int maxNumEvents,
      int maxNumLink,
      int maxNumAttributesPerEvent,
      int maxNumAttributesPerLink,
      int maxNumAttributeLength}) {
    _maxNumAttributes = maxNumAttributes ?? _DEFAULT_MAXNUM_ATTRIBUTES;
    _maxNumEvents = maxNumEvents ?? _DEFAULT_MAXNUM_EVENTS;
    _maxNumLink = maxNumLink ?? _DEFAULT_MAXNUM_LINKS;
    _maxNumAttributesPerEvent =
        maxNumAttributesPerEvent ?? _DEFAULT_MAXNUM_ATTRIBUTE_PER_EVENT;
    _maxNumAttributesPerLink =
        maxNumAttributesPerLink ?? _DEFAULT_MAXNUM_ATTRIBUTES_PER_LINK;
    _maxNumAttributeLength =
        maxNumAttributeLength ?? _DEFAULT_MAXNUM_ATTRIBUTES_LENGTH;
  }
}
