init:
	git submodule update --init
	pub get
	pub global activate protoc_plugin 19.3.1
	cd lib/src/sdk/trace/exporters && \
		protoc --proto_path opentelemetry-proto \
		--dart_out . \
		opentelemetry-proto/opentelemetry/proto/common/v1/common.proto \
		opentelemetry-proto/opentelemetry/proto/collector/trace/v1/trace_service.proto \
		opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto \
		opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto

analyze:
	@dart analyze

format:
	@find ./lib/ -name '*.dart' | xargs dart format --fix
	@find ./test/ -name '*.dart' | xargs dart format --fix

test: format analyze
	@dart test ./test --chain-stack-traces

update-package-version:  ## inject package version during build
	@set -e; \
	if [ -n "${GIT_TAG}" ]; then \
		echo "Setting package version to \"${GIT_TAG}\"" && \
		sed -i.bak 's/static const String version = '\''0.0.0'\''/static const String version = '\''${GIT_TAG}'\''/g' lib/src/sdk/instrumentation_library.dart && \
		rm lib/src/sdk/instrumentation_library.dart.bak; \
	fi;

.PHONY: init analyze test
