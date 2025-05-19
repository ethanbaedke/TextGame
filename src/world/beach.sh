#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

# PROMPT: Golden fantasy beach at sunset, glowing seashells scattered across the sand, driftwood and seaweed along the shore, gentle waves reflecting orange and pink sky, distant magical glow on the horizon, soft lighting, ethereal atmosphere, high detail, fantasy concept art style.
bash src/display-image.sh "images/landscapes/beach.png"

echo
echo "Golden sands stretch beneath a sky painted with the hues of a dying sun, the waves whispering secrets as they gently kiss the shore."
echo "Seashells glint among driftwood and seaweed, remnants of ancient tides and lost voyages."
read -p "Occasionally, a distant song rides the wind, hinting at something old and magical beneath the waves."

# RANDOM ENCOUNTERS

# 1/5 chance
chance=$((RANDOM % 5))

if [ $chance -gt 0 ]; then
    exit
fi