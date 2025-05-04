#!/bin/bash

# PARAMS: CHARACTER_NAME, STAT_NAME

# Ensure a file exists for the input character
bash src/data/verify-file-existence.sh data/characters/$1-data.bin
if [ $? -eq 1 ]; then
    exit 1
fi

case "$2" in
        "CR_STR")
            value=($(bash src/data/core/read-byte.sh data/characters/$1-data.bin 0))
            echo $value
            ;;
        "CR_DEX")
            value=($(bash src/data/core/read-byte.sh data/characters/$1-data.bin 1))
            echo $value
            ;;
        "CR_INT")
            value=($(bash src/data/core/read-byte.sh data/characters/$1-data.bin 2))
            echo $value
            ;;
        "CR_NAM")
            value=$(bash src/data/core/read-string.sh data/characters/$1-data.bin 30 3)
            echo $value
            ;;
        "CR_COL")
            value=$(bash src/data/core/read-string.sh data/characters/$1-data.bin 30 33)
            echo $value
            ;;
esac