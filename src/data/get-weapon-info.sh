#!/bin/bash

# PARAMS: WEAPON_NAME, STAT_NAME

case "$2" in
        "DAMAGE")
            value=($(bash src/data/core/read-byte.sh data/weapons/$1-data.bin 0))
            echo $value
            ;;
        "DISPLAY_NAME")
            value=$(bash src/data/core/read-string.sh data/weapons/$1-data.bin 30 1)
            echo $value
            ;;
esac