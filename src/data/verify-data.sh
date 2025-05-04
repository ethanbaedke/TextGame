#!/bin/bash

PARTY_FILE_SIZE=43 # Holds 2 bytes for world-location of party (x, y), 1 byte for how many characters are in the party, and 4 character names at 10 bytes each

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    bash src/data/core/write-null.sh data/party-data.bin $PARTY_FILE_SIZE 0
    bash src/party/add-to-party.sh player
fi

UNLOCKED_CHARACTER_FILE_SIZE=171 # Holds 1 byte for the number of unlocked characters and 10 bytes for each unlockable characters name

# Create the unlocked-character-data file if it doesn't exist
if [ ! -f "data/unlocked-character-data.bin" ]; then
    bash src/data/core/write-null.sh data/unlocked-character-data.bin $UNLOCKED_CHARACTER_FILE_SIZE 0
fi

QUEST_FILE_SIZE=1 # Holds 1 byte per quest

# Create quest-data file if it doesn't exist
if [ ! -f "data/quest-data.bin" ]; then
    bash src/data/core/write-null.sh data/quest-data.bin $QUEST_FILE_SIZE 0
fi

# Creates character-data for all npc's ONLY IF character-data does not already exist for them

CHARACTER_FILE_SIZE=63 # 3 for stats, 60 for name and color

# Aidan - Hobbit
character_name=aidan
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Aidan" "CR_COL" "Unknown"
fi

# Dylan - Wizard
character_name=dylan
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Dylan" "CR_COL" "Unknown"
fi

# Max - Jockey
character_name=max
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Max" "CR_COL" "Unknown"
fi

character_name=liberty
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Liberty" "CR_COL" "Unknown"
fi

# Chelsea - Hobbit or Mermaid
character_name=chelsea
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Chelsea" "CR_COL" "Unknown"
fi

# Josie - Mage
character_name=josie
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Josie" "CR_COL" "Unknown"
fi

# Madelyn - Elf
character_name=madelyn
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Madelyn" "CR_COL" "Unknown"
fi

# Jake - Dwarf
character_name=jake
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jake" "CR_COL" "Unknown"
fi

# Aly - Dragon
character_name=aly
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Aly" "CR_COL" "Unknown"
fi

# Loklin - Hobbit or Elf
character_name=loklin
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Loklin" "CR_COL" "Unknown"
fi

# Jack - Dwarf
character_name=jack
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jack" "CR_COL" "Unknown"
fi

# Emma - Wizard (lesser known?)
character_name=emma
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Emma" "CR_COL" "Unknown"
fi

# Phoebe - Craftswoman
character_name=phoebe
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Phoebe" "CR_COL" "Unknown"
fi

# Keely - Griffon?
character_name=keely
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Keely" "CR_COL" "Unknown"
fi

# Ceci - Elf
character_name=ceci
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Ceci" "CR_COL" "Unknown"
fi

# Jackson - Paladin or Elf
character_name=jackson
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jackson" "CR_COL" "Unknown"
fi

# Fletch - Ent
character_name=fletch
bash src/data/verify-file-existence.sh data/characters/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-character-data.sh $character_name
    bash src/data/save-character-info.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Fletch" "CR_COL" "Unknown"
fi