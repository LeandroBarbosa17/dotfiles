#!/bin/bash

# Caminho para o arquivo temporário da imagem (captura de tela)
TMP_BG="/tmp/screen_lock.png"

# 1. Tira uma captura de tela da tela atual
# Se você usa múltiplos monitores, 'scrot' deve capturar todos.
scrot "$TMP_BG"

# 2. Aplica o efeito de desfoque (Blur) na imagem
# O comando "-blur 0x5" é um bom equilíbrio entre performance e efeito.
convert "$TMP_BG" -blur 0x5 "$TMP_BG"

# 3. Bloqueia a tela usando o 'i3lock' (versão colorida) com a imagem e o texto
# O comando 'i3lock' é o correto no seu sistema.
# Parâmetros de texto e cores:
i3lock -i "$TMP_BG" \
    --greeter-text="Digite sua senha" \
    --greeter-color=FFFFFFFF \
    --inside-color=00000020 \
    --ring-color=ffffff60 \
    --line-color=00000000 \
    --keyhl-color=88cc22ff \
    --bshl-color=ff0000ff \
    --wrong-text="Senha incorreta!"
