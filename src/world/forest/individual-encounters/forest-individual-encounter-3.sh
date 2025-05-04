#!/bin/bash

# PARAMS: CHARACTER_NAME

display_name=$(bash src/data/get-character-info.sh $1 "CR_NAM")
echo
echo "$display_name stumbled across $0!"