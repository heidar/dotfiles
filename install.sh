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
brew bundle --file="$DOTFILES_DIR/install/Brewfile"

echo "==> Applying macOS defaults"
bash "$DOTFILES_DIR/install/macos.sh"

echo "==> Setting up automatic Homebrew updates"
mkdir -p ~/Library/LaunchAgents
cp ./install/com.user.brew-maint.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.brew-maint.plist

echo "==> Creating config directories"
mkdir -p ~/.config

echo "==> Symlinking dotfiles"

ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

echo "==> Starting Syncthing"
brew services start syncthing

echo
echo "✅ Install complete!"

