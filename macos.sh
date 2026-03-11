#!/usr/bin/env bash

echo "Configuring macOS settings..."

# fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# auto-hide dock
defaults write com.apple.dock autohide -bool true

# smaller dock
defaults write com.apple.dock tilesize -int 36

killall Dock || true
