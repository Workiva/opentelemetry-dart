deps:
	@pub get

analyze-lib:
	@dart analyze ./lib

analyze-test:
	@dart analyze ./test

test: analyze-lib
	@dart test ./test --chain-stack-traces

.PHONY: deps analyze-lib analyze-test test
