## dralee customer tools and configs
### weather
the weather tool for waybar & hyprland

### need for environment
```bash
# read key for env $OPEN_WEATHER_KEY
# lat: $OPEN_WEATHER_LAT
# lon: $OPEN_WEATHER_LON

# eg:
OPEN_WEATHER_KEY=2222212134123432xx
OPEN_WEATHER_LAT=22.xxx
OPEN_WEATHER_LON=114.xxx
```

#### use the weather
* for help
```bash
$ ~/.config/xxx/weather/weather.sh -h
```
* for waybar
```bash
$ ~/.config/xxx/weather/weather.sh -w
```
* for hyprlock
```bash
~/.config/xxx/weather/weather.sh -i temp,...
```
