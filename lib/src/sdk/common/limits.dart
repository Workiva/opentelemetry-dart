// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information
import 'package:meta/meta.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// Applies given [sdk.SpanLimits] to a list of [api.SpanLink]s.
@protected
List<api.SpanLink> applyLinkLimits(List<api.SpanLink> links, sdk.SpanLimits limits) {
  final spanLink = <api.SpanLink>[];

  for (final link in links) {
    if (spanLink.length >= limits.maxNumLink) {
      break;
    }

    if (!link.context.isValid) continue;

    final linkAttributes = <api.Attribute>[];

    // make sure override duplicated attributes in the list
    final attributeMap = <String, int>{};

    var droppedAttributes = 0;
    for (final attr in link.attributes) {
      // if attributes num is already greater than maxNumAttributesPerLink
      // and this key doesn't exist in the list, drop it.
      if (attributeMap.length >= limits.maxNumAttributesPerLink && !attributeMap.containsKey(attr.key)) {
        droppedAttributes++;
        continue;
      }

      // apply maxNumAttributeLength limit.
      final trimmedAttr = applyAttributeLimits(attr, limits);

      // if this key has been added before, find its index,
      // and replace it with new value.
      final idx = attributeMap[attr.key];
      if (idx != null) {
        linkAttributes[idx] = trimmedAttr;
      } else {
        // record this new key's index with linkAttributes length,
        // and add this new attr in linkAttributes.
        attributeMap[attr.key] = linkAttributes.length;
        linkAttributes.add(trimmedAttr);
      }
    }

    spanLink.add(api.SpanLink(link.context, attributes: linkAttributes, droppedAttributes: droppedAttributes));
  }
  return spanLink;
}

/// Applies given [sdk.SpanLimits] to an [api.Attribute].
@protected
api.Attribute applyAttributeLimits(api.Attribute attr, sdk.SpanLimits limits) {
  // if maxNumAttributeLength is less than zero, then it has unlimited length.
  if (limits.maxNumAttributeLength < 0) return attr;

  if (attr.value is String) {
    attr = api.Attribute.fromString(
        attr.key, applyAttributeLengthLimit(attr.value as String, limits.maxNumAttributeLength));
  } else if (attr.value is List<String>) {
    final listString = attr.value as List<String>;
    for (var j = 0; j < listString.length; j++) {
      listString[j] = applyAttributeLengthLimit(listString[j], limits.maxNumAttributeLength);
    }
    attr = api.Attribute.fromStringList(attr.key, listString);
  }
  return attr;
}

@protected
api.Attribute applyAttributeLimitsForLog(
  api.Attribute attr,
  sdk.LogRecordLimits limits,
) {
  // if maxNumAttributeLength is less than zero, then it has unlimited length.
  if (limits.attributeValueLengthLimit < 0) return attr;

  if (attr.value is String) {
    return (attr.value as String).length > limits.attributeValueLengthLimit
        ? api.Attribute.fromString(attr.key, (attr.value as String).substring(0, limits.attributeValueLengthLimit))
        : attr;
  } else if (attr.value is List<String>) {
    final list = (attr.value as List<String>);
    List<String>? truncated;
    for (int i = 0; i < list.length; i++) {
      final s = list[i];
      if (s.length > limits.attributeValueLengthLimit) {
        truncated ??= List<String>.from(list, growable: false);
        truncated[i] = s.substring(0, limits.attributeValueLengthLimit);
      }
    }
    if (truncated != null) {
      return api.Attribute.fromStringList(attr.key, truncated);
    }
  }
  return attr;
}

/// Truncate just strings which length is longer than configuration.
/// Reference: https://github.com/open-telemetry/opentelemetry-java/blob/14ffacd1cdd22f5aa556eeda4a569c7f144eadf2/sdk/common/src/main/java/io/opentelemetry/sdk/internal/AttributeUtil.java#L80
@protected
String applyAttributeLengthLimit(String value, int lengthLimit) {
  return value.length > lengthLimit ? value.substring(0, lengthLimit) : value;
}
