#!/bin/bash

# PARAMS: ACTOR_NAME MODIFICATION

max_health=$(bash src/data/get-actor-info.sh $1 "MAX_HEALTH")
current_combat_health=$(bash src/data/get-actor-info.sh $1 "COMBAT_HEALTH")
new_combat_health=$((current_combat_health + $2))

# Clamp health between 0 and max_health
if [ $new_combat_health -lt 0 ]; then
    display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
    echo
    echo "$display_name has been knocked out."
    new_combat_health=0
elif [ $new_combat_health -gt $max_health ]; then
    new_combat_health=$max_health
fi

bash src/data/save-actor-info.sh $1 "COMBAT_HEALTH" $new_combat_health