#Authored by Phillip Bailey
.PHONY: all build
.SILENT:
SHELL := '/bin/bash'

USERNAME=p0bailey

IMAGE=docker-tools

all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## Build docker image!
	docker build -t ${USERNAME}/${IMAGE} .
