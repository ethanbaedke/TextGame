#!/bin/bash

# PARAMS: FILE_PATH
# EXIT: 0 = success, 1 = fail

if [ ! -d "$1" ]; then
    echo "ERROR! $0 called but "$1" could not be found."
    exit 1
fi

exit 0