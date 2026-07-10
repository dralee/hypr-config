#!/bin/bash
# weather api call for waybar and others
# 2026.7.9~10 by dralee

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

# field name
W_ICON="icon"
W_STATUS="status"
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
W_LOCATION="location"

# field name for json property
declare -A KEY_PROPS
KEY_PROPS[$W_ICON]=".weather.[].icon"
KEY_PROPS[$W_STATUS]=".weather.[].description"
KEY_PROPS[$W_TEMPRETURE]=".main.temp"
KEY_PROPS[$W_TEMPRETURE_MIN]=".main.temp_min"
KEY_PROPS[$W_TEMPRETURE_MAX]=".main.temp_max"
KEY_PROPS[$W_FEELS_LIKE]=".main.feels_like"
KEY_PROPS[$W_PRESURE]=".main.pressure"
KEY_PROPS[$W_HUMIDITY]=".main.humidity"
KEY_PROPS[$W_SEA_LEVEL]=".main.sea_level"
KEY_PROPS[$W_GRND_LEVEL]=".main.grnd_level"
KEY_PROPS[$W_VISIBILITY]=".visibility"
KEY_PROPS[$W_WIND_SPEED]=".wind.speed"
KEY_PROPS[$W_WIND_DEG]=".wind.deg"
KEY_PROPS[$W_WIND_GUST]=".wind.gust"
KEY_PROPS[$W_CLOUDS]=".clouds.all"
KEY_PROPS[$W_LOCATION]=".name"

# field name for units
declare -A KEY_UNITS
KEY_UNITS[$W_TEMPRETURE]="°C"
KEY_UNITS[$W_TEMPRETURE_MIN]="°C"
KEY_UNITS[$W_TEMPRETURE_MAX]="°C"
KEY_UNITS[$W_FEELS_LIKE]="°C"
KEY_UNITS[$W_PRESURE]="hPa"
KEY_UNITS[$W_HUMIDITY]="%"
KEY_UNITS[$W_SEA_LEVEL]="hPa"
KEY_UNITS[$W_GRND_LEVEL]="hPa"
KEY_UNITS[$W_VISIBILITY]="m"
KEY_UNITS[$W_WIND_SPEED]="m/s"
KEY_UNITS[$W_WIND_GUST]="m/s"
KEY_UNITS[$W_CLOUDS]="%"

# field name with logo icon
declare -A KEY_LOGO_ICONS
KEY_LOGO_ICONS[$W_TEMPRETURE]="temp" # get the icon ICONS
KEY_LOGO_ICONS[$W_TEMPRETURE_MIN]="" # nf-md-thermometer_minus
KEY_LOGO_ICONS[$W_TEMPRETURE_MAX]="" # nf-md-thermometer_plus
KEY_LOGO_ICONS[$W_FEELS_LIKE]="" # nf-md-thermometer_minus
KEY_LOGO_ICONS[$W_PRESURE]="\udb86\udd0a" # get the icon ICONS
KEY_LOGO_ICONS[$W_HUMIDITY]="" # nf-md-water_percent
KEY_LOGO_ICONS[$W_SEA_LEVEL]="" # nf-md-water
KEY_LOGO_ICONS[$W_GRND_LEVEL]="" # nf-md-water
KEY_LOGO_ICONS[$W_VISIBILITY]="" # nf-md-visibility
KEY_LOGO_ICONS[$W_WIND_SPEED]="\ue27e" # get the icon ICONS
KEY_LOGO_ICONS[$W_WIND_DEG]="" # nf-md-weather_windy
KEY_LOGO_ICONS[$W_WIND_GUST]="" # nf-md-weather_windy
KEY_LOGO_ICONS[$W_CLOUDS]="" # nf-md-weather_cloudy

# global constants
EXPIRE_SECONDS=1800 # 30minutes
TIMESTAMP_NAME="timestamp"
DATA_FILE="data.json"

# load the open weathermap data for file and return
# read key for env $OPEN_WEATHER_KEY
# lat: $OPEN_WEATHER_LAT
# lon: $OPEN_WEATHER_LON
function load_weather_data(){
    TIMESTAMP=$(timestamp)  # seconds
    url="https://api.openweathermap.org/data/2.5/weather?lat=$OPEN_WEATHER_LAT&lon=$OPEN_WEATHER_LON&appid=$OPEN_WEATHER_KEY&units=Metric&lang=zh_cn"
    curl -s -f -o $DATA_FILE $url
    if [ $? -ne 0 ]; then
        error "curl get the open weathermap data error: $?"
        exit 1
    else
        sed -i 's/}$/,'\"$TIMESTAMP_NAME\":$TIMESTAMP'}/' $DATA_FILE
        log "get open weathermap data success"
    fi
}

# normal log
function log(){
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> weather.log
}

# error log
function error(){
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> error.log
}

