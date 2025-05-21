#!/bin/bash

# PARAMS: CHARACTER_NAME

DATA_SIZE=98 # 5 for stats, 20 for resistances, 3 for health, 10 for weapon name, 60 for display name and color
bash src/data/core/write-null.sh data/actors/$1-data.bin $DATA_SIZE 0