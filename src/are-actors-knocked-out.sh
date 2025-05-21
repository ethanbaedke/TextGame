#!/bin/bash

# PARAMS: ACTOR_NAME ACTOR_NAME ACTOR_NAME ...
# Exit Code: 1 if all input actors have 0 temp_health (knocked out), and 0 if any actor has more than 0 temp_health (alive)

for actor in $@; do
    temp_health=$(bash src/data/get-actor-info.sh $actor "TEMP_HEALTH")
    if [ $temp_health -gt 0 ]; then
        exit 0
    fi
done

exit 1