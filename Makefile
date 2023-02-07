init:
	dart pub get
	dart pub global activate protoc_plugin 20.0.1
	cd lib/src/sdk/proto && \
		protoc --proto_path opentelemetry-proto \
		--dart_out . \
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

test: format analyze
	@dart test ./test \
		--chain-stack-traces \
		--platform vm \
		--platform chrome

.PHONY: init analyze test
