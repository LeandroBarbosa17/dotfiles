sudo pacman -S --needed git && \
git clone https://github.com/LeandroBarbosa17/dotfiles.git ~/dotfiles && \
cd ~/dotfiles && \
mkdir -p ~/.config && \
mkdir -p ~/.local && \
cp -r alacritty/ dunst/ i3/ i3blocks/ ~/.config/ && \
cp -r bin/ ~/.local/ && \
chmod +x ~/.local/bin/* && \
chmod +x ~/.config/i3blocks/scripts/* && \
sudo mkdir -p /usr/share/backgrounds && \
sudo cp -r Downloads/wall-01.webp Downloads/Wall.png /usr/share/backgrounds/ 

DEPENDENCIES:

sudo pacman -S --needed base-devel git

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

yay -S --needed - < ~/dotfiles/pkglist.txt

#If you want to install only official packages:#

sudo pacman -S --needed - < ~/dotfiles/pkglist.txt
