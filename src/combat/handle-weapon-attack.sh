#!/bin/bash

# PARAMS: ATTACKER_ACTOR_NAME TARGET_ACTOR_NAME

attacker_display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
weapon_name=$(bash src/data/get-actor-info.sh $1 "WEAPON")
weapon_display_name=$(bash src/data/get-weapon-info.sh $weapon_name "DISPLAY_NAME")
target_display_name=$(bash src/data/get-actor-info.sh $2 "DISPLAY_NAME")

echo
echo "$attacker_display_name attacked $target_display_name with their $weapon_display_name."

bash src/await-continuation.sh

weapon_damage=$(bash src/data/get-weapon-info.sh $weapon_name "DAMAGE")
echo
echo "The attack dealt $weapon_damage damage to $target_display_name."

bash src/await-continuation.sh

bash src/combat/modify-combat-health.sh $2 -$weapon_damage