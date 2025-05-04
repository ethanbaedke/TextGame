#!/bin/bash

party_size=($(bash src/data/get-party-size.sh))

character_list=()
for ((i=1; i<$party_size; i++)); do
    byte_offset=$(((i * 10) + 3))
    party_member=($(bash src/data/core/read-string.sh data/party-data.bin 10 $byte_offset))
    character_list+=("$party_member ")
done

echo ${character_list[@]}