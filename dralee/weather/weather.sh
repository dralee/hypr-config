#!/bin/bash
# weather api call
# 2026.7.9 by dralee

declare -A ICONS
# daily
ICONS["01d"]="󰼷" # nf-md-weather_sunny_alert
ICONS["02d"]="󰖕" # nf-md-weather_partly_cloudy
ICONS["03d"]="󰖐" # nf-md-weather_cloudy
ICONS["04d"]="󰼯" # nf-md-weather_cloudy_alert
ICONS["09d"]="󰼳" # nf-md-weather_partly_rainy
ICONS["10d"]="󰖗" # nf-md-weather_rainy
ICONS["11d"]="󰖓" # nf-md-weather_lightning
ICONS["13d"]="󰖘" # nf-md-weather_snowy
ICONS["50d"]="󰖑" # nf-md-weather_fog
# night
ICONS["01n"]="󰼷" # nf-md-weather_sunny_alert
ICONS["02n"]="󰖕" # nf-md-weather_partly_cloudy
ICONS["03n"]="󰖐" # nf-md-weather_cloudy
ICONS["04n"]="󰼯" # nf-md-weather_cloudy_alert
ICONS["09n"]="󰼳" # nf-md-weather_partly_rainy
ICONS["10n"]="󰖗" # nf-md-weather_rainy
ICONS["11n"]="󰖓" # nf-md-weather_lightning
ICONS["13n"]="󰖘" # nf-md-weather_snowy
ICONS["50n"]="󰖑" # nf-md-weather_fog

W_ICON="icon"
W_TEMPRETURE="temp"
W_TEMPRETURE_MIN="temp-min"
W_TEMPRETURE_MAX="temp-max"
W_FEELS_LIKE="feels-like"
W_PRESURE="presure"
W_HUMIDITY="humidity"
W_SEA_LEVEL="sea-level"
W_GRND_LEVEL="grnd-level"
W_VISIBILITY="visibility"
W_WIND_SPEED="wind-speed"
W_WIND_DEG="wind-deg"
W_WIND_GUST="wind-gust"
W_CLOUDS="clouds"

# read digest downloadurl < <(wget -qO- -t1 -T2 $RELEASE_URL | jq '.[].assets.[] | select(.browser_download_url | test("https://.*mihomo-linux-amd64-v1-alpha.*gz")) | "\(.digest) \(.browser_download_url)"' | sed 's/"//g' | head -n1)
function load_data(){
    # cat data.json | jq '{icon:.weather.[].icon,temp:.main.temp,"feels-like":.main.feels_like,"temp-min":.main.temp_min,"temp-max":.main.temp_max,presure:.main.pressure,humidity:.main.humidity,"sea-level":.main.sea_level,"grnd-level":.main.grnd_level,visibility:.visibility,"wind-speed":.wind.speed,"wind-deg":.wind.deg,"wind-gust":.wind.gust,clouds:.clouds.all}'
    # use args by --arg XXX "xxx" '($XXX):.aaa'
    data=$(cat data.json | jq --arg W_ICON "$W_ICON" \
    --arg W_TEMPRETURE "$W_TEMPRETURE" \
    --arg W_TEMPRETURE_MIN "$W_TEMPRETURE_MIN" \
    --arg W_TEMPRETURE_MAX "$W_TEMPRETURE_MAX" \
    --arg W_FEELS_LIKE "$W_FEELS_LIKE" \
    --arg W_PRESURE "$W_PRESURE" \
    --arg W_HUMIDITY "$W_HUMIDITY" \
    --arg W_SEA_LEVEL "$W_SEA_LEVEL" \
    --arg W_GRND_LEVEL "$W_GRND_LEVEL" \
    --arg W_VISIBILITY "$W_VISIBILITY" \
    --arg W_WIND_SPEED "$W_WIND_SPEED" \
    --arg W_WIND_DEG "$W_WIND_DEG" \
    --arg W_WIND_GUST "$W_WIND_GUST" \
    --arg W_CLOUDS "$W_CLOUDS" \
    '{($W_ICON):.weather.[].icon,($W_TEMPRETURE):.main.temp,($W_FEELS_LIKE):.main.feels_like,($W_TEMPRETURE_MIN):.main.temp_min,($W_TEMPRETURE_MAX):.main.temp_max,($W_PRESURE):.main.pressure,($W_HUMIDITY):.main.humidity,($W_SEA_LEVEL):.main.sea_level,($W_GRND_LEVEL):.main.grnd_level,($W_VISIBILITY):.visibility,($W_WIND_SPEED):.wind.speed,($W_WIND_DEG):.wind.deg,($W_WIND_GUST):.wind.gust,($W_CLOUDS):.clouds.all}')

    # by grep
    #key=$(echo $data | grep -Po '"icon": *\K"[^"]*"' | sed 's/"//g') # | xargs -I{} echo -n "${ICONS["{}"]}"
    # by jq
    key=$(echo $data | jq -r ".icon")
    #echo "${ICONS[$key]}"
    # replace the icon
    echo $data | sed 's/'"$key"'/'"${ICONS[$key]}"'/g'
}

load_data