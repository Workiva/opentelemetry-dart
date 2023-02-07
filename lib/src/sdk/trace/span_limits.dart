// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

class SpanLimits {
  final _DEFAULT_MAXNUM_ATTRIBUTES = 128;
  final _DEFAULT_MAXNUM_EVENTS = 128;
  final _DEFAULT_MAXNUM_LINKS = 128;
  final _DEFAULT_MAXNUM_ATTRIBUTE_PER_EVENT = 128;
  final _DEFAULT_MAXNUM_ATTRIBUTES_PER_LINK = 128;
  final _DEFAULT_MAXNUM_ATTRIBUTES_LENGTH = -1;

  late int _maxNumAttributes;
  late int _maxNumEvents;
  late int _maxNumLink;
  late int _maxNumAttributesPerEvent;
  late int _maxNumAttributesPerLink;
  late int _maxNumAttributeLength;

  ///setters
  ///Set the max number of attributes per span
  set maxNumAttributes(int maxNumberOfAttributes) {
    if (maxNumberOfAttributes < 0) {
      throw ArgumentError('maxNumEvents must be greater or equal to zero');
    }
  }

  ///set the max number of events per span
  set maxNumEvents(int maxNumEvents) {
    if (maxNumEvents < 0) {
      throw ArgumentError('maxNumEvents must be greater or equal to zero');
    }
  }

  ///set the max number of links per span
  set maxNumLink(int maxNumLink) {
    if (maxNumLink < 0) {
      throw ArgumentError('maxNumEvents must be greater than or equal to zero');
    }
  }

  ///set the max number of attributes per event
  set maxNumAttributesPerEvent(int maxNumAttributesPerEvent) {
    if (maxNumAttributesPerEvent < 0) {
      throw ArgumentError('maxNumEvents must be greater than or equal to zero');
    }
  }

  ///set the max number of attributes per link
  set maxNumAttributesPerLink(int maxNumAttributesPerLink) {
    if (maxNumAttributesPerLink < 0) {
      throw ArgumentError('maxNumEvents must be greater than or equal to zero');
    }
  }

  ///return the maximum allowed attribute value length.
  ///This limits only applies to string and string list attribute valuse.
  ///Any string longer than this value will be truncated to this length.
  ///
  ///default is unlimited.
  set maxNumAttributeLength(int maxNumAttributeLength) {
    if (maxNumAttributeLength < 0) {
      throw ArgumentError('maxNumEvents must be greater than or equal to zero');
    }
  }

  ///getters
  ///return the max number of attributes per span
  int get maxNumAttributes => _maxNumAttributes;

  ///return the max number of events per span
  int get maxNumEvents => _maxNumEvents;

  ///return the max number of links per span
  int get maxNumLink => _maxNumLink;

  ///return the max number of attributes per event
  int get maxNumAttributesPerEvent => _maxNumAttributesPerEvent;

  ///return the max number of attributes per link
  int get maxNumAttributesPerLink => _maxNumAttributesPerLink;

  ///return the maximum allowed attribute value length.
  ///This limits only applies to string and string list attribute valuse.
  ///Any string longer than this value will be truncated to this length.
  ///
  ///default is unlimited.
  int get maxNumAttributeLength => _maxNumAttributeLength;

  ///constructor
  ///https://docs.newrelic.com/docs/data-apis/manage-data/view-system-limits/
  ///https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk/trace/src/main/java/io/opentelemetry/sdk/trace/SpanLimitsBuilder.java
  SpanLimits(
      {int? maxNumAttributes,
      int? maxNumEvents,
      int? maxNumLink,
      int? maxNumAttributesPerEvent,
      int? maxNumAttributesPerLink,
      int? maxNumAttributeLength}) {
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
