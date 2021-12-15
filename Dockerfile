
FROM debian:stable-slim

ARG VAULT_VERSION="1.9.0"
ARG TERRAFORM_VERSION="1.0.11"
ARG TFSEC_VERSION="0.63.1"
ARG ANSIBLE_VERSION="4.8.0"
ARG MOLECULE_VERSION="3.5.2"
ARG TFLINT_VERSION="0.33.2"
ARG CREDENTIALS_HELPER_RELEASE="1.0.0"

LABEL vault_version=${VAULT_VERSION}
LABEL terraform_version=${TERRAFORM_VERSION}
LABEL terraform_version=${TFSEC_VERSION}
LABEL terraform_version=${ANSIBLE_VERSION}
LABEL terraform_version=${MOLECULE_VERSION}
LABEL terraform_version=${TFLINT_VERSION}

WORKDIR /

ENV DOCKER_HOST unix:///var/tmp/docker.sock

RUN apt-get update && apt-get install -y --no-install-recommends \
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
  wget https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64  -O /bin/tfsec &&\
  chmod +x /bin/tfsec &&\
  wget https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip &&\
  unzip tflint_linux_amd64.zip -d /bin &&\
  mkdir -p ~/.terraform.d/plugins/ &&\
  wget https://github.com/apparentlymart/terraform-credentials-env/releases/download/v${CREDENTIALS_HELPER_RELEASE}/terraform-credentials-env_${CREDENTIALS_HELPER_RELEASE}_linux_amd64.zip -O ~/.terraform.d/plugins/terraform-credentials-env_${CREDENTIALS_HELPER_RELEASE}_linux_amd64.zip &&\
  unzip ~/.terraform.d/plugins/terraform-credentials-env_${CREDENTIALS_HELPER_RELEASE}_linux_amd64.zip  -d ~/.terraform.d/plugins &&\
  mv ~/.terraform.d/plugins/terraform-credentials-env_v${CREDENTIALS_HELPER_RELEASE}_x4 ~/.terraform.d/plugins/terraform-credentials-env &&\
  rm -rf ~/.terraform.d/plugins/terraform-credentials-env_${CREDENTIALS_HELPER_RELEASE}_linux_amd64.zip

COPY terraformrc /root/.terraformrc

CMD    ["/bin/bash"]
