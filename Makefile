# Code formatting, linting and UTs
.PHONY: fmt vet
# Supplementary targets
.PHONY: help clean

vet:
	@echo "+ $@"
	@go vet $(shell go list ./... | grep -v sandbox)

fmt:
	@echo "+ $@"
	@test -z "$$(gofmt -s -l . 2>&1 | grep -v ^vendor/ | tee /dev/stderr)" || \
		(echo >&2 "+ please format Go code with 'gofmt -s'" && false)

clean: ## Remove all temporary files
	rm -f $(PROJECT_NAME)

help: ## Print this help and exit
	@grep -E '^[a-zA-Z_\-\/]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
