sudo pacman -S --needed git && \
git clone https://github.com/LeandroBarbosa17/dotfiles.git ~/dotfiles && \
cd ~/dotfiles && \
mkdir -p ~/.config ~/.local/bin && \
cp -r .config/i3 .config/i3blocks .config/rofi .config/dunst ~/.config/ && \
cp -r .local/bin/* ~/.local/bin/ && \
chmod +x ~/.local/bin/*

DEPENDENCIES:
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --needed - < ~/dotfiles/pkglist.txt

*If you want to install only official packages*
sudo pacman -S --needed - < ~/dotfiles/pkglist.txt
