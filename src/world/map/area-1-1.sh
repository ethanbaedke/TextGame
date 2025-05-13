#!/bin/bash

# PLAINS

# EXIT CODE: 1 if the party was knocked out in this area

bash src/world/plains/enter-plains.sh
if [ $? -eq 1 ]; then
    exit 1
fi