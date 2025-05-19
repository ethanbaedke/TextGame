#!/bin/bash

# PARAMS: STAT_NAME STAT_NAME STAT_NAME ...
# Saves the STAT_NAME selected to the selection-data file

echo
party=($(bash src/data/get-party-characters.sh))
party_size=$(bash src/data/get-party-size.sh)
options=()

# Iterate over all stats that are able to be checked against
for ((i=1; i<=$#; i++)); do
    stat="${!i}"
    echo -n "$stat ("

    party_minus_one=$((party_size - 1))
    for ((f=0; f<party_minus_one; f++)); do
        name=$(bash src/data/get-actor-info.sh ${party[f]} "DISPLAY_NAME")
        value=$(bash src/data/get-actor-info.sh ${party[f]} $stat)
        echo -n "$name - $value/5, "
    done
    name=$(bash src/data/get-actor-info.sh ${party[party_minus_one]} "DISPLAY_NAME")
    value=$(bash src/data/get-actor-info.sh ${party[party_minus_one]} $stat)
    echo "$name - $value/5)"

    options+=($(echo "$stat" | tr '[:upper:]' '[:lower:]'))
done

# Have the user choose which stat to test
bash src/request-selection.sh ${options[@]}
selection=$(bash src/data/get-selection.sh)

# Grab the character with the highest value for that stat
selection=$(echo "$selection" | tr '[:lower:]' '[:upper:]')

bash src/data/save-selection.sh $selection