#!/bin/bash

# EXIT CODE: 1 if all party characters have been knocked out

party=($(bash src/data/get-party-characters.sh))

bash src/are-actors-knocked-out.sh ${party[@]}
if [ $? -eq 1 ]; then
    exit 1;
fi