# check if need to update the weather data
function check_weather_data(){
    if [ -f $DATA_FILE ]; then
        TIMESTAMP=$(cat $DATA_FILE | jq .$TIMESTAMP_NAME)
        if [ $? -ne 0 ]; then
            error "[$(date '+%Y-%m-%d %H:%M:%S')] jq parse the timestamp error: $?, just try to reload..."            
            load_weather_data
        fi
        if [ $(($(timestamp) - $TIMESTAMP)) -gt $EXPIRE_SECONDS ]; then
            log "weather data expires to load"
            load_weather_data
        else
            log "weather data not expires"
        fi
    else
        log "weather data for new load"
        load_weather_data
    fi
}

# get the timestamp
function timestamp(){
    echo $(date +%s)
}

# load for json
# read digest downloadurl < <(wget -qO- -t1 -T2 $RELEASE_URL | jq '.[].assets.[] | select(.browser_download_url | test("https://.*mihomo-linux-amd64-v1-alpha.*gz")) | "\(.digest) \(.browser_download_url)"' | sed 's/"//g' | head -n1)
function load_data(){
    # cat $DATA_FILE | jq '{icon:.weather.[].icon,temp:.main.temp,"feels-like":.main.feels_like,"temp-min":.main.temp_min,"temp-max":.main.temp_max,presure:.main.pressure,humidity:.main.humidity,"sea-level":.main.sea_level,"grnd-level":.main.grnd_level,visibility:.visibility,"wind-speed":.wind.speed,"wind-deg":.wind.deg,"wind-gust":.wind.gust,clouds:.clouds.all}'
    # use args by --arg XXX "xxx" '($XXX):.aaa'
    data=$(cat $DATA_FILE | jq --arg W_ICON "$W_ICON" \
    --arg W_STATUS "$W_STATUS" \
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
    --arg W_LOCATION "$W_LOCATION" \
    '{($W_ICON):.weather.[].icon,$(W_STATUS):.weather.[].description),($W_TEMPRETURE):.main.temp,($W_FEELS_LIKE):.main.feels_like,($W_TEMPRETURE_MIN):.main.temp_min,($W_TEMPRETURE_MAX):.main.temp_max,($W_PRESURE):.main.pressure,($W_HUMIDITY):.main.humidity,($W_SEA_LEVEL):.main.sea_level,($W_GRND_LEVEL):.main.grnd_level,($W_VISIBILITY):.visibility,($W_WIND_SPEED):.wind.speed,($W_WIND_DEG):.wind.deg,($W_WIND_GUST):.wind.gust,($W_CLOUDS):.clouds.all,($W_LOCATION):.name}')

    # by grep
    #key=$(echo $data | grep -Po '"icon": *\K"[^"]*"' | sed 's/"//g') # | xargs -I{} echo -n "${ICONS["{}"]}"
    # by jq
    key=$(echo $data | jq -r ".icon")
    #echo "${ICONS[$key]}"
    # replace the icon
    echo $data | sed 's/'"$key"'/'"${ICONS[$key]}"'/g'
}

# get the style class
function waybar_style_class(){
    ICON_NAME=$1
    #echo "icon-$ICON_NAME"
    RES="default"
    echo "$RES"
}

function test(){
    #TIMESTAMP=$(timestamp)
    #sed -i 's/}$/,'\"$TIMESTAMP_NAME\":$TIMESTAMP'}/' $DATA_FILE
    #return
    curl -s -f -o tmp.json "https://qq-web.cdn-go.cn/im.qq.com_new/latest/rainbow/pcConfig.json?t=1783663092924"
    if [ $? -ne 0 ]; then
        error "[$(date '+%Y-%m-%d %H:%M:%S')] curl get the open weathermap data error: $?"
        exit 1
    else
        log "get success"
    fi

}

