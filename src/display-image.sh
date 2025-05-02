#!/bin/bash

# PARAMS: PATH_TO_IMAGE

# Run if catimg is installed
if command -v catimg >/dev/null 2>&1; then

    # Display picture
    if [ -f "$1" ]; then # Check if image file exists
        catimg -w 256 "$1"
    else
        echo "WARNING! $0 called but "$1" could not be found."
    fi
else
    echo "(install catimg to see visual here)"
fi