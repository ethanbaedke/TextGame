#!/bin/bash

# PARAMS: QUEST_INDEX

# Exit if quest-data does not exist
if [ ! -f "data/quest-data.bin" ]; then
    echo "ERROR! $0 called but data/quest-data.bin could not be found."
    exit
fi

# Exit if QUEST_INDEX exceeds the size of the quest-data file
quest_data_file_size=$(stat --format=%s data/quest-data.bin)
if [ $1 -ge $quest_data_file_size ]; then
    echo "ERROR! $0 called but quest index $1 is outside the bounds of data/quest-data.bin."
    exit
fi

bash src/get-quest-progress.sh $1
progress=$?
new_progress=$((progress + 1))
printf "%02x" $new_progress | xxd -r -p | dd of=data/quest-data.bin bs=1 seek=$1 count=1 conv=notrunc status=none