ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: help
help: ## This Help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: build
build: ## Docker build image and push to docker.hub
	@echo "################################################################################"
	@echo "# Docker Build/Push Image"
	@echo "################################################################################"
	
	@docker build ./api_python/api -t gupi/api:v1.0.0
    
	@docker push gupi/api:v1.0.0

.PHONY: deploy
deploy: ## Deploy application on k8s
	@kubectl apply -f k8s/traefikv2.yml
	@kubectl apply -f k8s/api.yml
