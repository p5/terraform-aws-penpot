#!/usr/bin/env bash

# Workaround required to add asdf to $PATH for tools such as DevPod, which do not use `.bashrc` during setup
. "$HOME/.asdf/asdf.sh"

# Read and process the .tool-versions file
echo "Installing required asdf plugins..."
ln -s .devcontainer/.tool-versions .tool-versions
while IFS= read -r line; do
  tool_name=$(echo "$line" | awk '{print $1}')
  printf "\e[0;34mInstalling asdf plugin: %s...\e[0m\n" "$tool_name"
  asdf plugin-add "$tool_name"
done < .tool-versions

# Install required asdf versions
echo "Installing asdf tools..."
asdf install

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
pre-commit install

# Configuring global Terraform cache directory
mkdir -p ~/.terraform.d/plugin-cache

clear
printf "\e[0;32mTerraform AWS PenPot Dev Container: %s\e[0m\n" "$(basename "$PWD")"
devcontainer-info
