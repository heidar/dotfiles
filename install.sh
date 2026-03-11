#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Xcode CLI tools"
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
fi

echo "==> Installing Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "==> Updating Homebrew"
brew update

echo "==> Installing packages from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Applying macOS defaults"
bash "$DOTFILES_DIR/macos.sh"

echo "==> Creating config directories"
mkdir -p ~/.config

echo "==> Symlinking dotfiles"

ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

echo "==> Starting Syncthing"
brew services start syncthing

echo
echo "✅ Install complete!"
echo
echo "⚠️  Some actions need manual completion or verification:"

# Git identity check
if ! git config --global user.email >/dev/null; then
  echo "- Set your Git identity:"
  echo "    git config --global user.name \"Your Name\""
  echo "    git config --global user.email \"you@example.com\""
fi

# gh CLI check
if ! gh auth status >/dev/null 2>&1; then
  echo "- Authenticate GitHub CLI:"
  echo "    gh auth login"
fi

# tailscale check
if ! tailscale status >/dev/null 2>&1; then
  echo "- Start Tailscale:"
  echo "    tailscale up"
fi

echo
echo "After completing the above steps, your system should be fully configured."
