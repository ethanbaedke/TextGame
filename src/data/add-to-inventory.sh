#!/bin/bash

# PARAMS: ITEM_NAME

num_items=$(bash src/data/core/read-byte.sh data/inventory-data.bin 1)

if [ $num_items -eq 10 ]; then
    echo "ERROR! $0 called but inventory is full."
    exit
fi

if [ ! -f data/weapons/$1-data.bin ] && [ ! -f data/armor/$1-data.bin ]; then
    echo "ERROR! $0 called but $1-data.bin could not be found in data/weapons or data/armor."
    exit 1
fi

offset=$((($num_items * 10) + 2))
bash src/data/core/write-string.sh data/inventory-data.bin $1 10 $offset
bash src/data/core/write-byte.sh data/inventory-data.bin $(($num_items + 1)) 1