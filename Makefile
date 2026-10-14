init:
	dart pub get

analyze:
	@dart analyze

format:
	@dart format lib test
	@./scripts/attach_copyright.sh

test:
	@dart test ./test \
		--chain-stack-traces \
		--platform vm,chrome \
		-c dart2js,dart2wasm

.PHONY: init format analyze test
