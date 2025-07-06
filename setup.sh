#!/bin/bash

echo "WhatsApp Encryption Setup"
echo "------------------------"

# Install Node.js dependencies
cd /Users/rushikesh/encryption
npm install applescript prompt-sync

echo "Searching for WhatsApp location..."

# Check common WhatsApp locations
if [ -d "/System/Applications/WhatsApp.app" ]; then
    WHATSAPP_PATH="/System/Applications/WhatsApp.app"
elif [ -d "/Applications/WhatsApp.app" ]; then
    WHATSAPP_PATH="/Applications/WhatsApp.app"
elif [ -d "$HOME/Applications/WhatsApp.app" ]; then
    WHATSAPP_PATH="$HOME/Applications/WhatsApp.app"
else
    echo "WhatsApp not found. Please install WhatsApp first."
    exit 1
fi

echo "Found WhatsApp at: $WHATSAPP_PATH"
WHATSAPP_DIR=$(dirname "$WHATSAPP_PATH")

cd "$WHATSAPP_DIR"
echo "Moving WhatsApp to WhatsApp-Original.app..."
sudo mv "WhatsApp.app" "WhatsApp-Original.app"

echo "Creating launcher symlink..."
sudo ln -s "/Users/rushikesh/encryption/WhatsAppLauncher.app" "WhatsApp.app"

echo "Setup complete!"
