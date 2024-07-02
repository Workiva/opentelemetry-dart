init:
	git submodule init
	# Pull opentelemetry-proto at the stored commit.
	# To upgrade, execute `git submodule update --remote --merge`
	# and commit the result.
	git submodule update
	dart pub get
	# Generate mocks for unit tests.  For config, see build.yaml.
	dart run build_runner build --delete-conflicting-outputs
	dart pub global activate protoc_plugin 21.1.2
	cd lib/src/sdk/proto && \
		protoc --proto_path opentelemetry-proto --dart_out . \
			opentelemetry-proto/opentelemetry/proto/common/v1/common.proto \
			opentelemetry-proto/opentelemetry/proto/collector/trace/v1/trace_service.proto \
			opentelemetry-proto/opentelemetry/proto/trace/v1/trace.proto \
			opentelemetry-proto/opentelemetry/proto/resource/v1/resource.proto
	./scripts/attach_copyright.sh

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
