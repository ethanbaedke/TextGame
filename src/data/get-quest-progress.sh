#!/bin/bash

# PARAMS: QUEST_NAME

num_quests=$(bash src/data/core/read-byte.sh data/quest-data.bin 0)

for ((i=0; i<num_quests; i++)); do
    name_offset=$(((i * 21) + 1))
    quest_name=$(bash src/data/core/read-string.sh data/quest-data.bin 20 $name_offset)
    if [ "$quest_name" == "$1" ]; then
        progress_offset=$((name_offset + 20))
        quest_progress=$(bash src/data/core/read-byte.sh data/quest-data.bin $progress_offset)
        echo $quest_progress
        exit 0
    fi
done

echo "ERROR! $0 called but no quest with the name $1 could be found."
exit 1