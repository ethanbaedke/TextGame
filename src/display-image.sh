#!/bin/bash

# PARAMS: PATH_TO_IMAGE (-s for small display)

# Run if catimg is installed
if command -v catimg >/dev/null 2>&1; then

    # Ensure the image file exists
    bash src/data/verify-file-existence.sh "$1"
    if [ $? -eq 1 ]; then
        exit
    fi

    echo
    if [ "$2" == "-s" ]; then
        catimg -w 128 "$1"
    else
        catimg -w 256 "$1"
    fi
else
    echo "(install catimg to see visual here)"
fi