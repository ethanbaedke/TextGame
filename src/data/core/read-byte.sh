#!/bin/bash

# PARAMS: FILE_PATH BYTE_OFFSET
# EXIT: 0 = success, 1 = fail

# Exit if no file exists at the input path
if [ ! -f $1 ]; then
    echo "ERROR! $0 called but $1 could not be found."
    exit 1
fi

hex_byte=$(xxd -p -s $2 -l 1 "$1")
byte_value=$((16#$hex_byte))
echo $byte_value

exit 0