#!/bin/bash

# PARAMS: MENDER_ACTOR_NAME

display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
bash src/print-dialogue.sh "[*$display_name* took a moment to heal themselves]"
bash src/modify-temp-health.sh $1 1

# Roll luck check for critical heal
bash src/roll-stat-check.sh $1 "LUCK" -d
if [ $? -eq 0 ]; then
    bash src/print-dialogue.sh "[*$display_name* had some additional wounds mend themselves naturally]"
    bash src/modify-temp-health.sh $1 1
fi