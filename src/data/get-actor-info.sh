#!/bin/bash

# PARAMS: CHARACTER_NAME, STAT_NAME

case "$2" in
        "LEVEL")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 0))
            echo $value
            ;;
        "EXPERIENCE")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 1))
            echo $value
            ;;
        "STRENGTH")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 2))
            echo $value
            ;;
        "DEXTERITY")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 3))
            echo $value
            ;;
        "INTELLIGENCE")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 4))
            echo $value
            ;;
        "CHARISMA")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 5))
            echo $value
            ;;
        "LUCK")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 6))
            echo $value
            ;;
        "MAX_HEALTH")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 7))
            echo $value
            ;;
        "CURRENT_HEALTH")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 8))
            echo $value
            ;;
        "TEMP_HEALTH")
            # This is a temporary data slot to track current health while the actor is in combat
            # This way, combat damage is only saved if desired (for characters) and only after combat has finished (doesn't save if combat ends abruptly)
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 9))
            echo $value
            ;;
        "WEAPON")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 10 10)
            echo $value
            ;;
        "ARMOR")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 10 20)
            echo $value
            ;;
        "DISPLAY_NAME")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 30 30)
            echo $value
            ;;
        "FAVORITE_COLOR")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 30 60)
            echo $value
            ;;
esac