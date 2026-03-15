#!/usr/bin/env bash
set -euo pipefail

# --------------------------------------
# Paths
# --------------------------------------
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$DOTFILES_DIR/homebrew/Brewfile"
MACOS_SCRIPT="$DOTFILES_DIR/install/macos.sh"
BREW_PLIST="$DOTFILES_DIR/install/com.user.brew-maint.plist"

# --------------------------------------
# 1. Xcode Command Line Tools
# --------------------------------------
echo "==> Installing Xcode CLI tools..."
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
fi

# --------------------------------------
# 2. Homebrew
# --------------------------------------
echo "==> Installing Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure Homebrew is in PATH for the rest of this script (needed on Apple Silicon fresh installs)
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "==> Updating Homebrew..."
brew update

# --------------------------------------
# 3. TouchID for sudo (survives macOS updates via sudo_local)
#    Install pam-reattach first so the .so is available before brew bundle runs
# --------------------------------------
echo "==> Installing pam-reattach..."
brew install pam-reattach

echo "==> Enabling TouchID for sudo..."
SUDO_LOCAL="/etc/pam.d/sudo_local"
if ! grep -q "pam_tid" "$SUDO_LOCAL" 2>/dev/null; then
  sudo tee "$SUDO_LOCAL" > /dev/null << 'EOF'
# sudo_local: local config which survives system updates and is included by sudo
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
EOF
  echo "TouchID sudo enabled."
else
  echo "TouchID sudo already configured."
fi

# --------------------------------------
# 4. Install packages from Brewfile
#    --cleanup removes anything not in Brewfile, keeping installs idempotent
# --------------------------------------
echo "==> Installing packages from Brewfile..."
brew bundle --file="$BREWFILE" --cleanup

# --------------------------------------
# 5. Symlink mise config
# --------------------------------------
echo "==> Symlinking mise config..."
mkdir -p ~/.config/mise
ln -sf "$DOTFILES_DIR/mise/config.toml" ~/.config/mise/config.toml
mise trust "$DOTFILES_DIR/mise/config.toml"
mise settings ruby.compile=false
mise install

# --------------------------------------
# 6. Apply macOS defaults
# --------------------------------------
echo "==> Applying macOS defaults..."
bash "$MACOS_SCRIPT"

# --------------------------------------
# 7. Automatic Homebrew updates
# --------------------------------------
echo "==> Setting up automatic Homebrew updates..."
mkdir -p ~/Library/LaunchAgents
cp "$BREW_PLIST" ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.brew-maint.plist 2>/dev/null || true

echo "==> Remapping Caps Lock to Control..."
KEYREMAP_PLIST="$DOTFILES_DIR/install/com.user.keyremap.plist"
cp "$KEYREMAP_PLIST" ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.user.keyremap.plist 2>/dev/null || true

# --------------------------------------
# 8. Create config directories
# --------------------------------------
echo "==> Creating config directories..."
mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/zed

# --------------------------------------
# 9. Symlink dotfiles
# --------------------------------------
echo "==> Symlinking dotfiles..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/zsh/.zsh_plugins.txt" ~/.zsh_plugins.txt
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global
ln -sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config
ln -sf "$DOTFILES_DIR/zed/settings.json" ~/.config/zed/settings.json

# --------------------------------------
# 10. Start services
# --------------------------------------
echo "==> Starting Syncthing..."
brew services start syncthing 2>/dev/null || true

# --------------------------------------
# 11. Claude (requires Tailscale — skip if unavailable)
# --------------------------------------
echo "==> Installing Claude..."
if [[ -f ~/.local/bin/claude ]]; then
  echo "Claude already installed, skipping."
else
  curl -fsSL https://claude.ai/install.sh | bash || echo "Claude install failed (Tailscale required?) — skipping."
fi

# --------------------------------------
echo
echo "Install complete! Restart for all changes to take effect."
