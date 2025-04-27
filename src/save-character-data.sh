#!/bin/bash

# PARAMS: DATA_NAME new_value DATA_NAME new_value ...

FILE_SIZE=63 # 3 for stats, 60 for name and color

# Create the character-data file if it doesn't exist
if [ ! -f "data/character-data.bin" ]; then
    dd if=/dev/zero of=data/character-data.bin bs=1 count="$FILE_SIZE" status=none
fi

for ((i=1; i<=$#; i+=2)); do

    # Get the name and value of the passed data
    data_name="${!i}"
    ii=$((i + 1))
    data_value="${!ii}"

    case "$data_name" in
        "CR_STR")
            printf "$data_value" | dd of=data/character-data.bin bs=1 seek=0 count="$FILE_SIZE" status=none conv=notrunc
            ;;
        "CR_DEX")
            printf "$data_value" | dd of=data/character-data.bin bs=1 seek=1 count="$FILE_SIZE" status=none conv=notrunc
            ;;
        "CR_INT")
            printf "$data_value" | dd of=data/character-data.bin bs=1 seek=2 count="$FILE_SIZE" status=none conv=notrunc
            ;;
        "CR_NAM")
            printf "$data_value" | dd of=data/character-data.bin bs=1 seek=3 count="$FILE_SIZE" status=none conv=notrunc
            ;;
        "CR_COL")
            printf "$data_value" | dd of=data/character-data.bin bs=1 seek=33 count="$FILE_SIZE" status=none conv=notrunc
            ;;
    esac
done