#!/bin/bash

echo "Fixing WhatsApp launcher..."
echo "Debugging: Current directory is $(pwd)"

# First check if WhatsApp exists in any location
WHATSAPP_LOCATIONS=(
    "/Applications/WhatsApp.app"
    "/System/Applications/WhatsApp.app"
    "$HOME/Applications/WhatsApp.app"
    "/Applications/WhatsApp-Original.app"  # Check if already renamed
)

for loc in "${WHATSAPP_LOCATIONS[@]}"; do
    echo "Checking location: $loc"
    if [ -d "$loc" ] || [ -L "$loc" ]; then
        echo "Found WhatsApp at: $loc"
        
        # Go to applications directory
        cd /Applications
        
        # Remove existing symlink if present
        sudo rm -f "WhatsApp.app"
        
        # If we found the original app, rename it
        if [ "$loc" = "/Applications/WhatsApp.app" ]; then
            echo "Moving original WhatsApp..."
            sudo mv "WhatsApp.app" "WhatsApp-Original.app"
        fi
        
        echo "Creating new symlink..."
        sudo ln -sf "/Users/rushikesh/encryption/WhatsAppLauncher.app" "WhatsApp.app"
        echo "Setup complete! Please try opening WhatsApp now."
        exit 0
    fi
done

echo "Error: WhatsApp not found in any known location!"
echo "Please make sure WhatsApp is installed in /Applications"
exit 1
