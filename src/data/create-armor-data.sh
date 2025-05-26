#!/bin/bash

# PARAMS: ARMOR_NAME

DATA_SIZE=52 # 1 for value, 1 for base damage resistance, 10 for physical resistance, 10 for elemental resistance, 30 for display name
bash src/data/core/write-null.sh data/armor/$1-data.bin $DATA_SIZE 0