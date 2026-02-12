# 🧊 Arch Linux i3 Rice — Catppuccin Mocha

A minimal and performance-focused setup based on **Arch Linux + i3wm**, fully themed with **Catppuccin Mocha**.

Lightweight, fast, and fully controlled through dotfiles.

---

## ✨ Stack

- 🪟 WM: i3  
- 🖥 Terminal: kitty  
- 🎨 Shell: zsh  
- 🚀 Prompt: starship (Catppuccin theme)  
- 🧊 Theme: Catppuccin Mocha  
- 🖱 Cursor: Catppuccin  
- 🔲 Compositor: picom (GLX backend + smooth animations)  
- 📊 Status Bar: i3blocks  
- 🧾 System Info: fastfetch (custom configuration)  
- 🔔 Notifications: dunst  
- 📦 AUR Helper: yay  

---

## 📂 Repository Structure

```
.
├── i3/
├── i3blocks/
├── kitty/
├── picom/
├── fastfetch/
├── dunst/
├── bin/
├── pkglist.txt
└── install.sh
```

---

## 🚀 Installation

On a fresh **Arch Linux** installation:

```bash
git clone https://github.com/LeandroBarbosa17/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

The script will:

- Update the system
- Install `git` and `base-devel`
- Install `yay`
- Install all packages listed in `pkglist.txt`
- Copy configuration files to `~/.config`
- Apply necessary permissions

A reboot or re-login is recommended after installation.

---

## 📦 Manual Installation (Alternative)

If you already have `yay` installed:

```bash
yay -S --needed - < pkglist.txt
```

Then manually copy the configuration directories to `~/.config`.

---

## 🎨 Visual Features

- Global Catppuccin Mocha theme  
- Kitty with visual indication for valid/invalid commands  
- Smooth window animations using picom (GLX backend)  
- Custom fastfetch layout with Mauve accent  
- Catppuccin cursor applied via lxappearance  

---

## 🔧 Customization

Main configuration files:

- `~/.config/i3/config` → keybindings and WM behavior  
- `~/.config/picom/picom.conf` → animations and shadows  
- `~/.config/kitty/kitty.conf` → terminal behavior and colors  
- `~/.config/fastfetch/config.jsonc` → system fetch layout  

---

## 🎯 Philosophy

This setup prioritizes:

- Performance  
- Simplicity  
- Full environment control  
- Visual consistency  

No heavy frameworks.  
No unnecessary abstraction.  
Everything is explicitly configured.

---

## 📸 Preview

Screenshots will be added soon.

---

## 📜 License

Personal use project. Feel free to adapt and modify.
