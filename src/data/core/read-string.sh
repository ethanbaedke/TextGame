#!/bin/bash

# PARAMS: FILE_PATH LENGTH BYTE_OFFSET
# EXIT: 0 = success, 1 = fail

# Exit if no file exists at the input path
if [ ! -f $1 ]; then
    echo "ERROR! $0 called but $1 could not be found."
    exit 1
fi

value=$(dd if=$1 bs=1 skip=$3 count=$2 status=none | tr -d '\0')
echo "$value"

exit 0