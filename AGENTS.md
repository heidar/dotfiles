# Repo structure and conventions

## Layout

```
dotfiles/
├── git/            # .gitconfig, .gitignore_global
├── homebrew/       # Brewfile
├── install/        # macos.sh, LaunchAgent plist
├── mise/           # config.toml (global tool versions)
├── nvim/           # init.lua
├── zsh/            # .zshrc, .zsh_plugins.txt
└── install.sh      # idempotent bootstrap script
```

## Symlink pattern

Each tool's config lives in its own directory in this repo and is symlinked into place by `install.sh`. Example:

```sh
ln -sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua
```

`install.sh` uses `ln -sf` throughout, so re-running it is safe.

## Adding a new tool

1. Create a directory for the tool (e.g. `starship/`)
2. Add the config file(s) there
3. Add a `ln -sf` line in the **Symlink dotfiles** section of `install.sh`
4. If it needs a Homebrew package, add it to `homebrew/Brewfile`

## mise (runtime versions)

Global tool versions are declared in `mise/config.toml`, symlinked to `~/.config/mise/config.toml`. Edit that file to add or change versions — no imperative `mise use` commands needed.

## Homebrew

`brew bundle --file=homebrew/Brewfile --cleanup` is used, so removing an entry from the Brewfile will uninstall that package on the next run of `install.sh`.
