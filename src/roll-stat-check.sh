#!/bin/bash

# PARAMS: ACTOR_NAME STAT_NAME (-d if difficult)
# EXIT CODE: 0 if the stat check was successful and 1 if it failed

value=$(bash src/data/get-actor-info.sh $1 $2)

roll=0
if [ "$3" == "-d" ]; then
    roll=$((RANDOM % 10))
else
    roll=$((RANDOM % 5))
fi

if [ $value -gt $roll ]; then
    exit 0
else
    exit 1
fi