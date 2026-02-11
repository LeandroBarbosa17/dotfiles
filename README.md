# 🧊 Arch Linux i3 Rice — Catppuccin Mocha

Setup minimalista baseado em **Arch Linux + i3wm**, com identidade visual **Catppuccin Mocha** aplicada de forma consistente no sistema.

Leve, rápido e totalmente controlado via dotfiles.

---

## ✨ Stack

- 🪟 WM: i3  
- 🖥 Terminal: kitty  
- 🎨 Shell: zsh  
- 🚀 Prompt: starship (Catppuccin)  
- 🧊 Tema: Catppuccin Mocha  
- 🖱 Cursor: Catppuccin  
- 🔲 Compositor: picom (GLX backend + animações suaves)  
- 📊 Barra: i3blocks  
- 🧾 System Info: fastfetch (custom)  
- 🔔 Notificações: dunst  
- 📦 AUR helper: yay  

---

## 📂 Estrutura do Repositório

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

## 🚀 Instalação

Em uma instalação limpa do **Arch Linux**:

```bash
git clone https://github.com/LeandroBarbosa17/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

O script irá:

- Atualizar o sistema
- Instalar `git` e `base-devel`
- Instalar o `yay`
- Instalar todos os pacotes do `pkglist.txt`
- Copiar as configurações para `~/.config`
- Aplicar permissões necessárias

Após a instalação, recomenda-se reiniciar ou relogar.

---

## 📦 Instalação Manual (alternativa)

Caso já tenha o `yay` instalado:

```bash
yay -S --needed - < pkglist.txt
```

Depois copie as configurações manualmente para `~/.config`.

---

## 🎨 Visual

- Tema global: Catppuccin Mocha  
- Kitty com destaque visual para comandos válidos e inválidos  
- Picom com animações suaves usando backend GLX  
- Fastfetch customizado com identidade Mauve  
- Cursor Catppuccin aplicado via lxappearance  

---

## 🔧 Personalização

Arquivos principais para customização:

- `~/.config/i3/config` → atalhos e comportamento do WM  
- `~/.config/picom/picom.conf` → animações, sombras e transições  
- `~/.config/kitty/kitty.conf` → cores e ajustes do terminal  
- `~/.config/fastfetch/config.jsonc` → layout do fetch  

---

## 🎯 Objetivo

Este setup prioriza:

- Performance  
- Simplicidade  
- Controle total do ambiente  
- Coerência visual  

Sem frameworks pesados ou abstrações desnecessárias.

---

## 📸 Preview

Adicione screenshots do seu setup aqui futuramente.

---

## 📜 Licença

Uso pessoal. Sinta-se livre para adaptar.
