
## API
https://openweathermap.org/api/current?collection=current_forecast#one


图标具体：https://openweathermap.org/payload/api/media/file/10d.png

### JSON format API response fields

- `coord`
- - `coord.lon` Longitude of the location
  - `coord.lat` Latitude of the location
- `weather` (more info [Weather condition codes](https://openweathermap.org/weather-conditions))
- - `weather.id` Weather condition id
  - `weather.main` Group of weather parameters (Rain, Snow, Clouds etc.)
  - `weather.description` Weather condition within the group. Please find more [here.](https://openweathermap.org/current#list) You can get the output in your language. [Learn more](https://openweathermap.org/current#multi)
  - `weather.icon` Weather icon id
- `base` Internal parameter
- `main`
- - `main.temp` Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  - `main.feels_like` Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  - `main.pressure` Atmospheric pressure on the sea level, hPa
  - `main.humidity` Humidity, %
  - `main.temp_min` Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Please find more info [here.](https://openweathermap.org/current#min) Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  - `main.temp_max` Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Please find more info [here.](https://openweathermap.org/current#min) Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit
  - `main.sea_level` Atmospheric pressure on the sea level, hPa
  - `main.grnd_level` Atmospheric pressure on the ground level, hPa
- `visibility` Visibility, meter. The maximum value of the visibility is 10 km
- `wind`
- - `wind.speed` Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
  - `wind.deg` Wind direction, degrees (meteorological)
  - `wind.gust` Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
- `clouds`
- - `clouds.all` Cloudiness, %
- `rain`
- - `1h`(where available)Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
- `snow`
- - `1h`(where available) Precipitation, mm/h. Please note that only mm/h as units of measurement are available for this parameter
- `dt` Time of data calculation, unix, UTC
- `sys`
- - `sys.type` Internal parameter
  - `sys.id` Internal parameter
  - `sys.message` Internal parameter
  - `sys.country` Country code (GB, JP etc.)
  - `sys.sunrise` Sunrise time, unix, UTC
  - `sys.sunset` Sunset time, unix, UTC
- `timezone` Shift in seconds from UTC
- `id` City ID. Please note that built-in geocoder functionality has been deprecated. Learn more [here](https://openweathermap.org/current#builtin)
- `name` City name. Please note that built-in geocoder functionality has been deprecated. Learn more [here](https://openweathermap.org/current#builtin)
- `cod` Internal parameter

### 示例调用
```shell
# units=Metrics使用摄氏度，默认是Standard为开文温度
$ curl https://api.openweathermap.org/data/2.5/weather?lat纬度&lon=经度&appid=xxx&units=Metric&lang=zh_cn
{"coord":{"lon":xx,"lat":xx},"weather":[{"id":802,"main":"Clouds","description":"多云","icon":"03d"}],"base":"stations","main":{"temp":31.25,"feels_like":38.25,"temp_min":31.25,"temp_max":31.45,"pressure":1005,"humidity":78,"sea_level":1005,"grnd_level":996},"visibility":10000,"wind":{"speed":4.37,"deg":189,"gust":4.55},"clouds":{"all":31},"dt":1783577146,"sys":{"type":2,"id":2031340,"country":"CN","sunrise":1783547117,"sunset":1783595539},"timezone":28800,"id":1802620,"name":"Longhua","cod":200}
```

## Units in API response

### API response parameters with available units of measurement

Table below contains paramers, their description and units of measure for `standard`, `imperial` and `metric` systems of measurement.

Please note, that parameter names and their descriptions and data format of API responce may slightly differ from products documentation, but have the same physical meaning.

| Parameter                 | Description                                                  | Standard               | Metric                 | Imperial               |
| ------------------------- | ------------------------------------------------------------ | ---------------------- | ---------------------- | ---------------------- |
| `dt`                      | Data                                                         | unix, UTC              | unix, UTC              | unix, UTC              |
| `start`                   | Date and time of the start                                   | unix, UTC              | unix, UTC              | unix, UTC              |
| `end`                     | Date and time of the end                                     | unix, UTC              | unix, UTC              | unix, UTC              |
| `timezone`                | Shift in seconds from UTC                                    | unix, UTC              | unix, UTC              | unix, UTC              |
| `sunrise`                 | Sunrise time                                                 | unix, UTC              | unix, UTC              | unix, UTC              |
| `sunset`                  | Sunset time                                                  | unix, UTC              | unix, UTC              | unix, UTC              |
| `lat`                     | Latitude                                                     | -                      | -                      | -                      |
| `lon`                     | Longitude                                                    | -                      | -                      | -                      |
| `temp`                    | Temperature                                                  | Kelvin                 | Celsius                | Fahrenheit             |
| `temp`                    | Accumulated indicator (only for Accumulated parameters)      | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_min`                | Minimum temperature                                          | Kelvin                 | Celsius                | Fahrenheit             |
| `temp_max`                | Maximum temperature                                          | Kelvin                 | Celsius                | Fahrenheit             |
| `temp.day`                | Temperature at 12:00 local time                              | Kelvin                 | Celsius                | Fahrenheit             |
| `temp.night`              | Temperature at 00:00 local time                              | Kelvin                 | Celsius                | Fahrenheit             |
| `temp.eve`                | Temperature at 18:00 local time                              | Kelvin                 | Celsius                | Fahrenheit             |
| `temp.morn`               | Temperature at 06:00 local time                              | Kelvin                 | Celsius                | Fahrenheit             |
| `feels_like`              | Temperature in account with the human perception of weather  | Kelvin                 | Celsius                | Fahrenheit             |
| `feels_like.day`          | Temperature at 12:00 local time in account with the human perception of weather | Kelvin                 | Celsius                | Fahrenheit             |
| `feels_like.night`        | Temperature at 00:00 local time in account with the human perception of weather | Kelvin                 | Celsius                | Fahrenheit             |
| `feels_like.eve`          | Temperature at 18:00 local time in account with the human perception of weather | Kelvin                 | Celsius                | Fahrenheit             |
| `feels_like.morn`         | Temperature at 06:00 local time in account with the human perception of weather | Kelvin                 | Celsius                | Fahrenheit             |
| `road.temp`               | Road surface temperature                                     | Kelvin                 | Celsius                | Fahrenheit             |
| `temp_record_min`         | Absolute temperature minimum based on all historical measurements | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_record_max`         | Absolute temperature maximum based on all historical measurements | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_average_min`        | Average of all minimum temperature values                    | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_average_max`        | Average of all maximum temperature values for this day       | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_median`             | The median value of the temperature                          | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_mean`               | Average of all temperature measurements                      | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_p25`                | The first quartile of the temperature                        | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_p75`                | The third quartile of the temperature                        | Kelvin                 | Kelvin                 | Kelvin                 |
| `temp_st_dev`             | The standard deviation of the temperature                    | Kelvin                 | Kelvin                 | Kelvin                 |
| `pressure`                | Atmospheric pressure                                         | hPa                    | hPa                    | hPa                    |
| `sea_level`               | Atmospheric pressure on the sea level                        | hPa                    | hPa                    | hPa                    |
| `grnd_level`              | Atmospheric pressure on the ground level                     | hPa                    | hPa                    | hPa                    |
| `pressure_min`            | Absolute pressure minimum based on all historical measurements | hPa                    | hPa                    | hPa                    |
| `pressure_max`            | Absolute pressure maximum based on all historical measurements | hPa                    | hPa                    | hPa                    |
| `pressure_median`         | The median value of the pressure                             | hPa                    | hPa                    | hPa                    |
| `pressure_mean`           | Average of all pressure measurements                         | hPa                    | hPa                    | hPa                    |
| `pressure_p25`            | The first quartile of the pressure                           | hPa                    | hPa                    | hPa                    |
| `pressure_p75`            | The third quartile of the pressure                           | hPa                    | hPa                    | hPa                    |
| `pressure_st_dev`         | The standard deviation of the pressure                       | hPa                    | hPa                    | hPa                    |
| `humidity`                | Humidity                                                     | %                      | %                      | %                      |
| `humidity_min`            | Absolute humidity minimum based on all historical measurements | %                      | %                      | %                      |
| `humidity_max`            | Absolute humidity maximum based on all historical measurements | %                      | %                      | %                      |
| `humidity_median`         | The median value of the humidity                             | %                      | %                      | %                      |
| `humidity_mean`           | Average of all humidity measurements                         | %                      | %                      | %                      |
| `humidity_p25`            | The first quartile of the humidity                           | %                      | %                      | %                      |
| `pressure_p75`            | The third quartile of the humidity                           | %                      | %                      | %                      |
| `humidity_st_dev`         | The standard deviation of the humidity                       | %                      | %                      | %                      |
| `visibility`              | Visibility                                                   | m                      | m                      | m                      |
| `speed`                   | Wind speed                                                   | meter/sec              | meter/sec              | miles/hour             |
| `deg`                     | Wind direction                                               | meteorological degrees | meteorological degrees | meteorological degrees |
| `gust`                    | Wind gust                                                    | meter/sec              | meter/sec              | miles/hour             |
| `wind_min`                | Absolute wind speed minimum based on all historical measurements | meter/sec              | meter/sec              | meter/sec              |
| `wind_max`                | Absolute wind speed maximum based on all historical measurements | meter/sec              | meter/sec              | meter/sec              |
| `wind_median`             | The median value of the wind speed                           | meter/sec              | meter/sec              | meter/sec              |
| `wind_mean`               | Average of all wind speed measurements                       | meter/sec              | meter/sec              | meter/sec              |
| `wind_p25`                | The first quartile of the wind speed                         | meter/sec              | meter/sec              | meter/sec              |
| `wind_p75`                | The third quartile of the wind speed                         | meter/sec              | meter/sec              | meter/sec              |
| `wind_st_dev`             | The standard deviation of the wind speed                     | meter/sec              | meter/sec              | meter/sec              |
| `clouds`                  | Cloudiness                                                   | %                      | %                      | %                      |
| `rain`                    | Precipitation volume                                         | mm                     | mm                     | mm                     |
| `rain`                    | Precipitation accumulation indicator (only for Accumulated parameters) | mm                     | mm                     | mm                     |
| `rain.1h`                 | Rain volume for last hour                                    | mm                     | mm                     | mm                     |
| `rain.1h`                 | Precipitation (only for One Call 3.0)                        | mm/h                   | mm/h                   | mm/h                   |
| `rain.3h`                 | Rain volume for last 3 hours                                 | mm                     | mm                     | mm                     |
| `snow`                    | Precipitation volume                                         | mm                     | mm                     | mm                     |
| `snow.1h`                 | Snow volume for last hour                                    | mm                     | mm                     | mm                     |
| `snow.1h`                 | Precipitation (only for One Call 3.0)                        | mm/h                   | mm/h                   | mm/h                   |
| `snow.3h`                 | Snow volume for last 3 hours                                 | mm                     | mm                     | mm                     |
| `pop`                     | Probability of precipitation                                 | %                      | %                      | %                      |
| `precipitation`           | Precipitation (only for One Call 3.0 minutely section)       | mm/hour                | mm/hour                | mm/hour                |
| `precipitation`           | Precipitation volume                                         | mm                     | mm                     | mm                     |
| `precipitation_intensity` | Intensity of precipitation                                   | mm/hour                | mm/hour                | mm/hour                |
| `precipitation.snow`      | Snow water equivalent                                        | mm                     | mm                     | mm                     |
| `precipitation.rate`      | Intensity of precipitation                                   | mm/s                   | mm/s                   | mm/s                   |
| `precipitation.fr_rain`   | Freezing rain                                                | mm                     | mm                     | mm                     |
| `precipitation.ice`       | Ice pellets                                                  | mm                     | mm                     | mm                     |
| `convective`              | Convective precipitation                                     | mm                     | mm                     | mm                     |
| `accumulated`             | Accumulated volume of precipitation                          | mm                     | mm                     | mm                     |
| `precipitation_min`       | Absolute precipitation volume minimum based on all historical measurements | mm                     | mm                     | mm                     |
| `precipitation_max`       | Absolute precipitation volume maximum based on all historical measurements | mm                     | mm                     | mm                     |
| `precipitation_median`    | The median value of the precipitation volume                 | mm                     | mm                     | mm                     |
| `precipitation_mean`      | Average of all precipitation volume measurements             | mm                     | mm                     | mm                     |
| `precipitation_p25`       | The first quartile of the precipitation volume               | mm                     | mm                     | mm                     |
| `precipitation_p75`       | The third quartile of the precipitation volume               | mm                     | mm                     | mm                     |
| `precipitation_st_dev`    | The standard deviation of the precipitation volume           | mm                     | mm                     | mm                     |
| `dew_point`               | Temperature of dew point                                     | Kelvin                 | Celsius                | Fahrenheit             |
| `snow_deep`               | Depth of snow                                                | cm                     | cm                     | cm                     |
| `uvi`                     | UVI index                                                    | W/m2                   | W/m2                   | W/m2                   |
| `radiation.ghi_cs`        | Global Horizontal Irradiance                                 | W/m2                   | W/m2                   | W/m2                   |
| `radiation.dni_cs`        | Direct Normal Irradiance                                     | W/m2                   | W/m2                   | W/m2                   |
| `radiation.dhi_cs`        | Diffuse Horizontal Irradiance                                | W/m2                   | W/m2                   | W/m2                   |
| `components.co`           | Сoncentration of CO                                          | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.no`           | Сoncentration of NO                                          | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.no2`          | Сoncentration of NO2                                         | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.o3`           | Сoncentration of O3                                          | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.so2`          | Сoncentration of SO2                                         | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.pm2_5`        | Сoncentration of PM2.5                                       | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.pm10`         | Сoncentration of PM10                                        | μg/m3                  | μg/m3                  | μg/m3                  |
| `components.nh3`          | Сoncentration of NH3                                         | μg/m3                  | μg/m3                  | μg/m3                  |