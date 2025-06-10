#!/bin/bash

# PARAMS: ATTACKER_ACTOR_NAME TARGET_ACTOR_NAME

attacker_display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
weapon_name=$(bash src/data/get-actor-info.sh $1 "WEAPON")
weapon_display_name=$(bash src/data/get-weapon-info.sh $weapon_name "DISPLAY_NAME")
target_display_name=$(bash src/data/get-actor-info.sh $2 "DISPLAY_NAME")

bash src/print-dialogue.sh "[*$attacker_display_name* attacked *$target_display_name* with their -$weapon_display_name-]"

# Roll dexterity check for dodge
bash src/roll-stat-check.sh $2 "DEXTERITY" -d
if [ $? -eq 0 ]; then
    bash src/data/request-help-menu.sh "COMBAT_DEXTERITY"
    bash src/print-dialogue.sh "[*$target_display_name* dodged the attack]"
    exit
fi

weapon_damage=$(bash src/data/get-weapon-info.sh $weapon_name "DAMAGE")
weapon_physical_type=$(bash src/data/get-weapon-info.sh $weapon_name "PHYSICAL_TYPE")

target_armor=$(bash src/data/get-actor-info.sh $2 "ARMOR")
base_resistance=$(bash src/data/get-armor-info.sh $target_armor "BASE_RESISTANCE")
physical_resistance=$(bash src/data/get-armor-info.sh $target_armor "PHYSICAL_RESISTANCE")

damage=$(($weapon_damage))

# Roll strength check for critical hit
bash src/roll-stat-check.sh $1 "STRENGTH" -d
if [ $? -eq 0 ]; then
    bash src/data/request-help-menu.sh "COMBAT_STRENGTH"
    bash src/print-dialogue.sh "[It was a critical hit]"
    damage=$(($damage * 2))
fi

# Handle base resistance to damage
damage=$(($damage - $base_resistance))

# Handle resistance to physical damage type
if [ "$weapon_physical_type" == "$physical_resistance" ]; then
    bash src/data/request-help-menu.sh "COMBAT_RESIST"
    target_armor_display_name=$(bash src/data/get-armor-info.sh $target_armor "DISPLAY_NAME")
    bash src/print-dialogue.sh "[*$target_display_name's* $target_armor_display_name resisted the $weapon_display_name's $physical_resistance damage]"
    damage=$((weapon_damage - 2))
fi

# Ensure damage isn't less than zero
if [ $damage -lt 0 ]; then
    damage=0
fi

# Deal the damage
bash src/modify-temp-health.sh $2 -$damage

# Get elemental weapon type and defender resistance
weapon_elemental_type=$(bash src/data/get-weapon-info.sh $weapon_name "ELEMENTAL_TYPE")
elemental_resistance=$(bash src/data/get-armor-info.sh $target_armor "ELEMENTAL_RESISTANCE")

# If the weapon has no elemental type, no need to continue
if [ "$weapon_elemental_type" == "none" ]; then
    exit
fi

# If the defender resists the weapons elemental type, it does nothing and returns
if [ "$weapon_elemental_type" == "$elemental_resistance" ]; then
    bash src/data/request-help-menu.sh "COMBAT_ELEMENTAL_RESIST"
    target_armor_display_name=$(bash src/data/get-armor-info.sh $target_armor "DISPLAY_NAME")
    bash src/print-dialogue.sh "[*$target_display_name's* $target_armor_display_name resisted the $weapon_display_name's $elemental_resistance damage]"
    exit
fi

# Apply the affliction
bash src/data/request-help-menu.sh "COMBAT_ELEMENTAL_AFFLICTION_APPLICATION"
bash src/data/save-actor-info.sh $2 "TEMP_ELEMENTAL_AFFLICTION" "$weapon_elemental_type"
case $weapon_elemental_type in
    "flaming")
        bash src/print-dialogue.sh "[*$target_display_name* was lit aflame by *$attacker_display_name's* flaming $weapon_display_name]"
        ;;
esac