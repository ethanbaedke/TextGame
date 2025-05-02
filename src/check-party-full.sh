#!/bin/bash

# EXIT CODE: 1 if the party is at max capacity and 0 if not

party_size=$(dd if=data/party-data.bin bs=1 skip=0 count=1 status=none)

if [ $party_size -lt 4 ]; then
    exit 0
else
    exit 1
fi