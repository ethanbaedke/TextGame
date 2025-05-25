#!/bin/bash

# PARAMS: ITEM_NAME

num_items=$(bash src/data/core/read-byte.sh data/inventory-data.bin 1)

removed=0
for ((i=0; i<$num_items; i++)); do

    offset=$(((i * 10) + 2))
    item=($(bash src/data/core/read-string.sh data/inventory-data.bin 10 $offset))

    # Search for the item in the data-file
    if [ $removed -eq 0 ]; then
        if [ "$item" == "$1" ]; then
            bash src/data/core/write-null.sh data/inventory-data.bin 10 $offset
            removed=1
        fi

    # The item's name was found, move subsequent names back one index in the data-file
    else
        ii=$((i - 1))
        offset=$(((ii * 10) + 2))
        bash src/data/core/write-string.sh data/inventory-data.bin "$item" 10 $offset
        offset=$(((i * 10) + 2))
        bash src/data/core/write-null.sh data/inventory-data.bin 10 $offset
    fi
done

if [ ! $removed -eq 0 ]; then

    # Decrease the number of inventory items by one
    new_num_items=$(($num_items - 1))
    bash src/data/core/write-byte.sh data/inventory-data.bin $new_num_items 1

else
    echo -e "ERROR! $0 called but the item name \"$1\" could not be found in data/inventory-data.bin."
    exit 1
fi

exit 0