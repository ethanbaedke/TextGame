#!/bin/bash

# PARAMS: ACTOR_NAME MODIFICATION

max_health=$(bash src/data/get-actor-info.sh $1 "MAX_HEALTH")
temp_health=$(bash src/data/get-actor-info.sh $1 "TEMP_HEALTH")
new_health=$((temp_health + $2))

# Clamp health between 0 and max_health
if [ $new_health -lt 0 ]; then
    new_health=0
elif [ $new_health -gt $max_health ]; then
    new_health=$max_health
fi

# Display gained or lost health
display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
if [ $2 -gt 0 ]; then
    bash src/print-dialogue.sh "[*$display_name* gained $2 health]"
elif [ $2 -lt 0 ]; then
    damage=$((0 - $2))
    bash src/print-dialogue.sh "[*$display_name* took $damage damage]"
fi

# Display knock-out if health hit 0
if [ $new_health -eq 0 ]; then
    bash src/print-dialogue.sh "[*$display_name* has been knocked out]"
fi

# Save modified health value
bash src/data/save-actor-info.sh $1 "TEMP_HEALTH" $new_health