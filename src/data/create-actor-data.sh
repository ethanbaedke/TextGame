#!/bin/bash

# PARAMS: CHARACTER_NAME

DATA_SIZE=100 # 2 for level/xp, 5 for stats, 3 for health, 10 for elemental affliction name, 10 for weapon name, 10 for armor name, 60 for display name and color
bash src/data/core/write-null.sh data/actors/$1-data.bin $DATA_SIZE 0
bash src/data/save-actor-info.sh "$1" "LEVEL" 1 "EXPERIENCE" 0 "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 1 "CURRENT_HEALTH" 1 "TEMP_HEALTH" 0 "TEMP_ELEMENTAL_AFFLICTION" "none" "WEAPON" "none" "ARMOR" "none" "DISPLAY_NAME" "Unknown" "FAVORITE_COLOR" "Unknown"