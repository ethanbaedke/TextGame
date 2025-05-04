#!/bin/bash

# PARAMS: PATH_TO_IMAGE

# Run if catimg is installed
if command -v catimg >/dev/null 2>&1; then

    # Ensure the image file exists
    bash src/data/verify-file-existence.sh "$1"
    if [ $? -eq 1 ]; then
        exit
    fi

    echo
    catimg -w 256 "$1"
else
    echo "(install catimg to see visual here)"
fi