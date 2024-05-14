
#!/usr/bin/env python
# pip install lunar_python
"""
khal luanar calendar
2024.05.13 by dralee
"""
import datetime
import json
from lunar_python import Lunar, Solar, SolarMonth, LunarMonth, SolarWeek
from lunar_python.util import HolidayUtil

class LunarCalendar:
    def __init__(self):
        self.week = {
            0: '周 日', 1: '周 一', 2: '周 二', 3: '周 三', 4: '周 四', 5: '周 五', 6: '周 六'
        }

    def current(self, type):
        """
        type: 0: 2024-05-01
              1: 四月初几
              2: 周几
              3: 节日
        """
        now = datetime.datetime.now()
        #now = datetime.datetime(now.year, now.month, 1, 0, 0, 0)
        day = Solar.fromDate(now)
        week = SolarWeek(now.year, now.month, now.day, 0)
        week.getDay()
        #print(day)
        lunar = day.getLunar()
        #print(lunar, lunar.getMonthInChinese(), lunar.getDayTianShen(), lunar.getDayInChinese())
        #print(day.getFestivals(), day.getOtherFestivals())
        #print(lunar.getFestivals(), lunar.getOtherFestivals(), lunar.getJieQi())
        #holiday = HolidayUtil.getHoliday(day.getYear(), day.getMonth(), day.getDay())
        #print(holiday)
        h = ''
        for f in day.getFestivals():
            h += f + ' '
        for f in lunar.getFestivals():
            h += f + ' '
        #text = "{}（{}）{}月{} {}".format(day, self.__week(day.getWeek()), lunar.getMonthInChinese(), lunar.getDayInChinese(), h)
        if type == 0:
            print(day)
        elif type == 1:
            print("%s月%s" % (lunar.getMonthInChinese(), lunar.getDayInChinese()))
        elif type == 2:
            print(self.__week(day.getWeek()),'    ')
        elif type == 3:
            print(h)
        else:
            print("out of service")
        #print(text)

    def __week(self, w):
        """数字转周几"""        
        return self.week.get(w)

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-t', '--type',help="the text for return type: 0: day, 1: lunar month day, 2: week, 3: holiday", type=int, default=0)
args = parser.parse_args()
lc = LunarCalendar()
lc.current(args.type)