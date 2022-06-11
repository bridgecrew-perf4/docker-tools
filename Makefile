#Authored by Phillip Bailey
.PHONY: all build terraform ansible
.SILENT:
SHELL := '/bin/bash'

USERNAME=p0bailey

IMAGE=docker-jenkins

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker_build:  ## Build docker image!
	DOCKER_BUILDKIT=1 docker build --squash --no-cache -t ${USERNAME}/${IMAGE} .

docker_push:  ## Push docker image into Dockerhub!
	docker push ${USERNAME}/${IMAGE}

docker_up:  ## Start the dodcker image with docker-compose
	docker-compose up -d

docker_down:  ## Start the dodcker image with docker-compose
	docker-compose down


push:  ## push
	git add . && git commit -m "`date`" && git push origin ${BRANCH} || true

pull:  ## pull
	git pull origin ${BRANCH}

run:
	docker run -it  ${USERNAME}/${IMAGE}

pr:  ## Create PR
	gh pr create

open:
	gh browse
