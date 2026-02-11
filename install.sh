#!/bin/bash

set -e

echo ""
echo "===== BOOTSTRAP DOTFILES - ARCH LINUX ====="
echo ""

# --------------------------------------------------
# 1) Atualiza sistema
# --------------------------------------------------
echo "-- Atualizando sistema"
sudo pacman -Syu --noconfirm

# --------------------------------------------------
# 2) Instala dependências básicas
# --------------------------------------------------
echo "-- Instalando dependências base (git, base-devel)"
sudo pacman -S --needed --noconfirm git base-devel

# --------------------------------------------------
# 3) Instala yay se não existir
# --------------------------------------------------
if ! command -v yay >/dev/null 2>&1; then
    echo "-- Instalando yay (AUR helper)"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
else
    echo "-- yay já está instalado"
fi

# --------------------------------------------------
# 4) Instala pacotes do pkglist.txt usando yay
# --------------------------------------------------
echo "-- Instalando pacotes do pkglist.txt via yay"
yay -S --needed --noconfirm - < pkglist.txt

# --------------------------------------------------
# 5) Criando diretórios
# --------------------------------------------------
echo "-- Criando diretórios"
mkdir -p ~/.config
mkdir -p ~/.local

# --------------------------------------------------
# 6) Copiando configurações
# --------------------------------------------------
echo "-- Copiando configs"
cp -r alacritty/ ~/.config/ 2>/dev/null || true
cp -r dunst/ ~/.config/ 2>/dev/null || true
cp -r i3/ ~/.config/
cp -r i3blocks/ ~/.config/
cp -r kitty/ ~/.config/
cp -r picom/ ~/.config/
cp -r fastfetch/ ~/.config/ 2>/dev/null || true
cp -r bin/ ~/.local/ 2>/dev/null || true

# --------------------------------------------------
# 7) Permissões
# --------------------------------------------------
echo "-- Ajustando permissões"
chmod +x ~/.local/bin/* 2>/dev/null || true
chmod +x ~/.config/i3blocks/scripts/* 2>/dev/null || true

# --------------------------------------------------
# 8) Instalando wallpapers
# --------------------------------------------------
echo "-- Instalando wallpapers"
sudo mkdir -p /usr/share/backgrounds
sudo cp -f Wall.png /usr/share/backgrounds/ 2>/dev/null || true
sudo cp -f wall-01.webp /usr/share/backgrounds/ 2>/dev/null || true

echo ""
echo "===== INSTALAÇÃO CONCLUÍDA ====="
echo "Recomendo fazer logout/login ou reiniciar o sistema."
echo ""

