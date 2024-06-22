init:
	git submodule init
	# Pull opentelemetry-proto at the stored commit.
	# To upgrade, execute `git submodule update --remote --merge`
	# and commit the result.
	git submodule update
	dart pub get
	# Generate mocks for unit tests.  For config, see build.yaml.
	dart run build_runner build --delete-conflicting-outputs
	if dart --version | grep 'Dart SDK version: 2'; then \
		dart pub global activate protoc_plugin 20.0.1; \
	else \
		dart pub global activate protoc_plugin 21.1.2; \
	fi
	cd lib/src/sdk/proto && \
		protoc --proto_path opentelemetry-proto --dart_out grpc:. \
			opentelemetry-proto/opentelemetry/proto/common/v1/common.proto \
			opentelemetry-proto/opentelemetry/proto/collector/trace/v1/trace_service.proto \
			opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto \
			opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto

analyze:
	@dart analyze

format:
	@find ./lib -name '*.dart' -not -path './lib/src/sdk/proto/opentelemetry/*' | xargs dart format --fix
	@find ./test/ -name '*.dart' | xargs dart format --fix
	@./scripts/attach_copyright.sh

test:
	@dart test ./test \
		--chain-stack-traces \
		--platform vm \
		--platform chrome

.PHONY: init format analyze test
