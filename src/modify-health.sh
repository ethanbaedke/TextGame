#!/bin/bash

# PARAMS: ACTOR_NAME MODIFICATION

max_health=$(bash src/data/get-actor-info.sh $1 "MAX_HEALTH")
current_health=$(bash src/data/get-actor-info.sh $1 "CURRENT_HEALTH")
new_health=$((current_health + $2))

# Clamp health between 0 and max_health
if [ $new_health -lt 0 ]; then
    new_health=0
elif [ $new_health -gt $max_health ]; then
    new_health=$max_health
fi

display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
if [ $2 -gt 0 ]; then
    bash src/print-dialogue.sh "[*$display_name* gained $2 health]"
elif [ $2 -lt 0 ]; then
    damage=$((0 - $2))
    bash src/print-dialogue.sh "[*$display_name* took $damage damage]"
fi

bash src/data/save-actor-info.sh $1 "CURRENT_HEALTH" $new_health