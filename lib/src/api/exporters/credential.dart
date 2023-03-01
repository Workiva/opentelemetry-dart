// Copyright 2021-2023 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

/// A representation of a single piece of metadata attached to trace span.
enum CredentialKind {
  // credential for API key authorization
  apiKey,

  // credential for secret token authorization
  secretToken
}

class Credential {
  final CredentialKind kind;
  final String value;

  Credential(this.kind, this.value);

  @override
  String toString() {
    String authValue;

    switch (kind) {
      case CredentialKind.apiKey:
        authValue = 'ApiKey $value';
        break;
      case CredentialKind.secretToken:
        authValue = 'Bearer $value';
        break;
    }

    return authValue;
  }
}
