#!/bin/bash

# RIVER

# EXIT CODE: 1 if the party was knocked out in this area

bash src/world/river/enter-river.sh
if [ $? -eq 1 ]; then
    exit 1
fi