
FROM debian:stable-slim

ARG VAULT_VERSION=1.9.2
ARG TERRAFORM_VERSION=1.1.1
ARG TFSEC_VERSION=0.63.1
ARG ANSIBLE_VERSION=2.10.7
ARG MOLECULE_VERSION=3.4.0
ARG MOLECULE_DOCKER=1.0.2
ARG TFLINT_VERSION=0.33.2
ARG CREDENTIALS_HELPER_VERSION=1.0.0
ARG AWS_CLI_VERSION=2.0.30
ARG TRIVY_VERSION=0.21.2

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
  ca-certificates \
  git \
  curl \
  docker.io \
  python3-pip \
  make




RUN  pip3 install  ansible==${ANSIBLE_VERSION} \
  molecule==${MOLECULE_VERSION} \
  molecule-docker==${MOLECULE_DOCKER} \
  pytest-testinfra \
  yamllint \
  ansible-lint \
  checkov \
  && pip cache purge

RUN wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip  &&\
  unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /bin &&\
  wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip  &&\
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin &&\
  wget https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64  -O /bin/tfsec &&\
  chmod +x /bin/tfsec &&\
  wget https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip &&\
  unzip tflint_linux_amd64.zip -d /bin &&\
  mkdir -p ~/.terraform.d/plugins/ &&\
  wget https://github.com/apparentlymart/terraform-credentials-env/releases/download/v${CREDENTIALS_HELPER_VERSION}/terraform-credentials-env_${CREDENTIALS_HELPER_VERSION}_linux_amd64.zip -O ~/.terraform.d/plugins/terraform-credentials-env_${CREDENTIALS_HELPER_VERSION}_linux_amd64.zip &&\
  unzip ~/.terraform.d/plugins/terraform-credentials-env_${CREDENTIALS_HELPER_VERSION}_linux_amd64.zip  -d ~/.terraform.d/plugins &&\
  mv ~/.terraform.d/plugins/terraform-credentials-env_v${CREDENTIALS_HELPER_VERSION}_x4 ~/.terraform.d/plugins/terraform-credentials-env &&\
  curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip &&\
  unzip awscliv2.zip && ./aws/install &&\
  ln -s /usr/local/bin/aws /bin/aws &&\
  mkdir -p /opt/trivy/ &&\
  wget https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz -O /opt/trivy/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz &&\
  tar xvfz /opt/trivy/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz -C /opt/trivy/ && cp /opt/trivy/trivy /bin/ && chmod +x /bin/trivy &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && rm -f vault_${VAULT_VERSION}_linux_amd64.zip &&\
  rm -rf ~/.terraform.d/plugins/terraform-credentials-env_$CREDENTIALS_HELPER_VERSION}_linux_amd64.zip &&\
  rm -rf tflint_linux_amd64.zip &&\
  rm -f /awscliv2.zip &&\
  rm -rf /opt/trivy/


COPY terraformrc /root/.terraformrc

CMD    ["/bin/bash"]
