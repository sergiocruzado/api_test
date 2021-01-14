ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: help
help: ## This Help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: run
run:  ## Run the api
	@gunicorn --log-level debug --bind 0.0.0.0:5000 rest.main:api
