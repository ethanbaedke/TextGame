#!/bin/bash

# PARAMS: NEW_X NEW_Y

bash src/data/core/write-byte.sh data/party-data.bin $1 0
bash src/data/core/write-byte.sh data/party-data.bin $2 1