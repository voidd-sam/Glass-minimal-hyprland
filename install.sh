#!/bin/bash
# install.sh — installs all packages from packages/*.txt and copies configs
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PKG_DIR="$SCRIPT_DIR/packages"

# 1. Update system + make sure base tools exist
echo "==> Updating system..."
sudo pacman -Syu --noconfirm --needed base-devel git

# 2. Make sure yay exists (build it from AUR if not)
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay..."
  cd /tmp
  rm -rf yay
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm --needed
  cd "$SCRIPT_DIR"
fi

# 3. Install native packages
if [ -f "$PKG_DIR/pacman.txt" ]; then
  echo "==> Installing native packages..."
  sudo pacman -S --needed - <"$PKG_DIR/pacman.txt"
fi

# 4. Install AUR packages
if [ -f "$PKG_DIR/aur.txt" ]; then
  echo "==> Installing AUR packages..."
  yay -S --needed - <"$PKG_DIR/aur.txt"
fi

# 5. Backup existing ~/.config
if [ -d "$HOME/.config" ]; then
  echo "==> Backing up ~/.config..."
  mv "$HOME/.config" "$HOME/.config.bak.$(date +%s)"
fi

# 6. Copy configs into place
echo "==> Copying configs..."
mkdir -p "$HOME/.config"
cp -r "$SCRIPT_DIR/.config/." "$HOME/.config/"

# starship.toml (lives at repo root)
if [ -f "$SCRIPT_DIR/starship.toml" ]; then
  cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
fi

# shell configs (live at repo root, go to ~/)
if [ -f "$SCRIPT_DIR/.zshrc" ]; then
  cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
fi
if [ -f "$SCRIPT_DIR/.zprofile" ]; then
  cp "$SCRIPT_DIR/.zprofile" "$HOME/.zprofile"
fi

# 7. Rebuild font cache (or icons show as tofu)
echo "==> Rebuilding font cache..."
fc-cache -fv >/dev/null 2>&1 || true

echo ""
echo "✓ Done."
echo "  (Your old configs are at ~/.config.bak.<timestamp>)"
