FROM mcr.microsoft.com/vscode/devcontainers/base:1-ubuntu-22.04 as awscli-builder

# Fetch and unpackage AWS CLI
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  unzip \
  curl \
  ca-certificates \
  && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install -i /usr/local/aws-cli -b /usr/local/bin


FROM mcr.microsoft.com/vscode/devcontainers/base:1-ubuntu-22.04 as devcontainer

# Update apt and install packages
RUN apt-get update && apt-get -y upgrade \
  && rm -rf /var/lib/apt/lists/*

# Install AWS CLI
COPY --from=awscli-builder /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws

# Install AWS CLI Session Manager Plugin
RUN curl https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb -o /tmp/session-manager-plugin.deb \
  && dpkg -i /tmp/session-manager-plugin.deb \
  && rm /tmp/session-manager-plugin.deb

# Install AWS Vault
RUN curl -Lo /tmp/aws-vault https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-linux-amd64 \
  && install -c -m 0755 /tmp/aws-vault /usr/local/bin/aws-vault \
  && rm /tmp/aws-vault

USER vscode

# Install ASDF
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0 && \
  echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc && \
  echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc

# Configure Terraform global plugin cache
RUN echo 'plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"' >> ~/.terraformrc

# Setup post-start script
USER root
COPY post-start.sh /usr/local/bin/post-start
RUN chmod +x /usr/local/bin/post-start
