#!/bin/bash

# PARAMS: ATTACKER_ACTOR_NAME TARGET_ACTOR_NAME

attacker_display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
weapon_name=$(bash src/data/get-actor-info.sh $1 "WEAPON")
weapon_display_name=$(bash src/data/get-weapon-info.sh $weapon_name "DISPLAY_NAME")
target_display_name=$(bash src/data/get-actor-info.sh $2 "DISPLAY_NAME")

bash src/print-dialogue.sh "[*$attacker_display_name* attacked *$target_display_name* with their -$weapon_display_name-]"

weapon_damage=$(bash src/data/get-weapon-info.sh $weapon_name "DAMAGE")
bash src/modify-temp-health.sh $2 -$weapon_damage