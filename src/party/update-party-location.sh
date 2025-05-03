#!/bin/bash

# PARAMS: NEW_X NEW_Y

printf "%02x" $1 | xxd -r -p | dd of=data/party-data.bin bs=1 seek=0 count=1 conv=notrunc status=none
printf "%02x" $2 | xxd -r -p | dd of=data/party-data.bin bs=1 seek=1 count=1 conv=notrunc status=none