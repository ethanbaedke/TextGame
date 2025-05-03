#!/bin/bash

# PARAMS: QUEST_INDEX
# EXIT CODE: integer representing quest progress (0 is unstarted)

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

hex_byte=$(xxd -p -s $1 -l 1 data/quest-data.bin)
byte_value=$((16#$hex_byte))
exit $byte_value