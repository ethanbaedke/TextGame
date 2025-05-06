#!/bin/bash

# PARAMS: CHARACTER_NAME
# Prints all character data on CHARACTER_NAME

bash src/display-image.sh "images/characters/beautiful/$1.png"

strength=$(bash src/data/get-actor-info.sh $1 "STRENGTH")
dexterity=$(bash src/data/get-actor-info.sh $1 "DEXTERITY")
intelligence=$(bash src/data/get-actor-info.sh $1 "INTELLIGENCE")
speed=$(bash src/data/get-actor-info.sh $1 "SPEED")
max_health=$(bash src/data/get-actor-info.sh $1 "MAX_HEALTH")
current_health=$(bash src/data/get-actor-info.sh $1 "CURRENT_HEALTH")
display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
favorite_color=$(bash src/data/get-actor-info.sh $1 "FAVORITE_COLOR")
weapon=$(bash src/data/get-actor-info.sh $1 "WEAPON")
weapon_display_name=$(bash src/data/get-weapon-info.sh $weapon "DISPLAY_NAME")
weapon_damage=$(bash src/data/get-weapon-info.sh $weapon "DAMAGE")

echo
echo "Name: $display_name"
echo "Strength: $strength"
echo "Dexterity: $dexterity"
echo "Intelligence: $intelligence"
echo "Speed: $speed"
echo "Health: $current_health/$max_health"
echo "Weapon: $weapon_display_name (damage=$weapon_damage)"
echo "Favorite Color: $favorite_color"