#!/bin/bash

party=($(bash src/data/get-party-characters.sh))

for character in ${party[@]}; do
    temp_health=$(bash src/data/get-actor-info.sh $character "TEMP_HEALTH")
    bash src/data/save-actor-info.sh $character "CURRENT_HEALTH" $temp_health
done