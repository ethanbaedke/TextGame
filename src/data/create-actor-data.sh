#!/bin/bash

# PARAMS: CHARACTER_NAME

DATA_SIZE=88 # 5 for stats, 3 for health, 10 for weapon name, 10 for armor name, 60 for display name and color
bash src/data/core/write-null.sh data/actors/$1-data.bin $DATA_SIZE 0