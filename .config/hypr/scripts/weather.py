
#!/usr/bin/env python

# https://gist.github.com/Surendrajat/ff3876fd2166dd86fb71180f4e9342d7

"""
2025.1.13 constructed by dralee
"""
from pyquery import PyQuery  # install using `pip install pyquery`
import json
import time
import argparse
from enum import Enum
from os.path import exists

# weather icons
weather_icons = {
    "sunnyDay": "󰖨",
    "clearNight": "",
    "cloudyFoggyDay": "",
    "cloudyFoggyNight": "",
    "rainyDay": "",
    "rainyNight": "",
    "snowyIcyDay": "",
    "snowyIcyNight": "",
    "severe": "",
    "default": "",
}

class WeatherValue(Enum):
    empty = -1
    current = 1  # 当前气温
    range = 2    # 当天气温范围
    humidity = 4 # 当前湿度
    wind = 8     # 当前风力
    pressure = 16 # 当前气压
    visibility = 32 # 当前能见度


class Weather:
    def __init__(self, temp=None, icon=None,status=None,temp_feel_text=None,\
                temp_min_max=None,wind_text=None,pressure_text=None,humidity_text=None,air_quality_index=None,\
                visbility_text=None,prediction=None,status_code=None,timestamp=None):
        self.cache_file = "/tmp/weather.json"
        self.cache_expire_seconds = 600 # 10 minutes
        self.value_type = self.args()
        self.temp = temp
        self.icon = icon
        self.status = status
        self.temp_feel_text = temp_feel_text
        self.temp_min_max = temp_min_max
        self.wind_text = wind_text
        self.pressure_text = pressure_text
        self.humidity_text = humidity_text
        self.air_quality_index = air_quality_index
        self.visbility_text = visbility_text
        self.prediction = prediction
        self.status_code = status_code
        self.timestamp = timestamp

    def dict(self):
        return {
            "temp": self.temp,
            "icon": self.icon,
            "status": self.status,
            "temp_feel_text": self.temp_feel_text,
            "temp_min_max": self.temp_min_max,
            "wind_text": self.wind_text,
            "pressure_text": self.pressure_text,
            "humidity_text": self.humidity_text,
            "air_quality_index": self.air_quality_index,
            "visbility_text": self.visbility_text,
            "prediction": self.prediction,
            "status_code": self.status_code,
            "timestamp": int(time.time())
        }

    def args(self):
        ap = argparse.ArgumentParser()
        ap.add_argument('-c', '--current',help='print the current value',action='store_true')
        ap.add_argument('-r', '--range',help='print the daily range temporature value',action='store_true')
        ap.add_argument('-H', '--humidity',help='print the current humidity value',action='store_true')
        ap.add_argument('-w', '--wind',help='print the current wind value',action='store_true')
        ap.add_argument('-p', '--pressure',help='print the current pressure value',action='store_true')
        ap.add_argument('-v', '--visibility',help='print the current visibility value',action='store_true')

        arg = ap.parse_args()
        value_type = 0
        if arg.current:
            value_type |= WeatherValue.current.value
        if arg.range:
            value_type |= WeatherValue.range.value
        if arg.humidity:
            value_type |= WeatherValue.humidity.value
        if arg.wind:
            value_type |= WeatherValue.wind.value
        if arg.pressure:
            value_type |= WeatherValue.pressure.value
        if arg.visibility:
            value_type |= WeatherValue.visibility.value

        return value_type

    def get_weather(self):
        # get location_id
        # to get your own location_id, go to https://weather.com & search your location.
        # once you choose your location, you can see the location_id in the URL(64 chars long hex string)
        # like this: https://weather.com/en-IN/weather/today/l/c3e96d6cc4965fc54f88296b54449571c4107c73b9638c16aafc83575b4ddf2e
        #location_id = "c3e96d6cc4965fc54f88296b54449571c4107c73b9638c16aafc83575b4ddf2e"  # TODO
        # location_id = "8139363e05edb302e2d8be35101e400084eadcecdfce5507e77d832ac0fa57ae"
        location_id = "4945e1616a82b28a995f412bf561340d96d0d1941d2980e107c9fd4bf73be75e" # Shenzhen

        # priv_env_cmd = 'cat $PRIV_ENV_FILE | grep weather_location | cut -d "=" -f 2'
        # location_id = subprocess.run(
        #     priv_env_cmd, shell=True, capture_output=True).stdout.decode('utf8').strip()

        # get html page
        url = "https://weather.com/en-IN/weather/today/l/" + location_id
        html_data = PyQuery(url=url)

        # current temperature
        self.temp = html_data("span[data-testid='TemperatureValue']").eq(0).text()
        # print(temp)

        # current status phrase
        status = html_data("div[data-testid='wxPhrase']").text()
        self.status = f"{status[:16]}.." if len(status) > 17 else status
        # print(status)

        # status code
        self.status_code = html_data("#regionHeader").attr("class").split(" ")[2].split("-")[2]
        # print(status_code)

        # status icon
        self.icon = (
            weather_icons[self.status_code]
            if self.status_code in weather_icons
            else weather_icons["default"]
        )
        #print(icon)

        # temperature feels like
        temp_feel = html_data(
            "div[data-testid='FeelsLikeSection'] > span > span[data-testid='TemperatureValue']"
        ).text()
        self.temp_feel_text = f"Feels like {temp_feel}c"
        # print(temp_feel_text)

        # min-max temperature
        temp_min = (
            html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
            .eq(1)
            .text()
        )
        temp_max = (
            html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
            .eq(0)
            .text()
        )
        if temp_max == '--':
            temp_max = self.temp
        self.temp_min_max = f" {temp_min} ~  {temp_max}"
        # print(temp_min_max)

        # wind speed
        #wind_speed = html_data("span[data-testid='Wind']").text().split("\n")[1]
        wind_speed = split_value(html_data("span[data-testid='Wind']").text(),"\n",1)
        self.wind_text = f"\ue27e {wind_speed}"
        # print(wind_text)

        # humidity
        humidity = html_data("span[data-testid='PercentageValue']").text()
        self.humidity_text = f"  {humidity}"
        # print(humidity_text)

        # pressure
        pressure_speed = html_data("span[data-testid='PressureValue']").text().split("\n")
        pressure_speed = pressure_speed[1] if len(pressure_speed) > 1 else pressure_speed[0]
        self.pressure_text = f"\udb86\udd0a  {pressure_speed}"
        # print(pressure_text)

        # visibility
        visbility = html_data("span[data-testid='VisibilityValue']").text()
        self.visbility_text = f"  {visbility}"
        # print(visbility_text)

        # air quality index
        self.air_quality_index = html_data("text[data-testid='DonutChartValue']").text()
        # print(air_quality_index)

        # hourly rain prediction
        prediction = html_data("section[aria-label='Hourly Forecast']")(
            "div[data-testid='SegmentPrecipPercentage'] > span"
        ).text()
        prediction = prediction.replace("Chance of Rain", "")
        self.prediction = f"\n\n    (hourly) {prediction}" if len(prediction) > 0 else prediction
        # print(prediction)

        # tooltip text
        # tooltip_text = str.format(
        #     "\t\t{}\t\t\n{}\n{}\n{}\n\n{}\n{}\n{}{}",
        #     f'<span size="xx-large">{temp}</span>',
        #     f"<big>{icon}</big>",
        #     f"<big>{status}</big>",
        #     f"<small>{temp_feel_text}</small>",
        #     f"<big>{temp_min_max}</big>",
        #     f"{wind_text}\t{humidity_text}",
        #     f"{visbility_text}\tAQI {air_quality_index}",
        #     f"<i>{prediction}</i>",
        # )

        # print waybar module data
        # out_data = {
        #     "text": f"{icon}  {temp}",
        #     "alt": status,
        #     "tooltip": tooltip_text,
        #     "class": status_code,
        # }
        #print(json.dumps(out_data))

    def has_value(self, value_type:WeatherValue):
        """是否含有指定类型"""
        return self.value_type & value_type.value == value_type.value

    def result(self):
        res = ''
        if self.has_value(WeatherValue.current):
            res = append(res, f"{self.icon} {self.temp}")
        if self.has_value(WeatherValue.range):
            res = append(res, self.temp_min_max)
        if self.has_value(WeatherValue.humidity):
            res = append(res, self.humidity_text)
        if self.has_value(WeatherValue.wind):
            res = append(res, self.wind_text)
        if self.has_value(WeatherValue.pressure):
            res = append(res, self.pressure_text)
        if self.has_value(WeatherValue.visibility):
            res = append(res, self.visbility_text)

        return res

    def process(self):
        """请求天气数据，返回Weather对象"""
        #print("process...")
        self.get_weather()
        with open(self.cache_file, "w", encoding='utf-8') as f:
            f.write(json.dumps(self.dict()))
        return self

    def read(self):
        """读取缓存或从请求中读取"""
        if(not exists(self.cache_file)):
            return self.process()

        with open(self.cache_file, "r", encoding='utf8') as f:
            weather = json.loads(f.read())
            last_timestamp = int(weather['timestamp'])
            timestamp = int(time.time())
            if (timestamp - last_timestamp) > self.cache_expire_seconds:
                return self.process()

            return Weather(**weather)

def split_value(s_value,splitor='\n',take_index=0):
    """分隔字符串，并只取其中一项
    s_value: 源字符串
    splitor: 分隔符，默认'\n'
    take_index: 结果取第几项
    """
    if s_value is None:
        return ''
    s_value = s_value.strip()
    items = s_value.split(splitor)
    size = len(items)
    if take_index >= size - 1:
        return items[0]
    return items[take_index]

def append(res, s):
    if res != '':
        res += '\t'
    res += s
    return res

def main():
    w = Weather()
    #w.process()
    r = w.read()
    print(r.result())

if __name__ == "__main__":
    main()
