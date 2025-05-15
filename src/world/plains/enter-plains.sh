#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

bash src/world/plains/describe-plains.sh

bash src/world/roll-encounter.sh plains
if [ $? -eq 1 ]; then
    exit 1
fi