#!/usr/bin/env python

import subprocess
import datetime
import json
from html import escape
from lunar_python import Lunar, Solar
from lunar_python.util import HolidayUtil

print(datetime.date.today(), datetime.datetime.now())
a = Solar.fromDate(datetime.datetime.now())
print(a.getMonth())
lunar = Lunar.fromYmd(1986, 4, 21)
print(lunar.toFullString())
print(lunar.getSolar().toFullString())

print(HolidayUtil.getHoliday('2020-05-02'))

data = {}

today = datetime.date.today().strftime("%Y-%m-%d")

next_week = (datetime.date.today() +
             datetime.timedelta(days=10)).strftime("%Y-%m-%d")

#output = subprocess.check_output("khal list now "+next_week, shell=True)
output = subprocess.check_output("khal calendar", shell=True)
output = output.decode("utf-8")

lines = output.split("\n")
new_lines = []
for line in lines:
    clean_line = escape(line).split(" ::")[0]
    if len(clean_line) and not clean_line[0] in ['0', '1', '2']:
        clean_line = "\n<b>"+clean_line+"</b>"
    new_lines.append(clean_line)
output = "\n".join(new_lines).strip()

if today in output:
    data['text'] = "what " + output.split('\n')[1]
else:
    data['text'] = "what"

data['tooltip'] = output

print(json.dumps(data))
