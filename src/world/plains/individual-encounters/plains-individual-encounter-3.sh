#!/bin/bash

# PARAMS: CHARACTER_NAME

display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
echo
echo "$display_name stumbled across $0!"