#!/bin/bash
# weather_owm.sh - Usa OpenWeatherMap com códigos numéricos

# --- CONFIGURAÇÃO ---
API_KEY="8b05d62206f459e1d298cbe5844d7d87"
CITY_ID="3448439"
UNITS="metric" # Use 'metric' para Celsius
LANG="pt"      # Idioma da descrição (opcional, mas bom para debug)
CACHE_FILE="/tmp/owm_weather_cache.json"

URL="http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&units=${UNITS}&lang=${LANG}&appid=${API_KEY}"

# --- EXECUÇÃO E CACHE (Otimização Rápida) ---

# Se o cache tiver mais de 10 minutos, faça uma nova requisição.
if [ ! -f "$CACHE_FILE" ] || find "$CACHE_FILE" -mmin +10 | grep -q '.*'; then
    curl -s "$URL" > "$CACHE_FILE"
fi

# 1. TRATAMENTO DE ERROS
if ! grep -q '"cod":200' "$CACHE_FILE"; then
    echo "❗ 0°C (OWM Erro)"
    exit 0
fi

# 2. EXTRAÇÃO DE DADOS
# Extrai o código de condição principal (800, 500, etc.) e a temperatura
WEATHER_CODE=$(jq -r '.weather[0].id' "$CACHE_FILE")
TEMP=$(jq -r '.main.temp' "$CACHE_FILE" | awk '{printf "%.0f\n", $1}') # Arredonda a temperatura

# 3. MAPPING DE ÍCONES BASEADO EM CÓDIGOS NUMÉRICOS (Muito mais estável!)
ICON="❓"

# Códigos do OpenWeatherMap:
# 2xx: Tempestade (Thunderstorm)
# 3xx/5xx: Chuva/Chuvisco (Drizzle/Rain)
# 6xx: Neve (Snow)
# 7xx: Atmosfera (Névoa/Neblina)
# 800: Céu Limpo
# 80x: Nuvens
case "$WEATHER_CODE" in
    2*) ICON="⛈️" ;; # Tempestade
    3*|5*) ICON="🌧️" ;; # Chuva/Chuvisco
    6*) ICON="❄️" ;; # Neve
    701|721|741) ICON="🌫️" ;; # Névoa/Neblina
    711|731|751|761|762|771|781) ICON="💨" ;; # Poeira/Fumaça
    800) ICON="☀️" ;; # Céu Limpo
    801|802) ICON="⛅" ;; # Nuvens claras/Poucas Nuvens
    803|804) ICON="☁️" ;; # Nuvens Quebradas/Nublado
    *) ICON="❓" ;;
esac

# --- SAÍDA FINAL ---
echo "$ICON ${TEMP}°C"
