#!/usr/bin/env bash
set -euo pipefail

echo "==> Applying macOS defaults..."

##############################
# FileVault check
##############################
echo "  -> Checking FileVault..."
fdesetup status | grep -q "FileVault is On" || echo "WARNING: FileVault is OFF — enable it in System Settings → Privacy & Security"

##############################
# Appearance
##############################
echo "  -> Appearance..."
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

##############################
# Keyboard & Trackpad
##############################
echo "  -> Keyboard & trackpad..."
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 2.5

##############################
# Dock & Desktop
##############################
echo "  -> Dock & desktop..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock show-recents -bool false       # no suggested/recent apps
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false         # don't auto-rearrange spaces
defaults write com.apple.WindowManager StandardHideWidgets -int 1
defaults write com.apple.WindowManager HideWidgets -int 1
defaults write com.apple.WindowManager StageManagerHideWidgets -int 1
defaults write com.apple.WindowManager StandardHideDesktopIcons -bool true
defaults write com.apple.WindowManager HideDesktop -bool true
defaults write com.apple.WindowManager GloballyEnabled -bool false    # Stage Manager off
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool true

##############################
# Finder
##############################
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

##############################
# Screenshots & Clipboard
##############################
mkdir -p ~/Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.ClipboardHistoryLogging enable -bool true

##############################
# Sharing & Connectivity
##############################
echo "  -> Sharing & connectivity..."
defaults write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool false
defaults write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool false

##############################
# Security & Privacy
##############################
echo "  -> Security & privacy..."
defaults write com.apple.screensaver askForPassword -int 1
defaults -currentHost write com.apple.screensaver idleTime -int 300
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

##############################
# Save & Print Panels
##############################
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

##############################
# Text / Autocorrect / Smart Quotes
##############################
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAllowContinuousSpellChecking -bool false

##############################
# Power & Energy
##############################
sudo pmset -c sleep 0
sudo pmset -c displaysleep 10
sudo pmset -b displaysleep 10

##############################
# Home Folder Cleanup / Work Folders
##############################
# Hide unused home folders (these are in ~, not /System, so chflags works)
chflags hidden ~/Movies ~/Music ~/Public ~/Pictures

# Create work folders
mkdir -p ~/Code ~/Archive

##############################
# TextEdit tweaks
##############################
# Default to plain text
defaults write com.apple.TextEdit RichText -int 0

# Ensure new plain text documents use UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Set monospaced font (Menlo) for plain text
defaults write com.apple.TextEdit NSFixedPitchFont -string "Menlo-Regular"
defaults write com.apple.TextEdit NSFixedPitchFontSize -int 13

##############################
# macOS app cleanup
##############################
echo "  -> Removing unused Apple apps..."
# Note: apps in /System/Applications are SIP-protected and cannot be removed
# or hidden via chflags. Hide unwanted system apps manually in Launchpad (long-press → hide).
REMOVE_APPS=(
  "/Applications/GarageBand.app"
  "/Applications/iMovie.app"
  "/Applications/Pages.app"
  "/Applications/Numbers.app"
  "/Applications/Keynote.app"
)

for app in "${REMOVE_APPS[@]}"; do
  [ -d "$app" ] && sudo rm -rf "$app" && echo "Deleted $app"
done

# Refresh Launch Services
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -r -domain local -domain system -domain user

##############################
# Reload Finder & Dock
##############################
killall Finder || true
killall Dock || true

echo "==> macOS defaults applied."
