#!/bin/bash

# PARAMS: CHARACTER_NAME, STAT_NAME

case "$2" in
        "STRENGTH")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 0))
            echo $value
            ;;
        "DEXTERITY")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 1))
            echo $value
            ;;
        "INTELLIGENCE")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 2))
            echo $value
            ;;
        "SPEED")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 3))
            echo $value
            ;;
        "DISPLAY_NAME")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 30 4)
            echo $value
            ;;
        "FAVORITE_COLOR")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 30 34)
            echo $value
            ;;
        "CR_WEP")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 10 64)
            echo $value
            ;;
esac