#!/bin/bash

# PARAMS: CHARACTER_NAME, STAT_NAME
# Gets the value of STAT_NAME on CHARACTER_NAME and stores it in the exit code

# Exit if character-data does not exist
if [ ! -f "data/$1-data.bin" ]; then
    echo "ERROR! $0 called but data/$1-data.bin could not be found."
    exit
fi

case "$2" in
        "CR_STR")
            value=$(dd if=data/$1-data.bin bs=1 skip=0 count=1 status=none)
            exit "$value"
            ;;
        "CR_DEX")
            value=$(dd if=data/$1-data.bin bs=1 skip=1 count=1 status=none)
            exit "$value"
            ;;
        "CR_INT")
            value=$(dd if=data/$1-data.bin bs=1 skip=2 count=1 status=none)
            exit "$value"
            ;;
esac