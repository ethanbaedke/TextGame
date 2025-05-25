#!/bin/bash

# EXIT CODE: 1 if the inventory is full, and 0 otherwise

num_items=$(bash src/data/core/read-byte.sh data/inventory-data.bin 1)
if [ $num_items -eq 10 ]; then
    exit 1
else
    exit 0
fi