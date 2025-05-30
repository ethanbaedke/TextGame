#!/bin/bash

# PARAMS: DIALOGUE

bash src/data/request-help-menu.sh "PRINT_DIALOGUE"

echo
output=$1
output=$(sed -E 's/\*([^*]+)\*/\\e[32m\1\\e[0m/g' <<< "$output")
output=$(sed -E 's/\-([^-]+)\-/\\e[31m\1\\e[0m/g' <<< "$output")
output=$(sed -E 's/\+([^+]+)\+/\\e[33m\1\\e[0m/g' <<< "$output")
output=$(echo -e $output)
read -p "$output"