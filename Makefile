#Authored by Phillip Bailey
.PHONY: all build terraform ansible
.SILENT:
SHELL := '/bin/bash'

USERNAME=p0bailey

IMAGE=docker-tools

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)


all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker_build:  ## Build docker image!
	DOCKER_BUILDKIT=1 docker build --squash --no-cache -t ${USERNAME}/${IMAGE} .

docker_push:  ## Push docker image into Dockerhub!
	docker push ${USERNAME}/${IMAGE}

push:  ## push
	git add . && git commit -m "`date`" && git push origin $${BRANCH} || true

pull:  ## pull
	git pull origin $${BRANCH}

ansible:  ## ansible
	docker run --rm ${USERNAME}/${IMAGE} ansible --version

terraform:  ## ansible
	docker run --rm ${USERNAME}/${IMAGE} terraform --version

vault:  ## vault
	docker run --rm ${USERNAME}/${IMAGE} vault --version

tflint:  ## tflint
	docker run --rm ${USERNAME}/${IMAGE} tflint --version

tfsec:	## tfsec
	docker run --rm ${USERNAME}/${IMAGE} tfsec --version

run:
	docker run -it  ${USERNAME}/${IMAGE}

pr:  ## Create PR
	gh pr create

open:
	gh browse