function waybar_data(){

    check_weather_data
    # tooltip text
    #load_data

    #cat $DATA_FILE | tr -d '\n'
        
    # 使用'\t'进行分隔，防止空格截断
    IFS=$'\t' read -r P_ICON P_STATUS P_TEMPRETURE P_FEELS_LIKE P_TEMPRETURE_MIN P_TEMPRETURE_MAX P_PRESURE P_HUMIDITY \
    P_SEA_LEVEL P_GRND_LEVEL P_VISIBILITY P_WIND_SPEED P_WIND_DEG P_WIND_GUST P_CLOUDS P_LOCATION \
    < <(cat $DATA_FILE | jq -r '.weather.[].icon,.weather.[].description,.main.temp,.main.feels_like,.main.temp_min,.main.temp_max,.main.pressure,.main.humidity,.main.sea_level,.main.grnd_level,.visibility,.wind.speed,.wind.deg,.wind.gust,.clouds.all,.name'|paste -sd '\t')

    #echo ${KEY_LOGO_ICONS[$W_TEMPRETURE_MIN]}, "${KEY_LOGO_ICONS[@]}"
    #echo "$P_ICON, $P_TEMPRETURE, $P_TEMPRETURE_MIN $P_TEMPRETURE_MAX $P_FEELS_LIKE $P_PRESURE $P_HUMIDITY $P_SEA_LEVEL $P_GRND_LEVEL $P_VISIBILITY $P_WIND_SPEED $P_WIND_DEG $P_WIND_GUST $P_CLOUDS $P_LOCATION"
    ICON=${ICONS[$P_ICON]}
    LINE1="<span size=\\\"xx-large\\\">${P_LOCATION}</span>"
    LINE2="<span size=\\\"xx-large\\\">${ICON}\t ${P_TEMPRETURE}${KEY_UNITS[$W_TEMPRETURE]}</span>"
    LINE3="${KEY_LOGO_ICONS[$W_TEMPRETURE_MIN]} <big>${P_TEMPRETURE_MIN}${KEY_UNITS[$W_TEMPRETURE_MIN]}</big>\t\t${KEY_LOGO_ICONS[$W_TEMPRETURE_MAX]} <big>${P_TEMPRETURE_MAX}${KEY_UNITS[$W_TEMPRETURE_MAX]}</big>"
    LINE4="Feels like <big>${P_FEELS_LIKE}${KEY_UNITS[$W_FEELS_LIKE]}</big>"
    LINE5="${KEY_LOGO_ICONS[$W_CLOUDS]} <big>${P_CLOUDS}${KEY_UNITS[$W_CLOUDS]}</big>"
    LINE6="${KEY_LOGO_ICONS[$W_WIND_SPEED]} ${P_WIND_SPEED}${KEY_UNITS[$W_WIND_SPEED]}\t${KEY_LOGO_ICONS[$W_WIND_DEG]} ${P_WIND_DEG}${KEY_UNITS[$W_WIND_DEG]}\t${KEY_LOGO_ICONS[$W_WIND_GUST]} ${P_WIND_GUST}${KEY_UNITS[$W_WIND_GUST]}\t ${KEY_LOGO_ICONS[$W_HUMIDITY]} ${P_HUMIDITY}${KEY_UNITS[$W_HUMIDITY]}"
    LINE7="${KEY_LOGO_ICONS[$W_VISIBILITY]} ${P_VISIBILITY}${KEY_UNITS[$W_VISIBILITY]}"
    LINE8="${KEY_LOGO_ICONS[$W_PRESURE]} ${P_PRESURE}${KEY_UNITS[$W_PRESURE]} \t${KEY_LOGO_ICONS[$W_SEA_LEVEL]} ${P_SEA_LEVEL}${KEY_UNITS[$W_SEA_LEVEL]} \t${KEY_LOGO_ICONS[$W_GRND_LEVEL]} ${P_GRND_LEVEL}${KEY_UNITS[$W_GRND_LEVEL]}"

    tooltip_text="\t\t${LINE1}\t\t\n${LINE2}\n${LINE3}\n${LINE4}\n\n${LINE5}\n${LINE6}\n${LINE7}\n${LINE8}"
    
    class=$(waybar_style_class $P_STATUS)

    #echo $tooltip_text
    # print waybar module data
    out_data="{\"text\": \"${ICON}  ${P_TEMPRETURE}℃\",\"alt\": \"$P_STATUS\",\"tooltip\": \"$tooltip_text\",\"class\": \"$class\"}"
    echo $out_data
    exit 0
}

# get the weather data item
# icon value unit
function get_item(){
    names=$1

    check_weather_data

    RESULT=''
    for name in $(sed 's/,/ /g' <<< $names); do
        #echo "name: $name"
        KEY=${KEY_PROPS[$name]}
        UNIT=${KEY_UNITS[$name]}
        icon=${KEY_LOGO_ICONS[$name]}
        if [ "$name" == "temp" ]; then
            K=${KEY_PROPS["icon"]}
            i=$(cat $DATA_FILE | jq -r $K)
            icon=${ICONS[$i]}
            #echo "$icon $name $i"
        fi

        VAL=$(cat $DATA_FILE | jq -r $KEY)        
        if [ ! -z "$RESULT" ]; then
            RESULT="$RESULT "
        fi
        RESULT="${RESULT}${icon} ${VAL}${UNIT}"
    done
    #echo -e "$icon $VAL${UNIT}"
    echo "$RESULT"
    #exit 0
}

function get_args(){
    while getopts "i:wh" opt; do
        case $opt in
            w)
                waybar_data
                ;;
            i)
                #echo "$OPTARG"
                get_item $OPTARG
                ;;
            h)
                menu
                ;;
            *)
                echo "Invalid option: -$OPTARG" >&2
                exit 1
                ;;
        esac
    done
}

function menu(){
    echo "================================================================================"
    echo " GET OPEN WEATHER MAP DATA "
    echo " -w: get the weather data for waybar"
    echo " -i: get the weather data item by one field,multiple field separated by \",\", "
    echo "   eg: -i temp,visibility"
    echo "   the supported field: $W_ICON, $W_STATUS, $W_TEMPRETURE, $W_TEMPRETURE_MIN, "
    echo "   $W_TEMPRETURE_MAX, $W_FEELS_LIKE, $W_PRESURE, $W_HUMIDITY, $W_SEA_LEVEL, $W_GRND_LEVEL, "
    echo "   $W_VISIBILITY, $W_WIND_SPEED, $W_WIND_DEG, $W_WIND_GUST, $W_CLOUDS, $W_LOCATION"
    echo " -h: print this help message"
    echo "================================================================================"
    exit 0
}

#load_data
#waybar_data
#check_weather_data
#test
#menu
get_args "$*"
