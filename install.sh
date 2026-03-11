#!/usr/bin/env bash
set -euo pipefail

# --------------------------------------
# Paths
# --------------------------------------
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$DOTFILES_DIR/install/Brewfile"
MACOS_SCRIPT="$DOTFILES_DIR/install/macos.sh"
BREW_PLIST="$DOTFILES_DIR/install/com.user.brew-maint.plist"

# --------------------------------------
# 1️⃣ Xcode Command Line Tools
# --------------------------------------
echo "==> Installing Xcode CLI tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
fi

# --------------------------------------
# 2️⃣ Homebrew
# --------------------------------------
echo "==> Installing Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "==> Updating Homebrew..."
brew update

# --------------------------------------
# 3️⃣ Install packages from Brewfile
# --------------------------------------
echo "==> Installing packages from Brewfile..."
brew bundle --file="$BREWFILE"

# --------------------------------------
# 3️⃣ a Install mise global versions
# --------------------------------------
echo "==> Setting mise global versions..."
eval "$(mise activate zsh)"  # ensure mise is available

mise use --global node@lts
mise use --global python@3.12
mise use --global ruby@latest
mise use --global terraform@latest
mise use --global awscli@latest

# --------------------------------------
# 4️⃣ Apply macOS defaults
# --------------------------------------
echo "==> Applying macOS defaults..."
bash "$MACOS_SCRIPT"

# --------------------------------------
# 5️⃣ Automatic Homebrew updates
# --------------------------------------
echo "==> Setting up automatic Homebrew updates..."
mkdir -p ~/Library/LaunchAgents
cp "$BREW_PLIST" ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.brew-maint.plist

# --------------------------------------
# 6️⃣ Create config directories
# --------------------------------------
echo "==> Creating config directories..."
mkdir -p ~/.config

# --------------------------------------
# 7️⃣ Symlink dotfiles
# --------------------------------------
echo "==> Symlinking dotfiles..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/zsh/.zsh_plugins.txt" ~/.zsh_plugins.txt
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig

# --------------------------------------
# 8️⃣ Start services
# --------------------------------------
echo "==> Starting Syncthing..."
brew services start syncthing

# --------------------------------------
# ✅ Done
# --------------------------------------
echo
echo "✅ Install complete!"
