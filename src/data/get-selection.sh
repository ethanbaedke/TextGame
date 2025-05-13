#!/bin/bash

# Prints the most recently saved selection to standard output

selection=$(bash src/data/core/read-string.sh data/selection-data.bin 20 0)
echo "$selection"