#!/bin/bash

# PARAMS: QUEST_INDEX

progress=$(bash src/data/core/read-byte.sh data/quest-data.bin $1)
echo $progress