#!/bin/bash

# Create the data folder if it doesn't exist
if [ ! -d "data" ]; then
    mkdir data
fi

# Create the actors folder if it doesn't exist
if [ ! -d "data/actors" ]; then
    mkdir data/actors
fi

# Create the weapons folder if it doesn't exist
if [ ! -d "data/weapons" ]; then
    mkdir data/weapons
fi

# Create the selection-data file if it doesn't exist, which holds 20 bytes for the name of the last made selection
if [ ! -f "data/selection-data.bin" ]; then
    bash src/data/core/write-null.sh data/selection-data.bin 30 0
fi

PARTY_FILE_SIZE=43 # Holds 2 bytes for world-location of party (x, y), 1 byte for how many characters are in the party, and 4 character names at 10 bytes each

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    bash src/data/core/write-null.sh data/party-data.bin $PARTY_FILE_SIZE 0
fi

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    bash src/data/core/write-null.sh data/party-data.bin $PARTY_FILE_SIZE 0
fi

UNLOCKED_CHARACTER_FILE_SIZE=171 # Holds 1 byte for the number of unlocked characters and 10 bytes for each unlockable characters name

# Create the unlocked-character-data file if it doesn't exist
if [ ! -f "data/unlocked-character-data.bin" ]; then
    bash src/data/core/write-null.sh data/unlocked-character-data.bin $UNLOCKED_CHARACTER_FILE_SIZE 0
fi

QUEST_FILE_SIZE=715 # Holds 1 byte for number of quests, and 21 bytes per quest (20 for name and 1 for progress).

# Create quest-data file if it doesn't exist
if [ ! -f "data/quest-data.bin" ]; then
    bash src/data/core/write-null.sh data/quest-data.bin $QUEST_FILE_SIZE 0
    bash src/data/core/write-byte.sh data/quest-data.bin 34 0
    bash src/data/core/write-string.sh data/quest-data.bin "aidan" 20 1
    bash src/data/core/write-string.sh data/quest-data.bin "luceborough" 20 22
    bash src/data/core/write-string.sh data/quest-data.bin "aly" 20 43
    bash src/data/core/write-string.sh data/quest-data.bin "rodmont" 20 64
    bash src/data/core/write-string.sh data/quest-data.bin "ceci" 20 85
    bash src/data/core/write-string.sh data/quest-data.bin "bakerhurst" 20 106
    bash src/data/core/write-string.sh data/quest-data.bin "chelsea" 20 127
    bash src/data/core/write-string.sh data/quest-data.bin "sharps-hollow" 20 148
    bash src/data/core/write-string.sh data/quest-data.bin "dylan" 20 169
    bash src/data/core/write-string.sh data/quest-data.bin "seltzham" 20 190
    bash src/data/core/write-string.sh data/quest-data.bin "emma" 20 211
    bash src/data/core/write-string.sh data/quest-data.bin "lawscrest" 20 232
    bash src/data/core/write-string.sh data/quest-data.bin "ethan" 20 253
    bash src/data/core/write-string.sh data/quest-data.bin "main" 20 274
    bash src/data/core/write-string.sh data/quest-data.bin "fletch" 20 295
    bash src/data/core/write-string.sh data/quest-data.bin "gunderhaven" 20 316
    bash src/data/core/write-string.sh data/quest-data.bin "jack" 20 337
    bash src/data/core/write-string.sh data/quest-data.bin "coulterstone" 20 358
    bash src/data/core/write-string.sh data/quest-data.bin "jake" 20 379
    bash src/data/core/write-string.sh data/quest-data.bin "hughesalot" 20 400
    bash src/data/core/write-string.sh data/quest-data.bin "josie" 20 421
    bash src/data/core/write-string.sh data/quest-data.bin "grossmans-rivera" 20 442
    bash src/data/core/write-string.sh data/quest-data.bin "keely" 20 463
    bash src/data/core/write-string.sh data/quest-data.bin "wrightmoor" 20 484
    bash src/data/core/write-string.sh data/quest-data.bin "liberty" 20 505
    bash src/data/core/write-string.sh data/quest-data.bin "tyus-estates" 20 526
    bash src/data/core/write-string.sh data/quest-data.bin "loklin" 20 547
    bash src/data/core/write-string.sh data/quest-data.bin "nordstead" 20 568
    bash src/data/core/write-string.sh data/quest-data.bin "madelyn" 20 589
    bash src/data/core/write-string.sh data/quest-data.bin "kavalieros-ridge" 20 610
    bash src/data/core/write-string.sh data/quest-data.bin "max" 20 631
    bash src/data/core/write-string.sh data/quest-data.bin "schwartzville" 20 652
    bash src/data/core/write-string.sh data/quest-data.bin "phoebe" 20 673
    bash src/data/core/write-string.sh data/quest-data.bin "linksburg" 20 694
fi

# Create weapon data

weapon_name=fist
bash src/data/verify-file-existence.sh data/weapons/$weapon_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-weapon-data.sh $weapon_name
    bash src/data/save-weapon-info.sh "$weapon_name" "DAMAGE" 1 "DISPLAY_NAME" "Fists"
fi

