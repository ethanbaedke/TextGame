#!/bin/bash

# PARAMS: STAT_NAME STAT_NAME STAT_NAME ...

# Saves the STAT_NAME selected to the selection-data file

highest_stat_character=""

# PARAMS: STAT_NAME
print_stat_option() {
    local highest_stat_character_display_name=$(bash src/data/get-actor-info.sh $highest_stat_character "DISPLAY_NAME")
    local highest_stat=$(bash src/data/get-actor-info.sh $highest_stat_character $1)
    echo "$1 ($highest_stat_character_display_name - $highest_stat/5)"
}

options=()

# Iterate over all stats that are able to be checked against
for ((i=1; i<=$#; i++)); do
    stat="${!i}"
    highest_stat_character=$(bash src/data/get-highest-stat-party-character.sh $stat)
    print_stat_option $stat
    options+=($(echo "$stat" | tr '[:upper:]' '[:lower:]'))
done

# Have the user choose which stat to test
bash src/request-selection.sh ${options[@]}
selection=$(bash src/data/get-selection.sh)

# Grab the character with the highest value for that stat
selection=$(echo "$selection" | tr '[:lower:]' '[:upper:]')

bash src/data/save-selection.sh $selection