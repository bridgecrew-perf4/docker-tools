
FROM debian:11-slim

ARG VAULT_VERSION="1.8.5"

ARG TERRAFORM_VERSION="1.0.11"

ARG TFSEC_VERSION="0.59.0"
#https://github.com/tfsec/tfsec

ARG ANSIBLE_VERSION="4.8.0"

ARG MOLECULE_VERSION="3.5.2"

LABEL terraform_version=${TERRAFORM_VERSION}

WORKDIR /

ENV DOCKER_HOST unix:///var/tmp/docker.sock

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  git \
  curl \
  docker.io \
  python3-pip &&\
  pip3 install ansible==${ANSIBLE_VERSION} \
  molecule[docker,lint] \
  pytest-testinfra \
  yamllint \
  ansible-lint \
  checkov \
  && rm -rf /var/lib/apt/lists/* &&\
  wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip  &&\
  unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /bin &&\
  wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip  &&\
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin &&\
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && rm -f vault_${VAULT_VERSION}_linux_amd64.zip &&\
  wget https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64  -O /bin/tfsec



CMD    ["/bin/bash"]
