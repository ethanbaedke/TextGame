#!/bin/bash

# PARAMS: STAT_NAME
# Prints the character in the party with the highest value for the input STAT_NAME

party_characters=($(bash src/data/get-party-characters.sh))

highest_stat_character=${party_characters[0]}
highest_stat=$(bash src/data/get-actor-info.sh $highest_stat_character $1)

for ((i=1; i<${#party_characters[@]}; i++)); do

    current_character_stat=$(bash src/data/get-actor-info.sh ${party_characters[$i]} $1)

    if [ $current_character_stat -gt $highest_stat ]; then
        highest_stat_character=${party_characters[$i]}
        highest_stat=$current_character_stat
    fi
done

echo $highest_stat_character