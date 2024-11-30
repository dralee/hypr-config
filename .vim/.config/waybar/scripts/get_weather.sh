#!/usr/bin/env bash
# 由于1h更新一次，因此，可以增加重试次数：由原来的5次，3600/2 = 1800,取360次
# 由于wttr.in经常存在失败情况，因此使用缓存解决 2024.10.23 by dralee
storefile=$HOME/.config/waybar/scripts/weather.data

for i in {1..10}
do
    text=$(curl -s "https://wttr.in/$1?format=1")
    if [[ $? == 0 ]]
    then
        text=$(echo "$text" | sed -E "s/\s+/ /g")
        tooltip=$(curl -s "https://wttr.in/$1?format=4")
        if [[ $? == 0 ]]
        then
            tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
            echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
	    echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}" > $storefile
            exit
        fi
    fi
    sleep 2
done

if [[ -f $storefile ]] then
	cat $storefile
else
	#echo $storefile not exists, exit.
	echo "{\"text\":\"fail\", \"tooltip\":\"error\"}"
fi

