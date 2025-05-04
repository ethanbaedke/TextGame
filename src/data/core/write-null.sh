#!/bin/bash

# PARAMS: FILE_PATH NUM_BYTES BYTE_OFFSET

dd if=/dev/zero of=$1 bs=1 seek=$3 count=$2 status=none conv=notrunc