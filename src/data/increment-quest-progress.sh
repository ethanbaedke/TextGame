#!/bin/bash

# PARAMS: QUEST_INDEX

progress=$(src/data/get-quest-progress.sh $1)
new_progress=$((progress + 1))
bash src/data/core/write-byte.sh data/quest-data.bin $new_progress $1