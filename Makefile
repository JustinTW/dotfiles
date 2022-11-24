.PHONY: help
.DEFAULT_GOAL := help

DOT_ENV ?= .env
ifneq ("$(wildcard $(DOT_ENV))","")
	include $(DOT_ENV)
	export $(shell sed 's/=.*//' $(DOT_ENV))
endif

# alias
b: build
r: run
p: push
c: clean

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: ## Boot up app on local environment
	docker-compose -f ./deployments/docker-compose.yaml up -d $(DOCKER_APP)

at: up ## Attach local environment
	docker exec -it $(DOCKER_APP) bash

down: ## Halt local environment
	docker-compose -f ./deployments/docker-compose.yaml stop
	docker-compose -f ./deployments/docker-compose.yaml rm -f
