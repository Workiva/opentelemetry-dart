// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

/// Common OpenTelemetry attribute keys for non-resource information.
///
/// Keys should follow OpenTelemetry's attribute semantic conventions:
/// https://github.com/open-telemetry/opentelemetry-specification/tree/main/specification/trace/semantic_conventions
class SemanticAttributes {
  /// The type of the exception (its fully-qualified class name, if applicable). The dynamic type of
  static const String exceptionType = 'exception.type';

  /// The exception message.
  static const String exceptionMessage = 'exception.message';

  /// A stacktrace as a string in the natural representation for the language runtime. The
  /// representation is to be determined and documented by each language SIG.
  static const String exceptionStacktrace = 'exception.stacktrace';

  /// HTTP request method.
  static const String httpMethod = 'http.method';

  /// Full HTTP request URL in the form `scheme://host[:port]/path?query[#fragment]`.
  ///
  /// Note: `http.url` MUST NOT contain credentials passed via URL in form of
  /// `https://username:password@www.example.com/`. In such case the attribute's value should be
  /// `https://www.example.com/`.
  static const String httpUrl = 'http.url';

  /// The full request target as passed in a HTTP request line or equivalent.
  static const String httpTarget = 'http.target';

  /// The value of the [HTTP host header](https://tools.ietf.org/html/rfc7230#section-5.4).
  static const String httpHost = 'http.host';

  /// The URI scheme identifying the used protocol.
  static const String httpScheme = 'http.scheme';

  /// [HTTP response status code](https://tools.ietf.org/html/rfc7231#section-6).
  static const String httpStatusCode = 'http.status_code';

  /// Kind of HTTP protocol used.
  static const String httpFlavor = 'http.flavor';

  /// Value of the [HTTP User-Agent](https://tools.ietf.org/html/rfc7231#section-5.5.3)
  /// header sent by the client.
  static const String httpUserAgent = 'http.user_agent';

  /// The size of the request payload body in bytes.
  ///
  /// This is the number of bytes transferred excluding headers and is often,
  /// but not always, present as the [Content-Length](https://tools.ietf.org/html/rfc7230#section-3.3.2) header.
  /// For requests using transport encoding, this should be the compressed size.
  static const String httpRequestContentLength = 'http.request_content_length';

  /// The size of the uncompressed request payload body after transport decoding. Not set if
  /// transport encoding not used.
  static const String httpRequestContentLengthUncompressed =
      'http.request_content_length_uncompressed';

  /// The size of the response payload body in bytes.
  ///
  /// This is the number of bytes transferred
  /// excluding headers and is often, but not always, present as the
  /// [Content-Length](https://tools.ietf.org/html/rfc7230#section-3.3.2) header. For requests using
  /// transport encoding, this should be the compressed size.
  static const String httpResponseContentLength =
      'http.response_content_length';

  /// The size of the uncompressed response payload body after transport decoding. Not set if
  /// transport encoding not used.
  static const String httpResponseContentLengthUncompressed =
      'http.response_content_length_uncompressed';

  /// The primary server name of the matched virtual host.
  static const String httpServerName = 'http.server_name';

  /// The matched route (path template).
  static const String httpRoute = 'http.route';

  /// The IP address of the original client behind all proxies, if known (e.g. from
  /// [X-Forwarded-For](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For)).
  static const String httpClientIp = 'http.client_ip';

  /// A string identifying the messaging system.
  static const String messagingSystem = 'messaging.system';

  /// The message destination name.
  static const String messagingDestination = 'messaging.destination';

  /// The kind of message destination
  static const String messagingDestinationKind = 'messaging.destination_kind';

  /// A boolean that is true if the message destination is temporary.
  static const String messagingTempDestination = 'messaging.temp_destination';

  /// The name of the transport protocol.
  static const String messagingProtocol = 'messaging.protocol';

  /// The version of the transport protocol.
  static const String messagingProtocolVersion = 'messaging.protocol_version';

  /// Connection string.
  static const String messagingUrl = 'messaging.url';

  /// A value used by the messaging system as an identifier for the message, represented as a string.
  static const String messagingMessageId = 'messaging.message_id';

  /// The conversation ID identifying the conversation to which the message belongs,
  /// represented as a string. Sometimes called "Correlation ID".
  static const String messagingConversationId = 'messaging.conversation_id';

  /// The (uncompressed) size of the message payload in bytes. Also use this
  /// attribute if it is unknown whether the compressed or uncompressed payload
  /// size is reported.
  static const String messagingMessagePayloadSizeBytes =
      'messaging.message_payload_size_bytes';

  /// The compressed size of the message payload in bytes.
  static const String messagingMessagePayloadCompressedSizeBytes =
      'messaging.message_payload_compressed_size_bytes';
}

/// Attribute values for key [SemanticAttributes.messagingDestinationKind].
class MessagingDestinationKindValues {
  /// A message sent to a queue.
  static const String queue = 'queue';

  /// A message sent to a topic.
  static const String topic = 'topic';
}
