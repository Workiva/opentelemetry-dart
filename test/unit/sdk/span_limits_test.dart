import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart';
import 'package:test/test.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart' as sdkspan;

void main() {
  const maxAttributes = 3;
  const maxAttributeLength = 5;
  final attrShort = Attribute.fromString('shortkey', '55555');
  final dupShort = Attribute.fromString('shortkey', '66666');
  final attrLong = Attribute.fromString('longkey', '5555555');
  final dupLong = Attribute.fromString('longkey', '666666666');
  final attrInt = Attribute.fromInt('intKey', 12);
  final attrBool = Attribute.fromBoolean('boolKey', true);
  final attrDoubleArray = Attribute.fromDoubleList('doubleList', [0.1, 0.2]);
  final attrStringArray =
      Attribute.fromStringList('stringList', ['1111', '1111111']);
  final limits = SpanLimits(
      maxNumAttributes: maxAttributes,
      maxNumAttributeLength: maxAttributeLength);

  test('test spanlimits normal', () {
    final attrs = [attrShort, attrDoubleArray, attrStringArray];
    final span = sdkspan.Span(
        'limitTest', null, SpanId([4, 5, 6]), [], null, null,
        attribute_list: attrs, spanlimits: limits);
    expect(span.attributes.length, equals(3));
    expect(span.attributes.get('shortkey'), equals('55555'));
    expect(span.attributes.get('doubleList'), equals([0.1, 0.2]));
    expect(span.attributes.get('stringList'), equals(['1111', '11111']));
  });

  test('test spanlimits maxNumAttributes', () {
    final attrs = [attrShort, attrLong, attrInt, attrBool];
    final span = sdkspan.Span('foo', null, SpanId([4, 5, 6]), [], null, null,
        attribute_list: attrs, spanlimits: limits);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('boolean'), equals(null));
  });

  test('test spanlimits maxNumAttributeLength', () {
    final attrs = [attrShort, attrLong];
    final span = sdkspan.Span('foo', null, SpanId([4, 5, 6]), [], null, null,
        attribute_list: attrs, spanlimits: limits);
    expect(span.attributes.get('shortkey'), equals('55555'));
    expect(span.attributes.get('longkey'), equals('55555'));
  });

  test('test spanlimits normal from span', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, attrInt, attrDoubleArray]);
    expect(span.attributes.length, equals(3));
    expect(span.attributes.get('shortkey'), equals('55555'));
    expect(span.attributes.get('intKey'), equals(12));
    expect(span.attributes.get('doubleList'), equals([0.1, 0.2]));
  });

  test('test spanlimits maxNumAttributes from span', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, attrLong, attrInt, attrBool]);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('boolean'), equals(null));
  });

  test('test spanlimits maxNumAttributeLength with setAttributes', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, attrLong]);
    expect(span.attributes.get('shortkey'), equals('55555'));
    expect(span.attributes.get('longkey'), equals('55555'));
  });

  test('test spanlimits from span, then add more', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, attrLong]);
    expect(span.attributes.get('shortkey'), equals('55555'));
    expect(span.attributes.get('longkey'), equals('55555'));
    span.setAttribute(attrBool);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('boolKey'), equals(true));
    span.setAttribute(attrDoubleArray);
    expect(span.attributes.length, equals(maxAttributes));
    expect(span.attributes.get('doubleList'), equals(null));
  });

  test('test add same key twice', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, dupShort]);
    expect(span.attributes.length, 1);
    expect(span.attributes.get('shortkey'), equals('66666'));
    span.setAttributes([attrLong, dupLong]);
    expect(span.attributes.length, 2);
    expect(span.attributes.get('longkey'), equals('66666'));
  });

  test('test add same key twice', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, dupShort, attrLong, dupLong]);
    expect(span.attributes.length, 2);
    expect(span.attributes.get('shortkey'), equals('66666'));
    expect(span.attributes.get('longkey'), equals('66666'));
  });

  test('test add oversized string list', () {
    final span =
        sdkspan.Span('test', null, null, [], null, null, spanlimits: limits)
          ..setAttributes([attrShort, dupShort, attrLong, dupLong]);
    expect(span.attributes.length, 2);
    expect(span.attributes.get('shortkey'), equals('66666'));
    expect(span.attributes.get('longkey'), equals('66666'));
  });

  test('test default spanlimits', () {
    final attrs = [attrLong, attrDoubleArray, attrStringArray];
    final span_Limits = SpanLimits();
    final span = sdkspan.Span(
        'limitTest', null, SpanId([4, 5, 6]), [], null, null,
        attribute_list: attrs, spanlimits: span_Limits);
    expect(span.attributes.length, equals(3));
    expect(span.attributes.get('longkey'), equals('5555555'));
    expect(span.attributes.get('doubleList'), equals([0.1, 0.2]));
    expect(span.attributes.get('stringList'), equals(['1111', '1111111']));
  });
}
