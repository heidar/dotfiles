# dotfiles

Personal macOS dotfiles. Tested on Apple Silicon.

## Prerequisites

- macOS (Apple Silicon)
- Internet connection (Homebrew and packages will be downloaded)

## Install

```sh
git clone https://github.com/heidar/dotfiles.git ~/Code/heidar/dotfiles
cd ~/Code/heidar/dotfiles
./install.sh
```

## What gets installed

- **Homebrew** packages from `homebrew/Brewfile` (CLI tools + GUI apps)
- **TouchID** for sudo (via `sudo_local`, survives macOS updates)
- **mise** config symlinked to `~/.config/mise/config.toml` (node, python, ruby, terraform, awscli)
- **macOS defaults** from `install/macos.sh`
- **Automatic Homebrew updates** via a LaunchAgent
- **Symlinks**: `~/.zshrc`, `~/.gitconfig`, `~/.gitignore_global`, `~/.config/nvim/init.lua`, `~/.config/mise/config.toml`

## Post-install

Set git identity and signing key in `~/.gitconfig.local`:

```gitconfig
[user]
    name = Your Name
    email = you@example.com
    signingkey = ssh-ed25519 AAAA...
```

The signing key should be the public key of whichever SSH key you use in 1Password. Commits are signed automatically via the 1Password SSH agent (`op-ssh-sign`).
