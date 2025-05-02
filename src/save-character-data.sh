#!/bin/bash

# PARAMS: CHARACTER_NAME, DATA_NAME, NEW_VALUE, DATA_NAME, NEW_VALUE, ...
# Sets any amount of DATA_NAME's to NEW_VALUE's on CHARACTER_NAME

for ((i=2; i<=$#; i+=2)); do

    # Get the name and value of the passed data
    data_name="${!i}"
    ii=$((i + 1))
    data_value="${!ii}"

    case "$data_name" in
        "CR_STR")
            printf "$data_value" | dd of=data/characters/$1-data.bin bs=1 seek=0 count=1 status=none conv=notrunc
            ;;
        "CR_DEX")
            printf "$data_value" | dd of=data/characters/$1-data.bin bs=1 seek=1 count=1 status=none conv=notrunc
            ;;
        "CR_INT")
            printf "$data_value" | dd of=data/characters/$1-data.bin bs=1 seek=2 count=1 status=none conv=notrunc
            ;;
        "CR_NAM")
            printf "$data_value" | dd of=data/characters/$1-data.bin bs=1 seek=3 count=30 status=none conv=notrunc
            ;;
        "CR_COL")
            printf "$data_value" | dd of=data/characters/$1-data.bin bs=1 seek=33 count=30 status=none conv=notrunc
            ;;
    esac
done