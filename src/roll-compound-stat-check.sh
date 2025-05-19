#!/bin/bash

# PARAMS: STAT_NAME ACTOR_NAME ACTOR_NAME ACTOR_NAME ...
# EXIT CODE: 0 if the compound stat check was successful and 1 if it failed

value=0
for ((i=2; i<=$#; i++)); do
    stat=$(bash src/data/get-actor-info.sh ${!i} $1)
    value=$((value + stat))
done

roll_range=$((($# - 1) * 5))
roll=$((RANDOM % $roll_range))

if [ $value -gt $roll ]; then
    exit 0
else
    exit 1
fi