#Authored by Phillip Bailey
.PHONY: all build
.SILENT:
SHELL := '/bin/bash'

USERNAME=p0bailey

IMAGE=docker-tools

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

DOCKER_RUN := $(shell docker run --rm ${USERNAME}/${IMAGE})
all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:  ## Build docker image!
	docker build -t ${USERNAME}/${IMAGE} .

push:  ## push
	git add . && git commit -m "`date`" && git push origin $${BRANCH} || true

pull:  ## pull
	git pull origin $${BRANCH}

ansible:  ## ansible
	${DOCKER_RUN} ansible --version

terraform:  ## ansible
	${DOCKER_RUN} terraform --version
