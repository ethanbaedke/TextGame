#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

bash src/world/beach/describe-beach.sh
bash src/await-continuation.sh

bash src/world/roll-encounter.sh beach
if [ $? -eq 1 ]; then
    exit 1
fi