#!/bin/bash
# weather_owm.sh - Usa OpenWeatherMap com coordenadas geográficas

# --- CONFIGURAÇÃO ---
API_KEY="8b05d62206f459e1d298cbe5844d7d87" # <-- Não se esqueça da sua chave!
# Usamos coordenadas para maior precisão em vez de City ID
LAT="-22.82"
LON="-43.03"
UNITS="metric"              # Temperatura em Celsius
CACHE_FILE="/tmp/owm_weather_cache.json"

# URL agora usa latitude e longitude
URL="http://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&units=${UNITS}&lang=pt&appid=${API_KEY}"

# --- EXECUÇÃO E CACHE ---
# Faz uma nova requisição à API apenas se o arquivo de cache tiver mais de 10 minutos.
if [ ! -f "$CACHE_FILE" ] || find "$CACHE_FILE" -mmin +10 | grep -q '.*'; then
    curl -s "$URL" > "$CACHE_FILE"
fi

# 1. TRATAMENTO DE ERROS
if ! grep -q '"cod":200' "$CACHE_FILE"; then
    echo "❗ 0°C (Erro OWM)"
    exit 0
fi

# 2. EXTRAÇÃO DE DADOS
WEATHER_CODE=$(jq -r '.weather[0].id' "$CACHE_FILE")
TEMP=$(jq -r '.main.temp' "$CACHE_FILE" | awk '{printf "%.0f\n", $1}') 

# 3. MAPPING DE ÍCONES (Mantido - Baseado em códigos)
ICON="❓"

case "$WEATHER_CODE" in
    2*) ICON="⛈️" ;; 
    3*) ICON="🌧️" ;; 
    500|501) ICON="☔" ;; 
    5*) ICON="💦" ;; 
    6*) ICON="❄️" ;; 
    701|721|741) ICON="🌫️" ;;
    7*) ICON="💨" ;; 
    800) ICON="☀️" ;; 
    801|802) ICON="⛅" ;; 
    803|804) ICON="☁️" ;; 
    *) ICON="❓" ;;
esac

# --- SAÍDA FINAL ---
echo "$ICON ${TEMP}°C"
