#!/bin/bash

# PARAMS: WEAPON_NAME

DATA_SIZE=51 # 1 for damage, 10 for physical type, 10 for elemental type, 30 for display name
bash src/data/core/write-null.sh data/weapons/$1-data.bin $DATA_SIZE 0