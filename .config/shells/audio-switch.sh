#!/usr/bin/env bash

SINK=$(pactl list short sinks | fzf | awk '{print $2}')
[ -n "$SINK" ] && pactl set-default-sink "$SINK"
