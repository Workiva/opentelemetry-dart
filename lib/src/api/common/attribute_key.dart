/// Common OpenTelemetry attribute keys.
///
/// Keys should follow OpenTelemetry's attribute semantic conventions:
/// https://github.com/open-telemetry/opentelemetry-specification/tree/main/specification/trace/semantic_conventions
class AttributeKey {
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
  static const String httpRequestContentLength =
      'http.request_content_length';

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

  /// Logical name of the service.
  static const String serviceName = 'service.name';

  /// A namespace for `service.name`.
  static const String serviceNamespace = 'service.namespace';

  /// The string ID of the service instance.
  static const String serviceInstanceId = 'service.instance.id';

  /// The version string of the service API or implementation.
  static const String serviceVersion = 'service.version';
}