weapon_name=sword
bash src/data/verify-file-existence.sh data/weapons/$weapon_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-weapon-data.sh $weapon_name
    bash src/data/save-weapon-info.sh "$weapon_name" "DAMAGE" 1 "DISPLAY_NAME" "Sword"
fi

weapon_name=hammer
bash src/data/verify-file-existence.sh data/weapons/$weapon_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-weapon-data.sh $weapon_name
    bash src/data/save-weapon-info.sh "$weapon_name" "DAMAGE" 1 "DISPLAY_NAME" "Hammer"
fi

weapon_name=bow
bash src/data/verify-file-existence.sh data/weapons/$weapon_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-weapon-data.sh $weapon_name
    bash src/data/save-weapon-info.sh "$weapon_name" "DAMAGE" 1 "DISPLAY_NAME" "Bow"
fi

weapon_name=teeth
bash src/data/verify-file-existence.sh data/weapons/$weapon_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-weapon-data.sh $weapon_name
    bash src/data/save-weapon-info.sh "$weapon_name" "DAMAGE" 1 "DISPLAY_NAME" "Teeth"
fi

# Creates actor-data for all npc's ONLY IF actor-data does not already exist for them

# Aidan - Hobbit
character_name=aidan
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Aidan" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Dylan - Wizard
character_name=dylan
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Dylan" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Max - Jockey
character_name=max
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Max" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

character_name=liberty
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Liberty" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Chelsea - Mermaid
character_name=chelsea
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Chelsea" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Josie - Mage
character_name=josie
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Josie" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Madelyn - Elf
character_name=madelyn
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Madelyn" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Jake - Dwarf
character_name=jake
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Jake" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Aly - Dragon
character_name=aly
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Aly" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Loklin - Hobbit
character_name=loklin
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Loklin" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Jack - Dwarf
character_name=jack
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Jack" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Emma - Wizard
character_name=emma
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Emma" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Phoebe - Craftswoman
character_name=phoebe
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Phoebe" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Keely - Eagle
character_name=keely
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Keely" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Ceci - Elf
character_name=ceci
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Ceci" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Jackson - Paladin
character_name=jackson
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Jackson" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Fletch - Ent
character_name=fletch
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Fletch" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Ethan - Human
character_name=ethan
bash src/data/verify-file-existence.sh data/actors/$character_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $character_name
    bash src/data/save-actor-info.sh "$character_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Ethan" "FAVORITE_COLOR" "Unknown" "WEAPON" "fist"
fi

# Creates actor-data for all enemies ONLY IF actor-data does not already exist for them

# Plainsrunner Jackel
enemy_name=plainsrunner
bash src/data/verify-file-existence.sh data/actors/$enemy_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $enemy_name
    bash src/data/save-actor-info.sh "$enemy_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 3 "CURRENT_HEALTH" 3 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Plainsrunner Jackel" "FAVORITE_COLOR" "Unknown" "WEAPON" "teeth"
fi

# Nomad Bandit
enemy_name=bandit
bash src/data/verify-file-existence.sh data/actors/$enemy_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $enemy_name
    bash src/data/save-actor-info.sh "$enemy_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 3 "CURRENT_HEALTH" 3 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Nomad Bandit" "FAVORITE_COLOR" "Unknown" "WEAPON" "teeth"
fi

# Create the map-data file if it doesn't exist
MAP_FILE_SIZE=4160 # Holds 20 bytes for the name of each area, the map is (width=16, height=13)
if [ ! -f "data/map-data.bin" ]; then
    bash src/data/core/write-null.sh data/map-data.bin $MAP_FILE_SIZE 0

    y=0
    bash src/data/save-map-area.sh 0 $y "beach"
    bash src/data/save-map-area.sh 1 $y "beach"
    bash src/data/save-map-area.sh 2 $y "beach"
    bash src/data/save-map-area.sh 3 $y "beach"
    bash src/data/save-map-area.sh 4 $y "beach"

    y=1
    bash src/data/save-map-area.sh 0 $y "beach"
    bash src/data/save-map-area.sh 1 $y "plains"
    bash src/data/save-map-area.sh 2 $y "plains"
    bash src/data/save-map-area.sh 3 $y "plains"
    bash src/data/save-map-area.sh 4 $y "plains"

    y=2
    bash src/data/save-map-area.sh 0 $y "beach"
    bash src/data/save-map-area.sh 1 $y "plains"
    bash src/data/save-map-area.sh 2 $y "schwartzville"
    bash src/data/save-map-area.sh 3 $y "plains"
    bash src/data/save-map-area.sh 4 $y "tyus-estates"

    y=3
    bash src/data/save-map-area.sh 0 $y "river"
    bash src/data/save-map-area.sh 1 $y "river"
    bash src/data/save-map-area.sh 2 $y "plains"
    bash src/data/save-map-area.sh 3 $y "plains"
    bash src/data/save-map-area.sh 4 $y "plains"

    y=4
    bash src/data/save-map-area.sh 0 $y "plains"
    bash src/data/save-map-area.sh 1 $y "river"
    bash src/data/save-map-area.sh 2 $y "river"
    bash src/data/save-map-area.sh 3 $y "river"
    bash src/data/save-map-area.sh 4 $y "river"
fi