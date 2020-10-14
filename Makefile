PROJECT_NAME := letsencrypt-ready-nginx
PROJECT_PATH := mmohaveri/$(PROJECT_NAME)

COMMIT := $(shell git rev-parse HEAD 2> /dev/null || echo "NULL")
VERSION := $(shell git describe $(COMMIT) 2> /dev/null || echo "$(COMMIT)")
IMAGE_NAME := $(PROJECT_PATH)
IMAGE_VERSION := $(VERSION)

PROJECT_FILES := $(shell find $(PROJECT_NAME) -name "*.py" 2> /dev/null || echo "NULL")
TEST_FILES := $(shell find tests -name "test_*.py" 2> /dev/null || echo "NULL")

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker: ## Build docker image
	@docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

push: docker ## Push docker image to registry
	@docker push $(IMAGE_NAME):$(VERSION)

.PHONY: help docker push