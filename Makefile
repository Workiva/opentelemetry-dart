init:
	git submodule update --init
	dart pub get
	dart pub global activate protoc_plugin 19.3.1
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
	@dart test ./test \
		--chain-stack-traces \
		--platform vm \
		--platform chrome

.PHONY: init analyze test
