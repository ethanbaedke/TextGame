#!/bin/bash

# PARAMS: GOLD_AMOUNT

current_gold=$(bash src/data/core/read-byte.sh data/inventory-data.bin 0)
new_gold=$((current_gold + $1))

# Ensure new gold is not less than zero
if [ $new_gold -lt 0 ]; then
    new_gold=0
fi

# Ensure gold does not exceed 255 (max gold)
if [ $new_gold -gt 255 ]; then
    new_gold=255
fi

bash src/data/core/write-byte.sh data/inventory-data.bin $new_gold 0