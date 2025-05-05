#!/bin/bash

# PARAMS: ATTACKER_ACTOR_NAME TARGET_ACTOR_NAME

attacker_display_name=$(bash src/data/get-actor-info.sh $1 "CR_NAM")
weapon_name=$(bash src/data/get-actor-info.sh $1 "CR_WEP")
weapon_display_name=$(bash src/data/get-weapon-info.sh $weapon_name "WP_NAM")
target_display_name=$(bash src/data/get-actor-info.sh $2 "CR_NAM")

echo
echo "$attacker_display_name attacked $target_display_name with their $weapon_display_name"