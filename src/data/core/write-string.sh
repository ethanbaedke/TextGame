#!/bin/bash

# PARAMS: FILE_PATH STRING LENGTH BYTE_OFFSET
# EXIT: 0 = success, 1 = fail

# Exit if no file exists at the input path
if [ ! -f $1 ]; then
    echo "ERROR! $0 called but $1 could not be found."
    exit 1
fi

(printf "%s" "$2"; head -c $(( $3 - ${#2} )) < /dev/zero) | dd of="$1" bs=1 seek="$4" count="$3" status=none conv=notrunc

exit 0