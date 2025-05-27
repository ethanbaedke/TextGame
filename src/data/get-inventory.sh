#!/bin/bash

# Prints the contents of the players inventory to standard output

num_items=$(bash src/data/core/read-byte.sh data/inventory-data.bin 1)

items=()
for ((i=0; i<$num_items; i++)); do
    offset=$((($i * 10) + 2))
    items+=($(bash src/data/core/read-string.sh data/inventory-data.bin 10 $offset))
done

echo ${items[@]}