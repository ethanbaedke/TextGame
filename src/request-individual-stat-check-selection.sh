#!/bin/bash

# PARAMS: CHARACTER_NAME STAT_NAME STAT_NAME STAT_NAME ...
# Saves the STAT_NAME selected to the selection-data file

echo
display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
options=()

# Iterate over all stats that are able to be checked against
for ((i=2; i<=$#; i++)); do
    stat="${!i}"
    value=$(bash src/data/get-actor-info.sh $1 $stat)
    echo "$stat ($display_name - $value/5)"
    options+=($(echo "$stat" | tr '[:upper:]' '[:lower:]'))
done

# Have the user choose which stat to test
bash src/request-selection.sh ${options[@]}
selection=$(bash src/data/get-selection.sh)

# Grab the character with the highest value for that stat
selection=$(echo "$selection" | tr '[:lower:]' '[:upper:]')

bash src/data/save-selection.sh $selection