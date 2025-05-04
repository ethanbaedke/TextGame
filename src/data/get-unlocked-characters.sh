#!/bin/bash

num_characters=($(bash src/data/core/read-byte.sh data/unlocked-character-data.bin 0))

for ((i=0; i<num_characters; i++)); do

    byte_offset=$(((i * 10) + 1))
    character_name=($(bash src/data/core/read-string.sh data/unlocked-character-data.bin 10 $byte_offset))
    echo -n "$character_name "

done

echo # Important