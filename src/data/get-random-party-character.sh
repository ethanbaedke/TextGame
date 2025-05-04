#!/bin/bash

party_size=($(bash src/data/get-party-size.sh))
random_party_index=$((RANDOM % $party_size))
byte_offset=$(((random_party_index * 10) + 3))
party_character=($(bash src/data/core/read-string.sh data/party-data.bin 10 $byte_offset))
echo $party_character