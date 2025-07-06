#!/bin/bash
cd "$(dirname "$0")"
osascript -e 'tell application "WhatsApp" to quit'
/usr/local/bin/node whatsapp-locker.js
