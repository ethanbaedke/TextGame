#!/bin/bash

# PARAMS: FILE_PATH BYTE_VALUE BYTE_OFFSET
# EXIT: 0 = success, 1 = fail

# Exit if no file exists at the input path
if [ ! -f $1 ]; then
    echo "ERROR! $0 called but $1 could not be found."
    exit 1
fi

printf "%02x" $2 | xxd -r -p | dd of="$1" bs=1 seek=$3 count=1 conv=notrunc status=none

exit 0