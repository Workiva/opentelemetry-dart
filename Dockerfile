FROM google/dart:2.13
WORKDIR /build

RUN apt update && apt install -y make protobuf-compiler

COPY pubspec.yaml .
RUN dart pub get

COPY . .

RUN make init analyze test

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
