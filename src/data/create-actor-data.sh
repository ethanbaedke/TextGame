#!/bin/bash

# PARAMS: CHARACTER_NAME

DATA_SIZE=73 # 3 for stats, 60 for display name and color, 10 for weapon name
bash src/data/core/write-null.sh data/actors/$1-data.bin $DATA_SIZE 0