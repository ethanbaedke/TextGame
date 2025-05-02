#!/bin/bash

PARTY_FILE_SIZE=41 # Holds 1 byte for how many characters are in the party and 4 character names at 10 bytes each

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    dd if=/dev/zero of=data/party-data.bin bs=1 count=$PARTY_FILE_SIZE status=none
    printf "0" | dd of=data/party-data.bin bs=1 seek=0 count=1 status=none conv=notrunc
fi

UNLOCKED_CHARACTER_FILE_SIZE=1 # Holds 1 byte for the number of unlocked characters, names are appended as added with 10 bytes of space each

# Create the unlocked-character-data file if it doesn't exist
if [ ! -f "data/unlocked-character-data.bin" ]; then
    dd if=/dev/zero of=data/unlocked-character-data.bin bs=1 count=$UNLOCKED_CHARACTER_FILE_SIZE status=none
    printf "0" | dd of=data/unlocked-character-data.bin bs=1 seek=0 count=1 status=none conv=notrunc
fi

# Creates character-data for all npc's ONLY IF character-data does not already exist for them

CHARACTER_FILE_SIZE=63 # 3 for stats, 60 for name and color

# Aidan - Hobbit
character_name=aidan
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Aidan" "CR_COL" "Unknown"
fi

# Dylan - Wizard
character_name=dylan
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Dylan" "CR_COL" "Unknown"
fi

# Max - Jockey
character_name=max
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Max" "CR_COL" "Unknown"
fi

# Liberty - Horse
character_name=liberty
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Liberty" "CR_COL" "Unknown"
fi

# Chelsea - Hobbit or Mermaid
character_name=chelsea
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Chelsea" "CR_COL" "Unknown"
fi

# Josie - Mage
character_name=josie
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Josie" "CR_COL" "Unknown"
fi

# Madelyn - Elf
character_name=madelyn
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Madelyn" "CR_COL" "Unknown"
fi

# Jake - Dwarf
character_name=jake
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jake" "CR_COL" "Unknown"
fi

# Aly - Dragon
character_name=aly
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Aly" "CR_COL" "Unknown"
fi

# Loklin - Hobbit or Elf
character_name=loklin
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Loklin" "CR_COL" "Unknown"
fi

# Jack - Dwarf
character_name=jack
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jack" "CR_COL" "Unknown"
fi

# Emma - Wizard (lesser known?)
character_name=emma
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Emma" "CR_COL" "Unknown"
fi

# Phoebe - Craftswoman
character_name=phoebe
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Phoebe" "CR_COL" "Unknown"
fi

# Keely - Object of Power
character_name=keely
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Keely" "CR_COL" "Unknown"
fi

# Ceci - Elf
character_name=ceci
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Ceci" "CR_COL" "Unknown"
fi

# Jackson - Paladin or Elf
character_name=jackson
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jackson" "CR_COL" "Unknown"
fi

# Fletch - Ent
character_name=fletch
if [ ! -f "data/characters/$character_name-data.bin" ]; then
    dd if=/dev/zero of=data/characters/$character_name-data.bin bs=1 count="$CHARACTER_FILE_SIZE" status=none
    bash src/save-character-data.sh "$character_name" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Fletch" "CR_COL" "Unknown"
fi