#!/bin/bash

# PARAMS: ACTOR_NAME ACTOR_NAME ACTOR_NAME ...

for actor in $@; do
    current_health=$(bash src/data/get-actor-info.sh $actor "CURRENT_HEALTH")
    bash src/data/save-actor-info.sh $actor "TEMP_HEALTH" $current_health
done