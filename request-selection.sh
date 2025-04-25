#!/bin/bash

# Input a sequence of strings to be displayed as options to the user
# The user will type one of the strings, and this script will place the parameter index of that string in it's exit code (1-indexed)

option_index=0; # Starts at zero since no parameter can have index zero (1-indexed)

while [ $option_index -eq 0 ]
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
            option_index=$i
        fi
    done
done

exit $option_index