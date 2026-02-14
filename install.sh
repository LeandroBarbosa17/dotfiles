#!/bin/bash

set -e

echo ""
echo "===== ARCH LINUX DOTFILES BOOTSTRAP ====="
echo ""

# --------------------------------------------------
# 1) Update system
# --------------------------------------------------
echo "-- Updating system"
sudo pacman -Syu --noconfirm

# --------------------------------------------------
# 2) Install base dependencies
# --------------------------------------------------
echo "-- Installing base dependencies (git, base-devel)"
sudo pacman -S --needed --noconfirm git base-devel

# --------------------------------------------------
# 3) Install yay if not present
# --------------------------------------------------
if ! command -v yay >/dev/null 2>&1; then
    echo "-- Installing yay (AUR helper)"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
else
    echo "-- yay already installed"
fi

# --------------------------------------------------
# 4) Install packages from pkglist.txt using yay
# --------------------------------------------------
echo "-- Installing packages from pkglist.txt"
yay -S --needed  - < pkglist.txt

# --------------------------------------------------
# 5) Set zsh as default shell (if installed)
# --------------------------------------------------
if command -v zsh >/dev/null 2>&1; then
    ZSH_PATH="$(which zsh)"
    if [ "$SHELL" != "$ZSH_PATH" ]; then
        echo "-- Setting zsh as default shell"
        chsh -s "$ZSH_PATH"
        echo "Zsh set as default. Re-login required."
    else
        echo "-- Zsh already set as default shell"
    fi
fi

# --------------------------------------------------
# 6) Create directories
# --------------------------------------------------
echo "-- Creating directories"
mkdir -p ~/.config
mkdir -p ~/.local

# --------------------------------------------------
# 7) Copy configuration files
# --------------------------------------------------
echo "-- Copying configuration files"

cp -r i3/ ~/.config/
cp -r i3blocks/ ~/.config/
cp -r kitty/ ~/.config/
cp -r picom/ ~/.config/
cp -r helix/ ~/.config/
cp -r fastfetch/ ~/.config/
cp -r dunst/ ~/.config/ 2>/dev/null || true
cp -r alacritty/ ~/.config/ 2>/dev/null || true
cp starship.toml ~/.config/ 2>/dev/null || true
cp .zshrc ~/ 2>/dev/null || true
cp -r bin/ ~/.local/ 2>/dev/null || true

# --------------------------------------------------
# 8) Set permissions
# --------------------------------------------------
echo "-- Setting permissions"
chmod +x ~/.local/bin/* 2>/dev/null || true
chmod +x ~/.config/i3blocks/scripts/* 2>/dev/null || true

# --------------------------------------------------
# 9) Install wallpapers
# --------------------------------------------------
echo "-- Installing wallpapers"
sudo mkdir -p /usr/share/backgrounds
sudo cp -f Wall.png /usr/share/backgrounds/ 2>/dev/null || true
sudo cp -f wall-01.webp /usr/share/backgrounds/ 2>/dev/null || true

echo ""
echo "===== INSTALLATION COMPLETE ====="
echo "Please log out and log back in (or reboot) to apply all changes."
echo ""
