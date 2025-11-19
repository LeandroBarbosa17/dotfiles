#!/bin/bash

# Define sua cidade ou localização.
CITY="Sao_Goncalo" 
URL="https://wttr.in/${CITY}?format=j1"

# 1. Faz a requisição e extrai os dados
WEATHER_DATA=$(curl -s "$URL")

# Verifica se a requisição foi bem-sucedida
if [ $? -ne 0 ]; then
    # Se não houver rede, exibe um ícone simples de erro
    echo "🌐 0°C" 
    exit 0
fi

# Extrai a temperatura e a descrição do clima
TEMP=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].temp_C')
DESC_EN=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherDesc[0].value')

# Verifica se os dados principais foram encontrados
if [ -z "$TEMP" ] || [ -z "$DESC_EN" ]; then
    echo "❓ 0°C"
    exit 0
fi

# --- LÓGICA DE ÍCONES ---
# Se o ícone "?" aparecer, significa que o DESC_EN não foi mapeado e precisa ser adicionado.
ICON="❓"

case "$DESC_EN" in
    # SOL E CÉU LIMPO
    *"Clear"*|*"Sunny"*) 
        ICON="☀️" 
        ;;

    # NUVENS E NEBLINA
    *"Cloudy"*|*"Overcast"*) 
        ICON="☁️" 
        ;;
    *"Partly cloudy"*|*"Light cloud"*|*"Moderate cloud"*) 
        ICON="⛅" 
        ;;
    *"Mist"*|*"Fog"*|*"Haze"*) 
        ICON="🌫️" 
        ;;

    # CHUVA
    *"Drizzle"*|*"Light rain"*) 
        ICON="🌧️" 
        ;;
    *"Rain"*|*"Showers"*) 
        ICON="☔" 
        ;;
    *"Heavy rain"*|*"Torrential rain"*) 
        ICON="💦" 
        ;;

    # NEVE E GRANIZO
    *"Snow"*|*"Sleet"*|*"Freezing"*|*"Ice"*) 
        ICON="❄️" 
        ;;
    *"Hail"*) 
        ICON="🌨️" 
        ;;

    # TEMPESTADES
    *"Thunderstorm"*|*"Thunder"*) 
        ICON="⛈️" 
        ;;
    *"Patchy light drizzle with thunder"*) 
        ICON="🌩️" 
        ;;

    # CASO PADRÃO
    *) 
        ICON="❓"
        # Não exibe o DESCONHECIDO, mas se o "?" aparecer, você sabe que uma string faltou.
        ;;
esac

# --- SAÍDA FINAL ---
# Apenas ÍCONE e TEMPERATURA
echo "$ICON ${TEMP}°C"
