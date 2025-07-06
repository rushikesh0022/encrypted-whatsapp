#!/bin/bash

echo "Relinking WhatsApp..."

cd /Applications

# Remove existing WhatsApp link
sudo rm -rf "WhatsApp.app"

# Ensure original exists
if [ ! -d "WhatsApp-Original.app" ]; then
    echo "Error: WhatsApp-Original.app not found!"
    exit 1
fi

# Create fresh symlink
sudo ln -sf "/Users/rushikesh/encryption/WhatsAppLauncher.app" "WhatsApp.app"

echo "Done! Try opening WhatsApp now."
