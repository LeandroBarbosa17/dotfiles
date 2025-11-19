#!/bin/bash

# Define sua cidade ou localização.
CITY="Sao_Goncalo" 
URL="https://wttr.in/${CITY}?format=j1"

# 1. Faz a requisição e extrai os dados
WEATHER_DATA=$(curl -s "$URL")

# Verifica se a requisição foi bem-sucedida
if [ $? -ne 0 ]; then
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

# --- LÓGICA DE ÍCONES (BLOCO DE CASOS EXAUSTIVO) ---
ICON="❓"

case "$DESC_EN" in
    # ------------------- CÉU LIMPO E SOL -------------------
    *"Clear"*|*"Sunny"*) 
        ICON="☀️" 
        ;;

    # ------------------- NUVENS E PARCIALMENTE -------------------
    *"Partly cloudy"*|*"Light cloud"*|*"Moderate cloud"*) 
        ICON="⛅" 
        ;;
    *"Cloudy"*|*"Overcast"*|*"Cloudy conditions"*) 
        ICON="☁️" 
        ;;

    # ------------------- NEBLINA E NÉVOA -------------------
    *"Mist"*|*"Fog"*|*"Haze"*) 
        ICON="🌫️" 
        ;;

    # ------------------- CHUVA LEVE E CHUVISCO -------------------
    *"Patchy rain nearby"*|*"Drizzle"*|*"Light rain"*|*"Patchy light rain"*) 
        ICON="🌧️" 
        ;;
    *"Light rain shower"*|*"Patchy light drizzle"*)
        ICON="🌦️" 
        ;;

    # ------------------- CHUVA MODERADA E FORTE -------------------
    *"Moderate rain"*|*"Heavy rain"*|*"Torrential rain"*) 
        ICON="💦" 
        ;;
    *"Moderate or heavy rain shower"*)
        ICON="☔" 
        ;;
        
    # ------------------- GRANIZO E NEVE LEVE -------------------
    *"Sleet"*|*"Light sleet"*) 
        ICON="🌨️" 
        ;;
    *"Hail"*|*"Light showers of ice pellets"*)
        ICON="🧊" 
        ;;
    *"Patchy light snow"*|*"Light snow"*|*"Moderate snow"*) 
        ICON="❄️" 
        ;;

    # ------------------- NEVE FORTE E CONGELAMENTO -------------------
    *"Heavy snow"*|*"Moderate or heavy snow"*|*"Blizzard"*|*"Blowing snow"*)
        ICON="💨❄️" 
        ;;
    *"Freezing"*|*"Freezing rain"*|*"Heavy freezing rain"*) 
        ICON="🥶" 
        ;;

    # ------------------- TEMPESTADES -------------------
    *"Thunderstorm"*|*"Thunder"*|*"Thundery outbreaks"*) 
        ICON="⛈️" 
        ;;
    *"Patchy light rain with thunder"*|*"Patchy light snow with thunder"*)
        ICON="🌩️" 
        ;;

    # ------------------- CASO PADRÃO (FALLBACK) -------------------
    *) 
        ICON="❓"
        # Se você ainda vir o "?", verifique o log e adicione a string faltante!
        ;;
esac

# --- SAÍDA FINAL ---
echo "$ICON ${TEMP}°C"
