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

if ! git config --global user.email >/dev/null; then
  echo
  echo "⚠️  Git identity not configured."
  echo "Run:"
  echo
  echo "git config --global user.name \"Your Name\""
  echo "git config --global user.email \"you@example.com\""
  echo "git config --global user.signingkey \"abcdefg12345\""
  echo
fi

echo "==> Starting Syncthing"
brew services start syncthing

echo "==> Setup complete"
