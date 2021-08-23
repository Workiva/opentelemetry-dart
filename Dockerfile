FROM google/dart:2.13
WORKDIR /build

RUN apt update && apt install -y make protobuf-compiler

COPY pubspec.yaml .
RUN pub get

COPY . .

RUN make init analyze test

# Inject Version Information
ARG GIT_TAG
RUN make update-package-version

RUN ./package.sh

ARG BUILD_ARTIFACTS_PUB=/build/pub_package.pub.tgz

FROM scratch
