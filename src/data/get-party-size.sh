#!bin/bash

party_size=($(bash src/data/core/read-byte.sh data/party-data.bin 2))
echo $party_size