#!/bin/bash

# PARAMS: AMOUNT

party=($(bash src/data/get-party-characters.sh))
num_members=${#party[@]}

# Sort party in order of lower experience to highest experience
gain_order=($(for member in "${party[@]}"; do
        printf "%s\t%s\n" "$(bash src/data/get-actor-info.sh $member "EXPERIENCE")" "$member"
    done | sort -n | cut -f2))

distribution=()

for member in ${party[@]}; do
    distribution+=(0)
done

for ((i=0; i<$1; i++)); do
    index=$(($i % $num_members))
    current_xp=${distribution[$index]}
    new_xp=$((current_xp + 1))
    distribution[$index]=$new_xp
done

for ((i=0; i<${#gain_order[@]}; i++)); do
    bash src/gain-experience.sh ${gain_order[$i]} ${distribution[$i]}
done