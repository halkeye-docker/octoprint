.DEFAULT_GOAL := help
DOCKER_PREFIX ?= halkeye
DOCKER_IMAGE ?= octoprint

build: ## build the docker version
	docker build -t $(DOCKER_PREFIX)/$(DOCKER_IMAGE) .

run: ## run the latest docker build
	docker run --rm -it --name $(DOCKER_IMAGE) -p 3000:5000 $(DOCKER_PREFIX)/$(DOCKER_IMAGE)

push: ## push to docker registry
	docker push $(DOCKER_PREFIX)/$(DOCKER_IMAGE)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
