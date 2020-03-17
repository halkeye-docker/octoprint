.DEFAULT_GOAL := build
VERSION := $(shell awk '/OctoPrint==(.*)/ {print gensub(/OctoPrint==/, "", 1)}' requirements.txt)
DOCKER_PREFIX ?= halkeye
DOCKER_IMAGE ?= octoprint

.PHONY: version
version: ## Show the current image version
	@echo Image: $(DOCKER_PREFIX)/$(DOCKER_IMAGE):$(VERSION)
	@echo Version: $(VERSION)

.PHONY: build
build: ## build the docker version
	docker build -t $(DOCKER_PREFIX)/$(DOCKER_IMAGE):$(VERSION) .

.PHONY: run
run: ## run the latest docker build
	docker run --rm -it --name $(DOCKER_IMAGE)-local -p 3000:5000 $(DOCKER_PREFIX)/$(DOCKER_IMAGE):$(VERSION)

.PHONY: push
push: ## push to docker registry
	docker push $(DOCKER_PREFIX)/$(DOCKER_IMAGE):$(VERSION)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
