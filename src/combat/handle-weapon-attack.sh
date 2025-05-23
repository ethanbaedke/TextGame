#!/bin/bash

# PARAMS: ATTACKER_ACTOR_NAME TARGET_ACTOR_NAME

attacker_display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
weapon_name=$(bash src/data/get-actor-info.sh $1 "WEAPON")
weapon_display_name=$(bash src/data/get-weapon-info.sh $weapon_name "DISPLAY_NAME")
target_display_name=$(bash src/data/get-actor-info.sh $2 "DISPLAY_NAME")

bash src/print-dialogue.sh "[*$attacker_display_name* attacked *$target_display_name* with their -$weapon_display_name-]"

weapon_damage=$(bash src/data/get-weapon-info.sh $weapon_name "DAMAGE")
weapon_physical_type=$(bash src/data/get-weapon-info.sh $weapon_name "PHYSICAL_TYPE")
weapon_elemental_type=$(bash src/data/get-weapon-info.sh $weapon_name "ELEMENTAL_TYPE")

target_armor=$(bash src/data/get-actor-info.sh $2 "ARMOR")
base_resistance=$(bash src/data/get-armor-info.sh $target_armor "BASE_RESISTANCE")
physical_resistance=$(bash src/data/get-armor-info.sh $target_armor "PHYSICAL_RESISTANCE")
elemental_resistance=$(bash src/data/get-armor-info.sh $target_armor "ELEMENTAL_RESISTANCE")

# Handle base resistance to damage
damage=$(($weapon_damage - $base_resistance))

# Handle resistance to physical damage type
if [ "$weapon_physical_type" == "$physical_resistance" ]; then
    bash src/print-dialogue.sh "[The attack was not very effective]"
    damage=$((weapon_damage - 2))
fi

# Ensure damage isn't less than zero
if [ $damage -lt 0 ]; then
    damage=0
fi

bash src/modify-temp-health.sh $2 -$damage