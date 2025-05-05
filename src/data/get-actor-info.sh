#!/bin/bash

# PARAMS: CHARACTER_NAME, STAT_NAME

case "$2" in
        "CR_STR")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 0))
            echo $value
            ;;
        "CR_DEX")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 1))
            echo $value
            ;;
        "CR_INT")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 2))
            echo $value
            ;;
        "CR_SPE")
            value=($(bash src/data/core/read-byte.sh data/actors/$1-data.bin 3))
            echo $value
            ;;
        "CR_NAM")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 30 4)
            echo $value
            ;;
        "CR_COL")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 30 34)
            echo $value
            ;;
        "CR_WEP")
            value=$(bash src/data/core/read-string.sh data/actors/$1-data.bin 10 64)
            echo $value
            ;;
esac