#!/bin/bash

echo "Backing up WhatsApp..."

# Check common WhatsApp locations
WHATSAPP_LOCATIONS=(
    "/Applications/WhatsApp.app"
    "/System/Applications/WhatsApp.app"
    "$HOME/Applications/WhatsApp.app"
)

for loc in "${WHATSAPP_LOCATIONS[@]}"; do
    if [ -d "$loc" ]; then
        echo "Found WhatsApp at: $loc"
        DIR=$(dirname "$loc")
        cd "$DIR"
        
        # Backup WhatsApp if not already backed up
        if [ ! -d "WhatsApp-Original.app" ]; then
            echo "Creating backup..."
            sudo cp -R "WhatsApp.app" "WhatsApp-Original.app"
        fi
        
        exit 0
    fi
done

echo "Error: WhatsApp not found!"
exit 1
