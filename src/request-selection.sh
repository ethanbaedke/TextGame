#!/bin/bash

# Input a sequence of strings to be displayed as options to the user
# The user will type one of the strings and that string will be printed to standard output

echo
while [ true ]
do
    # Print the options
    for ((i=1; i<($#); i++))
    do
        echo -n "${!i} | "
    done
    echo "${!#}"

    # Request input
    read user_input

    # Compare input to the available options
    for ((i=1; i<($#+1); i++))
    do
        if [ "${!i}" == "${user_input}" ]
        then
            # A match was found
            bash src/data/save-selection.sh "$user_input"
            exit
        fi
    done
done