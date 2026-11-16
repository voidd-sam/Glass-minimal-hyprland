#!/bin/bash
# install.sh — installs packages from packages/*.txt and copies configs
set -e

# Never run as root: makepkg refuses, and $HOME would be /root
if [ "$(id -u)" -eq 0 ]; then
  echo "Run this script as your normal user, not root. It asks for sudo when needed."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PKG_DIR="$SCRIPT_DIR/packages"

# read a package list: ignore blank lines and # comments
read_pkgs() {
  grep -vE '^[[:space:]]*(#|$)' "$1" | awk '{print $1}'
}

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
  mapfile -t PACMAN_PKGS < <(read_pkgs "$PKG_DIR/pacman.txt")
  if [ "${#PACMAN_PKGS[@]}" -gt 0 ]; then
    sudo pacman -S --needed "${PACMAN_PKGS[@]}"
  fi
fi

# 4. Install AUR packages
if [ -f "$PKG_DIR/aur.txt" ]; then
  echo "==> Installing AUR packages..."
  mapfile -t AUR_PKGS < <(read_pkgs "$PKG_DIR/aur.txt")
  if [ "${#AUR_PKGS[@]}" -gt 0 ]; then
    yay -S --needed "${AUR_PKGS[@]}"
  fi
fi

# 4b. Bluetooth service (bluetui shows no adapter without it)
if systemctl cat bluetooth.service &>/dev/null; then
  echo "==> Enabling Bluetooth..."
  sudo systemctl enable --now bluetooth.service || echo "!! Could not enable bluetooth.service"
fi

# 5. Back up only the configs this repo replaces (other apps in ~/.config are left alone)
mkdir -p "$HOME/.config"
BACKUP="$HOME/.config.bak.$(date +%s)"
shopt -s nullglob dotglob
for item in "$SCRIPT_DIR/.config"/*; do
  name="$(basename "$item")"
  if [ -e "$HOME/.config/$name" ]; then
    mkdir -p "$BACKUP"
    mv "$HOME/.config/$name" "$BACKUP/$name"
  fi
done
if [ -f "$SCRIPT_DIR/starship.toml" ] && [ -f "$HOME/.config/starship.toml" ]; then
  mkdir -p "$BACKUP"
  mv "$HOME/.config/starship.toml" "$BACKUP/starship.toml"
fi
shopt -u nullglob dotglob
if [ -d "$BACKUP" ]; then
  echo "==> Old configs saved to $BACKUP"
fi

# 6. Copy configs into place
echo "==> Copying configs..."
cp -r "$SCRIPT_DIR/.config/." "$HOME/.config/"

# starship.toml (lives at repo root)
if [ -f "$SCRIPT_DIR/starship.toml" ]; then
  cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
fi

# shell config (lives at repo root, goes to ~/), the old one is backed up first
for f in .zshrc; do
  if [ -f "$SCRIPT_DIR/$f" ]; then
    [ -f "$HOME/$f" ] && cp "$HOME/$f" "$HOME/$f.bak.$(date +%s)"
    cp "$SCRIPT_DIR/$f" "$HOME/$f"
  fi
done

# Copy wallpapers to ~/WALLPAPERS/
if [ -d "$SCRIPT_DIR/WALLPAPERS" ]; then
  echo "==> Copying wallpapers..."
  mkdir -p "$HOME/WALLPAPERS"
  cp -r "$SCRIPT_DIR/WALLPAPERS/." "$HOME/WALLPAPERS/"
fi

# Screenshots are saved here
mkdir -p "$HOME/Pictures"

# 7. File picker: install the edited yazi wrapper (opens yazi in a floating window)
WRAPPER="$HOME/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh"
PORTAL_DIR="/usr/share/xdg-desktop-portal-termfilechooser"
if [ -f "$WRAPPER" ]; then
  chmod +x "$WRAPPER"
  if [ -d "$PORTAL_DIR" ]; then
    echo "==> Installing file picker wrapper..."
    sudo install -m755 "$WRAPPER" "$PORTAL_DIR/yazi-wrapper.sh" ||
      echo "!! Could not install the wrapper. Run it by hand, see README."
  else
    echo "!! $PORTAL_DIR not found (portal package missing?). Skipping wrapper."
  fi
fi

# 8. Generate the first color palette (Waybar, Rofi, Kitty, Neovim and Hyprlock read it)
echo "==> Generating first color palette..."
FIRST_WALL="$(find "$HOME/WALLPAPERS" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null | head -n1)"
if [ -n "$FIRST_WALL" ]; then
  mkdir -p "$HOME/.cache"
  magick "$FIRST_WALL" -resize 704x760^ -gravity center -extent 704x760 "$HOME/.cache/rofi-wall.png" || true
  wal -q -n -i "$FIRST_WALL" --contrast 1 || true
fi
mkdir -p "$HOME/.config/waybar"
ln -sf "$HOME/.cache/wal/colors-waybar.css" "$HOME/.config/waybar/colors.css"

# 9. Make zsh the login shell (the Hyprland autostart lives in .zshrc)
ZSH_PATH="$(command -v zsh || true)"
if [ -n "$ZSH_PATH" ] && [ "$(basename "${SHELL:-}")" != "zsh" ]; then
  echo "==> Setting zsh as your login shell..."
  chsh -s "$ZSH_PATH" || echo "!! chsh failed. Run: chsh -s $ZSH_PATH"
fi

# 10. Rebuild font cache (or icons show as tofu)
echo "==> Rebuilding font cache..."
fc-cache -fv >/dev/null 2>&1 || true

echo ""
echo "✓ Done."
echo "  Replaced configs were moved to ~/.config.bak.<timestamp> (if any existed)."
echo "  Optional apps and drivers are listed in packages/extras.txt (not installed)."
echo "  Log out, then log in on tty1 to start Hyprland."
echo "  If Hyprland fails to start, press Ctrl+Alt+F2 for a text login and fix it from there."
