#!/bin/bash

# PARAMS: CHARACTER_NAME

DATA_SIZE=78 # 5 for stats, 3 for health, 60 for display name and color, 10 for weapon name
bash src/data/core/write-null.sh data/actors/$1-data.bin $DATA_SIZE 0