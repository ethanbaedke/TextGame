#!/bin/bash

PARTY_FILE_SIZE=43 # Holds 2 bytes for world-location of party (x, y), 1 byte for how many characters are in the party, and 4 character names at 10 bytes each

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    bash src/data/core/write-null.sh data/party-data.bin $PARTY_FILE_SIZE 0
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

# Chelsea - Hobbit or Mermaid
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

# Loklin - Hobbit or Elf
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

# Emma - Wizard (lesser known?)
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

# Keely - Griffon?
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

# Jackson - Paladin or Elf
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

enemy_name=goblin
bash src/data/verify-file-existence.sh data/actors/$enemy_name-data.bin > /dev/null 2>&1
if [ $? -eq 1 ]; then
    bash src/data/create-actor-data.sh $enemy_name
    bash src/data/save-actor-info.sh "$enemy_name" "STRENGTH" 0 "DEXTERITY" 0 "INTELLIGENCE" 0 "CHARISMA" 0 "LUCK" 0 "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "Goblin" "FAVORITE_COLOR" "Unknown" "WEAPON" "hammer"
fi