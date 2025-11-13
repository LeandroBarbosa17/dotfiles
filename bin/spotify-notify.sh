#!/bin/bash
# Notificações do Spotify com capa do álbum (mantém o tema atual do Dunst)

player="spotify"
last=""

# Diretório temporário para salvar a capa
cover_dir="/tmp/spotify-cover"
mkdir -p "$cover_dir"

while true; do
    # Obtém metadados
    title=$(playerctl --player=$player metadata xesam:title 2>/dev/null)
    artist=$(playerctl --player=$player metadata xesam:artist 2>/dev/null)
    arturl=$(playerctl --player=$player metadata mpris:artUrl 2>/dev/null)

    # Só continua se houver título (ou seja, algo tocando)
    if [[ -n "$title" ]]; then
        current="$title - $artist"

        if [[ "$current" != "$last" ]]; then
            # Extrai URL da capa (Spotify usa "https://i.scdn.co/..." ou "file://")
            if [[ "$arturl" =~ ^file:// ]]; then
                cover="${arturl#file://}"
            elif [[ "$arturl" =~ ^https?:// ]]; then
                cover="$cover_dir/cover.jpg"
                wget -q -O "$cover" "$arturl"
            else
                cover="/usr/share/icons/hicolor/128x128/apps/spotify.png"
            fi

            # Envia notificação
            notify-send -i "$cover" "🎵 Tocando agora" "$title\n$artist"

            last="$current"
        fi
    fi

    sleep 1
done
