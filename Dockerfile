
FROM debian:10-slim

ARG VAULT_VERSION="1.7.1"

ARG TERRAFORM_VERSION="0.15.1"

ARG TFSEC_VERSION="0.39.24"
#https://github.com/tfsec/tfsec

LABEL terraform_version=${TERRAFORM_VERSION}

WORKDIR /

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  git \
  curl \
  python3-pip &&\
  pip3 install molecule \
  ansible \
  docker \
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
