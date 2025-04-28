#!/bin/bash

# Creates character-data for all npc's ONLY IF character-data does not already exist for them

# Aidan - Hobbit
if [ ! -f "data/aidan-data.bin" ]; then
    bash src/save-character-data.sh "aidan" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Aidan" "CR_COL" "Unknown"
fi

# Dylan - Wizard
if [ ! -f "data/dylan-data.bin" ]; then
    bash src/save-character-data.sh "dylan" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Dylan" "CR_COL" "Unknown"
fi

# Max - Jockey
if [ ! -f "data/max-data.bin" ]; then
    bash src/save-character-data.sh "max" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Max" "CR_COL" "Unknown"
fi

# Liberty - Horse
if [ ! -f "data/liberty-data.bin" ]; then
    bash src/save-character-data.sh "liberty" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Liberty" "CR_COL" "Unknown"
fi

# Chelsea - Hobbit or Mermaid
if [ ! -f "data/chelsea-data.bin" ]; then
    bash src/save-character-data.sh "chelsea" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Chelsea" "CR_COL" "Unknown"
fi

# Josie - Mage
if [ ! -f "data/josie-data.bin" ]; then
    bash src/save-character-data.sh "josie" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Josie" "CR_COL" "Unknown"
fi

# Madelyn - Elf
if [ ! -f "data/madelyn-data.bin" ]; then
    bash src/save-character-data.sh "madelyn" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Madelyn" "CR_COL" "Unknown"
fi

# Jake - Dwarf
if [ ! -f "data/jake-data.bin" ]; then
    bash src/save-character-data.sh "jake" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jake" "CR_COL" "Unknown"
fi

# Aly - Dragon
if [ ! -f "data/aly-data.bin" ]; then
    bash src/save-character-data.sh "aly" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Aly" "CR_COL" "Unknown"
fi

# Loklin - Hobbit or Elf
if [ ! -f "data/loklin-data.bin" ]; then
    bash src/save-character-data.sh "loklin" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Loklin" "CR_COL" "Unknown"
fi

# Jack - Dwarf
if [ ! -f "data/jack-data.bin" ]; then
    bash src/save-character-data.sh "jack" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jack" "CR_COL" "Unknown"
fi

# Emma - Wizard (lesser known?)
if [ ! -f "data/emma-data.bin" ]; then
    bash src/save-character-data.sh "emma" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Emma" "CR_COL" "Unknown"
fi

# Phoebe - Craftswoman
if [ ! -f "data/phoebe-data.bin" ]; then
    bash src/save-character-data.sh "phoebe" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Phoebe" "CR_COL" "Unknown"
fi

# Keely - Object of Power
if [ ! -f "data/keely-data.bin" ]; then
    bash src/save-character-data.sh "keely" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Keely" "CR_COL" "Unknown"
fi

# Ceci - Elf
if [ ! -f "data/ceci-data.bin" ]; then
    bash src/save-character-data.sh "ceci" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Ceci" "CR_COL" "Unknown"
fi

# Jackson - Paladin or Elf
if [ ! -f "data/jackson-data.bin" ]; then
    bash src/save-character-data.sh "jackson" "CR_STR" 0 "CR_DEX" 0 "CR_INT" 0 "CR_NAM" "Jackson" "CR_COL" "Unknown"
fi