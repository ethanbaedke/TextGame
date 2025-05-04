#!/bin/bash

# PARAMS: CHARACTER_NAME
# Prints all character data on CHARACTER_NAME

bash src/display-image.sh "images/characters/beautiful/$1.png"

cr_str=$(bash src/data/get-actor-info.sh $1 "CR_STR")
cr_dex=$(bash src/data/get-actor-info.sh $1 "CR_DEX")
cr_int=$(bash src/data/get-actor-info.sh $1 "CR_INT")
cr_nam=$(bash src/data/get-actor-info.sh $1 "CR_NAM")
cr_col=$(bash src/data/get-actor-info.sh $1 "CR_COL")

echo
echo "Name: $cr_nam"
echo "Strength: $cr_str"
echo "Dexterity: $cr_dex"
echo "Intelligence: $cr_int"
echo "Favorite Color: $cr_col"