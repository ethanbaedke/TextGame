#!/bin/bash

# PARAMS: ACTOR_NAME STAT_NAME
# EXIT CODE: 0 if the stat check was successful and 1 if it failed

value=$(bash src/data/get-actor-info.sh $1 $2)

roll=$((RANDOM % 5))

if [ $value -gt $roll ]; then
    exit 0
else
    exit 1
fi