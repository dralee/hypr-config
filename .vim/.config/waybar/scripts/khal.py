#!/usr/bin/env python
# pip install lunar_python
"""
khal luanar calendar
2024.05.13 by dralee
question:
    the waybay tooltip use gtk label which only support span and the font show label, 
    not any others UI html tag, the calendar couldn't show the grid, so short for it
    https://docs.gtk.org/Pango/pango_markup.html
"""
import subprocess
import datetime
import json
from html import escape
from lunar_python import Lunar, Solar, SolarMonth, LunarMonth, SolarWeek
from lunar_python.util import HolidayUtil

#print(datetime.date.today(), datetime.datetime.now())

class Day:
    def __init__(self):
        self.day = 0 
        self.text = ''
        self.isFestival = False
        self.isToday = False
        self.isOther = False
        self.isHoliday = False
        self.isRest = False

    def __str__(self):
        return "day: %s, text: %s, isFestival: %s, isToday: %s, isOther: %s, isHoliday: %s, isRest: %s" % (self.day, self.text, self.isFestival, self.isToday, self.isOther, self.isHoliday, self.isRest)


class Calendar:
    def __init__(self):
        self.week = {
            0: '周 日', 1: '周 一', 2: '周 二', 3: '周 三', 4: '周 四', 5: '周 五', 6: '周 六'
        }

    def build_day(self, now, d):
        month = now.getMonth()

        lunar = d.getLunar()
        day = Day()
        day.day = d.getDay()
        text = lunar.getDayInChinese()
        if (1 == lunar.getDay()):
            text = lunar.getMonthInChinese() + '月'
        
        otherFestivals = d.getOtherFestivals()
        if len(otherFestivals) > 0:
            text = otherFestivals[0]
            day.isFestival = True
        
        otherFestivals = lunar.getOtherFestivals()
        if len(otherFestivals) > 0:
            text = otherFestivals[0]
            day.isFestival = True
        
        festivals = d.getFestivals()
        if len(festivals) > 0:
            text = festivals[0]
            day.isFestival = True
        
        festivals = lunar.getFestivals()
        if len(festivals) > 0:
            text = festivals[0]
            day.isFestival = True
        
        jq = lunar.getJieQi()
        if jq:
            text = jq
            day.isFestival = True
        
        day.text = text
        if d.toYmd() == now.toYmd():
            day.isToday = True
        
        if d.getMonth() != month:
            day.isOther = True
        
        h = HolidayUtil.getHoliday(d.getYear(), d.getMonth(), d.getDay())
        if h:
            day.isHoliday = True
            day.isRest = not h.isWork()
        
        return day
        
    def build(self,now):
        a = Solar.fromDate(datetime.datetime.now())
        #print(a.getMonth())
        m = SolarMonth.fromYm(a.getYear(), a.getMonth())
        wks = m.getWeeks(0)
        days = []
        for wk in wks:
            #print("week:", wk.toString())
            for d in wk.getDays():
                #print(" day:",d, "lunar:", self.build_day(now, d))
                days.append(self.build_day(now, d))

        #print("month:", m)
        #print("weaks:", wks)
        return days

    def build_calendar(self):
        now = Solar.fromDate(datetime.datetime.now())
        days = self.build(now)
        
        #print("now:", now.getYear(), now.getMonth(), now.getWeek())

        data = {}
        data['text'] = "calendar"

        content = '<span>日</span><span>一</span><span>二</span><span>三</span><span>四</span><span>五</span><span>六</span>\n'
        index = 0
        for day in days:
            content += '<span width="60px" height="60px" background="#f0f0f0"><span>{}</span><small>{}</small></span>'.format(day.day, day.text)
            if index % 7 == 0:
                content += '\n'
            index += 1
        data['tooltip'] = content
        
# """<div class="calendar">
#     <div class="title">
#       <a href="javascript:void(0);" @click="onPrevMonth">&lt;</a>
#       %s年 %s月
#       <a href="javascript:void(0);" @click="onNextMonth">&gt;</a>
#     </div>
#     <div class="body">
#       <ul class="week">
#         <li v-for="(head, index) in state.heads" :class="{first: index === 0}">星期%s</li>
#       </ul>
#       <ul class="day" v-for="week in state.weeks">
#         <li class="row">week.index<br>周</li>
#         <li v-for="day in week.days"
#             :class="{festival: day.isFestival, today: day.isToday, other: day.isOther, rest: day.isRest}">
#           day.day
#           <i>day.text</i>
#           <u v-if="day.isHoliday"> {{ day.isRest ? '休' : '班' }}</u>
#         </li>
#       </ul>
#     </div>
#   </div>
#         """ % (now.getYear(), now.getMonth(), now.getWeek())
        
        print(json.dumps(data))

        return data

    def __week(self, w):
        """数字转周几"""        
        return self.week.get(w)

    def event(self):
        next_week = (datetime.date.today() +
             datetime.timedelta(days=10)).strftime("%Y-%m-%d")
        output = subprocess.check_output("khal list now "+next_week, shell=True)
        output = output.decode("utf-8")

        lines = output.split("\n")
        new_lines = []
        for line in lines:
            clean_line = escape(line).split(" ::")[0]
            if len(clean_line) and not clean_line[0] in ['0', '1', '2']:
                clean_line = "\n<b>"+clean_line+"</b>"
            new_lines.append(clean_line)
        output = "\n".join(new_lines).strip()

        return output

    def current(self):
        now = datetime.datetime.now()
        #now = datetime.datetime(now.year, now.month, 1, 0, 0, 0)
        day = Solar.fromDate(now)
        week = SolarWeek(now.year, now.month, now.day, 0)
        week.getDay()
        lunar = day.getLunar()

        holiday = ''
        f = ''
        h = ''
        for f in day.getFestivals():
            h += f + ' '
        for f in lunar.getFestivals():
            h += f + ' '
        if lunar.getJieQi() != '':
            h += lunar.getJieQi() + ' '
        for f in lunar.getOtherFestivals():
            h += f + ' '
        if h != '':
            holiday = "\n<span font_weight='bold' color='#FFAF45'> {}</span>".format(h)

        e = self.event()
        e_str = ''
        if e != '':
            e_str = "\n<span>{}</span>".format(e)
        content = '<span font="Microsoft YaHei"><span>{} <span font_weight="bold" color="#B4D4FF">{}</span></span>\n<span><span color="#40E2B3" size="larger">\ue369</span> {}月{}</span>{}{}</span>'\
            .format(day, self.week[day.getWeek()], lunar.getMonthInChinese(), lunar.getDayInChinese(), holiday, e_str)
        
        data = {}
        data['text'] = '<span color="#7469B6">\udb80\udcf6</span>'
        data['tooltip'] = content

        print(json.dumps(data))

# def main():
#     c = Calendar()
#     return c.build_calendar()


#data = {}
#c = Calendar()
#data = c.build_calendar()

def main():
    c = Calendar()
    c.current()

if __name__ == '__main__':
    main()
