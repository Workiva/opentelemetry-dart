FROM dart:2.13
WORKDIR /build

RUN apt update && apt install -y make protobuf-compiler gnupg wget

COPY pubspec.yaml .
RUN dart pub get

COPY . .

# Install Chrome for testing browser-specific features.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -qq update && apt-get install -y google-chrome-stable && \
    mv /usr/bin/google-chrome-stable /usr/bin/google-chrome && \
    sed -i --follow-symlinks -e 's/\"\$HERE\/chrome\"/\"\$HERE\/chrome\" --no-sandbox/g' /usr/bin/google-chrome

RUN export PATH="$PATH":"$HOME/.pub-cache/bin" && \
    make init analyze test

RUN ./package.sh

# Build Environment Vars (Semver)
ARG BUILD_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG GIT_COMMIT
ARG GIT_BRANCH
ARG GIT_TAG
ARG GIT_COMMIT_RANGE
ARG GIT_HEAD_URL
ARG GIT_MERGE_HEAD
ARG GIT_MERGE_BRANCH

RUN dart pub global activate --hosted-url https://pub.workiva.org semver_audit ^2.2.0
RUN dart pub global run semver_audit report --repo Workiva/opentelemetry-dart

ARG BUILD_ARTIFACTS_PUB=/build/pub_package.pub.tgz

FROM scratch
