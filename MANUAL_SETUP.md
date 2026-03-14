# Manual Setup

Things that can't be scripted reliably. Work through these after running `install.sh`.

---

## System Settings

### Apple ID
- [ ] **Focus → Share across devices** — turn off

### Displays
- [ ] **Night Shift** — schedule: Sunset to Sunrise, intensity: 40%
- [ ] **Universal Control** — turn off (Advanced button at bottom of Displays settings)

### General → AirDrop & Handoff
- [ ] **AirPlay Receiver** — turn off

### Sound
- [ ] **Alert sound** — set to Crystal

### Control Center
- [ ] **Clock** — show time only (no date, no day)
- [ ] **Battery** — hide from menu bar (still accessible in Control Center)
- [ ] **WiFi** — hide from menu bar (still accessible in Control Center)
- [ ] **Spotlight** — remove from menu bar
- [ ] **Input Sources** — hide from menu bar

### Desktop & Stage Manager
- [ ] **Show items on desktop** — turn off
- [ ] **Widgets → iPhone Widgets** — turn off

### Siri & Spotlight
- [ ] **Help Apple improve search** — turn off
- [ ] **Search Results → Clipboard** — turn on

### Lock Screen
- [ ] **Require password** — set to 1 minute after screen saver begins

### Touch ID & Password
- [ ] Disable TouchID for everything except **Unlocking your Mac** (turn off Apple Pay, App Store, etc.)

### Privacy & Security
- [ ] **FileVault** — enable if not already on (script will warn if off)

---

## Dock
- [ ] Remove all app icons, leave only Finder and Trash (open apps appear automatically)

---

## Desktop
- [ ] Long-press desktop → Edit Widgets → remove all widgets

---

## 1Password
- [ ] Enable SSH agent in 1Password settings
- [ ] Add SSH keys to 1Password
- [ ] Add public key files to `~/.ssh/`
- [ ] Configure `~/.ssh/config` with `IdentityAgent` and per-host `IdentityFile` entries
