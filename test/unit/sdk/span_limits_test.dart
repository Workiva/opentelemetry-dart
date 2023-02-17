// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  const maxAttributes = 3;
  const maxAttributeLength = 5;
  const maxLinks = 3;
  const maxAttributesPerLink = 3;
  final attrShort = Attribute.fromString('shortkey', '55555');
  final dupShort = Attribute.fromString('shortkey', '66666');
  final attrLong = Attribute.fromString('longkey', '5555555');
  final dupLong = Attribute.fromString('longkey', '666666666');
  final dupShort2 = Attribute.fromString('shortkey', '77777');
  final dupLong2 = Attribute.fromString('longkey', '77777777');
  final attrInt = Attribute.fromInt('intKey', 12);
  final attrBool = Attribute.fromBoolean('boolKey', true);
  final attrDoubleArray = Attribute.fromDoubleList('doubleList', [0.1, 0.2]);
  final attrStringArray =
      Attribute.fromStringList('stringList', ['1111', '1111111']);
  final limits = sdk.SpanLimits(
      maxNumAttributes: maxAttributes,
      maxNumAttributeLength: maxAttributeLength,
      maxNumLink: maxLinks,
      maxNumAttributesPerLink: maxAttributesPerLink);
  final context = sdk.SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
      TraceFlags.none, sdk.TraceState.empty());
  final spanLink1 = SpanLink(context, attributes: [attrShort]);
  final spanLink2 = SpanLink(context, attributes: [attrShort, attrLong]);
  final spanLink3 =
      SpanLink(context, attributes: [attrShort, dupShort, attrInt, attrBool]);
  final spanLink4 = SpanLink(context, attributes: []);
  final spanLinkStrs = SpanLink(context,
      attributes: [attrShort, attrLong, attrStringArray, dupShort]);
  final spanLinkDup = SpanLink(context, attributes: [
    attrShort,
    dupShort,
    attrLong,
    dupLong,
    dupShort2,
    dupLong2
  ]);
  final spanLinkNoAttr = SpanLink(context);

  test('test default spanLimits', () {
    final span = sdk.Span('limitTest', sdk.SpanContext.invalid(),
        SpanId([4, 5, 6]), [], sdk.DateTimeTimeProvider(), null, null,
        attributes: [attrShort, attrDoubleArray, attrStringArray],
        limits: sdk.SpanLimits());
    expect(span.attributes.length, equals(3));
    expect(span.attributes.get('shortkey'),
        equals((attrShort.value as String).substring(0, maxAttributeLength)));
    expect(span.attributes.get('doubleList'), equals([0.1, 0.2]));
    expect(span.attributes.get('stringList'), equals(['1111', '1111111']));
  });

  test('test spanLimits maxNumAttributes', () {
    final span = sdk.Span('foo', sdk.SpanContext.invalid(), SpanId([4, 5, 6]),
        [], sdk.DateTimeTimeProvider(), null, null,
        attributes: [attrShort, attrLong, attrInt, attrBool], limits: limits);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('boolean'), equals(null));
  });

  test('test spanLimits maxNumAttributeLength', () {
    final span = sdk.Span('foo', sdk.SpanContext.invalid(), SpanId([4, 5, 6]),
        [], sdk.DateTimeTimeProvider(), null, null,
        attributes: [attrShort, attrLong], limits: limits);
    expect(span.attributes.get('shortkey'),
        equals((attrShort.value as String).substring(0, maxAttributeLength)));
    expect(span.attributes.get('longkey'),
        equals((attrLong.value as String).substring(0, maxAttributeLength)));
  });

  test('test spanLimits from span constructor', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits)
      ..setAttributes([attrShort, attrInt, attrDoubleArray]);
    expect(span.attributes.length, equals(3));
    expect(span.attributes.get('shortkey'),
        equals((attrShort.value as String).substring(0, maxAttributeLength)));
    expect(span.attributes.get('intKey'), equals(12));
    expect(span.attributes.get('doubleList'), equals([0.1, 0.2]));
  });

  test('test spanLimits maxNumAttributes from span constructor', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null, limits: limits)
      ..setAttributes(
          [attrShort, attrLong, attrInt, attrBool, attrStringArray]);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('boolean'), equals(null));
    expect(span.droppedAttributes, equals(2));
  });

  test('test spanLimits maxNumAttributeLength with setAttributes', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits)
      ..setAttributes([attrShort, attrLong]);
    expect(span.attributes.get('shortkey'),
        equals((attrShort.value as String).substring(0, maxAttributeLength)));
    expect(span.attributes.get('longkey'),
        equals((attrLong.value as String).substring(0, maxAttributeLength)));
  });

  test('test spanLimits from span, then add more', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits)
      ..setAttribute(attrShort);
    expect(span.attributes.get('shortkey'),
        equals((attrShort.value as String).substring(0, maxAttributeLength)));
    span.setAttribute(attrLong);
    expect(span.attributes.get('longkey'),
        equals((attrLong.value as String).substring(0, maxAttributeLength)));
    span.setAttribute(attrBool);
    expect(span.droppedAttributes, equals(0));
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('boolKey'), equals(true));
    span.setAttribute(attrDoubleArray);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('doubleList'), equals(null));
    expect(span.droppedAttributes, equals(1));
  });

  test('test add same key twice', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits)
      ..setAttributes([attrShort, dupShort]);
    expect(span.attributes.length, 1);
    expect(span.attributes.get('shortkey'),
        equals((dupShort.value as String).substring(0, maxAttributeLength)));
    span.setAttributes([attrLong, dupLong]);
    expect(span.attributes.length, 2);
    expect(span.attributes.get('longkey'),
        equals((dupLong.value as String).substring(0, maxAttributeLength)));
    expect(span.droppedAttributes, equals(0));
  });

  test('test add same key multitimes from constructor', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null, limits: limits)
      ..setAttributes(
          [attrShort, dupShort, attrLong, dupLong, dupShort2, dupLong2]);
    expect(span.attributes.length, 2);
    expect(span.attributes.get('shortkey'),
        equals((dupShort2.value as String).substring(0, maxAttributeLength)));
    expect(span.attributes.get('longkey'),
        equals((dupLong2.value as String).substring(0, maxAttributeLength)));
  });

  test('test add oversized string list', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits)
      ..setAttributes([attrShort, dupShort, attrLong, dupLong]);
    expect(span.attributes.length, 2);
    expect(span.attributes.get('shortkey'),
        equals((dupShort.value as String).substring(0, maxAttributeLength)));
    expect(span.attributes.get('longkey'),
        equals((dupLong.value as String).substring(0, maxAttributeLength)));
    expect(span.droppedAttributes, equals(0));
  });

  test('test spanlink unlimited', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        links: [spanLink1, spanLink2]);

    expect(span.links.length, equals(2));
    for (var i = 0; i < span.links.length; i++) {
      final link = span.links[i];
      expect(link.context, equals(context));
    }
  });

  test('test add spanlinks greater than maxLinks', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits, links: [spanLink1, spanLink2, spanLink3, spanLink4]);
    assert(span.links.length <= maxLinks);
  });

  test('test add more attributes than maxNumAttributesPerLink in spanlinks',
      () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits, links: [spanLink3]);
    for (var i = 0; i < span.links.length; i++) {
      final link = span.links[i];
      expect(link.context, equals(context));
      assert(link.attributes.length <= maxAttributesPerLink);
    }
  });

  test('test spanlinks with string and string list attributes', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits, links: [spanLinkStrs]);
    for (var i = 0; i < span.links.length; i++) {
      final link = span.links[i];
      expect(link.context, equals(context));
      for (var j = 0; j < link.attributes.length; j++) {
        final attribute = link.attributes[j];
        if (attribute.value is String) {
          assert((attribute.value as String).length <= maxAttributeLength);
        } else if (attribute.value is List<String>) {
          for (final value in attribute.value as Iterable) {
            assert(value.length <= maxAttributeLength);
          }
        }
      }
    }
  });

  test('test spanlink has duplicated attributes', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        limits: limits, links: [spanLinkDup]);

    expect(span.links.length, equals(1));
    for (var i = 0; i < span.links.length; i++) {
      final link = span.links[i];
      expect(link.context, equals(context));
      assert(link.attributes.length == 2);
      for (var j = 0; j < link.attributes.length; j++) {
        final attribute = link.attributes[j];
        assert(attribute.value == '77777');
      }
    }
  });

  test('test spanlink has no attributes', () {
    final span = sdk.Span('test', sdk.SpanContext.invalid(), null, [],
        sdk.DateTimeTimeProvider(), null, null,
        links: [spanLinkNoAttr]);

    expect(span.links.length, equals(1));
    for (var i = 0; i < span.links.length; i++) {
      final link = span.links[i];
      expect(link.context, equals(context));
      assert(link.attributes.isEmpty);
    }
  });
}
