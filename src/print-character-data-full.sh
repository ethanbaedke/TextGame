#!/bin/bash

# PARAMS: CHARACTER_NAME
# Prints all character data on CHARACTER_NAME

bash src/display-image.sh "images/characters/beautiful/$1.png"

cr_str=$(bash src/data/get-actor-info.sh $1 "STRENGTH")
cr_dex=$(bash src/data/get-actor-info.sh $1 "DEXTERITY")
cr_int=$(bash src/data/get-actor-info.sh $1 "INTELLIGENCE")
cr_spe=$(bash src/data/get-actor-info.sh $1 "SPEED")
cr_nam=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
cr_col=$(bash src/data/get-actor-info.sh $1 "FAVORITE_COLOR")
cr_wep=$(bash src/data/get-actor-info.sh $1 "CR_WEP")
wp_nam=$(bash src/data/get-weapon-info.sh $cr_wep "DISPLAY_NAME")
wp_dam=$(bash src/data/get-weapon-info.sh $cr_wep "DAMAGE")

echo
echo "Name: $cr_nam"
echo "Strength: $cr_str"
echo "Dexterity: $cr_dex"
echo "Intelligence: $cr_int"
echo "Speed: $cr_spe"
echo "Weapon: $wp_nam (damage=$wp_dam)"
echo "Favorite Color: $cr_col"