#!/bin/bash

echo "Setting up WhatsApp encryption..."

# Find WhatsApp in all possible locations
WHATSAPP_LOCATIONS=(
    "/Applications/WhatsApp.app"
    "/System/Applications/WhatsApp.app"
    "$HOME/Applications/WhatsApp.app"
)

WHATSAPP_FOUND=false

for loc in "${WHATSAPP_LOCATIONS[@]}"; do
    if [ -d "$loc" ]; then
        echo "Found WhatsApp at: $loc"
        DIR=$(dirname "$loc")
        
        # Move to the directory containing WhatsApp
        cd "$DIR"
        
        # Backup original WhatsApp
        echo "Creating backup..."
        sudo cp -R "WhatsApp.app" "WhatsApp-Original.app"
        sudo rm -rf "WhatsApp.app"
        
        # Create symlink to our launcher
        echo "Creating launcher link..."
        sudo ln -sf "/Users/rushikesh/encryption/WhatsAppLauncher.app" "WhatsApp.app"
        
        WHATSAPP_FOUND=true
        echo "Setup complete! Try opening WhatsApp now."
        break
    fi
done

if [ "$WHATSAPP_FOUND" = false ]; then
    echo "Error: WhatsApp not found. Please install WhatsApp first."
    exit 1
fi
