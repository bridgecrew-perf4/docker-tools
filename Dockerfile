
FROM debian:10-slim

ENV VAULT_VERSION=1.6.0

ENV TERRAFORM_VERSION=0.14.2

WORKDIR /

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  curl \
  python3-pip &&\
  pip3 install molecule \
  ansible \
  docker \
  yamllint \
  ansible-lint \
  && rm -rf /var/lib/apt/lists/* &&\
  wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip  &&\
  unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /bin &&\
  wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip  &&\
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin &&\
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && rm -f vault_${VAULT_VERSION}_linux_amd64.zip 
