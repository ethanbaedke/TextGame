#!/bin/bash

# EXIT CODE: 1 if the party is at max capacity and 0 if not

# Exit if the party-data file doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    echo "ERROR! $0 called but data/party-data.bin could not be found."
    exit
fi

party_size=$(dd if=data/party-data.bin bs=1 skip=2 count=1 status=none)

if [ $party_size -lt 4 ]; then
    exit 0
else
    exit 1
fi