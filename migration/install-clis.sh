#!/usr/bin/env bash
# Add CLIs that are missing from the default web container.
# Uncomment lines as needed for your workflow.

set -uo pipefail

need() { ! command -v "$1" >/dev/null 2>&1; }

# --- apt-based tools (Debian/Ubuntu base) -------------------------------
APT_PKGS=()
# need fzf       && APT_PKGS+=(fzf)
# need bat       && APT_PKGS+=(bat)
# need fd        && APT_PKGS+=(fd-find)
# need sqlite3   && APT_PKGS+=(sqlite3)
# need tree      && APT_PKGS+=(tree)
# need htop      && APT_PKGS+=(htop)

if [ ${#APT_PKGS[@]} -gt 0 ]; then
  sudo apt-get update -qq
  sudo apt-get install -y -qq "${APT_PKGS[@]}"
fi

# --- gh (GitHub CLI) ----------------------------------------------------
# if need gh; then
#   curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
#     | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
#   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
#     | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
#   sudo apt-get update -qq && sudo apt-get install -y -qq gh
# fi

# --- kubectl ------------------------------------------------------------
# if need kubectl; then
#   curl -fsSLO "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#   sudo install -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl
# fi

# --- aws cli ------------------------------------------------------------
# if need aws; then
#   curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscli.zip
#   unzip -q /tmp/awscli.zip -d /tmp && sudo /tmp/aws/install
# fi

echo "[install-clis] complete"
