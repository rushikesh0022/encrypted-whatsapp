# WhatsApp Password Protection for macOS

This project adds password protection to WhatsApp on macOS, requiring a password before the app can be opened.

## Prerequisites

- macOS with WhatsApp installed
- Node.js installed on your system
- Terminal access with administrator privileges

## Installation

### Step 1: Download and Setup Files

1. Create the encryption directory:

```bash
mkdir -p /Users/rushikesh/encryption
cd /Users/rushikesh/encryption
```

2. Install required Node.js dependencies:

```bash
npm init -y
npm install applescript prompt-sync
```

### Step 2: Create Required Files

Create the following files in `/Users/rushikesh/encryption/`:

1. `whatsapp-locker.js` - Main password protection script
2. `WhatsAppLauncher.applescript` - AppleScript launcher
3. `backup-whatsapp.sh` - Backup script
4. `relink-whatsapp.sh` - Linking script

### Step 3: Setup WhatsApp Protection

1. Make scripts executable:

```bash
chmod +x backup-whatsapp.sh
chmod +x relink-whatsapp.sh
```

2. Backup original WhatsApp:

```bash
./backup-whatsapp.sh
```

3. Create AppleScript application:

```bash
open -a "Script Editor" WhatsAppLauncher.applescript
```

- In Script Editor: File > Export
- Format: Application
- Save as: "WhatsAppLauncher.app"

4. Link the password protection:

```bash
./relink-whatsapp.sh
```

## Usage

### First Time Setup

1. Click WhatsApp from Applications or Dock
2. You'll be prompted to set up a password (minimum 6 characters)
3. Confirm your password
4. WhatsApp will launch after successful setup

### Daily Use

1. Click WhatsApp normally
2. Enter your password when prompted
3. WhatsApp opens after correct password

## Features

- Password protection with secure hashing
- Automatic re-authentication every 5 minutes while WhatsApp is running
- Prevents direct access to WhatsApp without password
- Seamless integration with macOS

## Troubleshooting

### WhatsApp opens without password prompt

1. Run the relink script again:

```bash
cd /Users/rushikesh/encryption
./relink-whatsapp.sh
```

### "WhatsApp-Original.app not found" error

1. Run the backup script first:

```bash
./backup-whatsapp.sh
```

### Node.js path issues

1. Find your Node.js path:

```bash
which node
```

2. Update the path in WhatsAppLauncher.applescript if needed

## Removing Protection

To remove password protection and restore normal WhatsApp:

1. Remove the symlink:

```bash
sudo rm -rf /Applications/WhatsApp.app
```

2. Restore original:

```bash
sudo mv /Applications/WhatsApp-Original.app /Applications/WhatsApp.app
```

3. Remove password file:

```bash
rm ~/.whatsapp-lock
```

## Security Notes

- Password is stored as a hashed value in `~/.whatsapp-lock`
- No password recovery feature - keep your password safe
- For maximum security, consider changing the HASH_KEY in whatsapp-locker.js
- The script runs only when WhatsApp is launched, not continuously

## File Structure

```
/Users/rushikesh/encryption/
├── README.md
├── whatsapp-locker.js
├── WhatsAppLauncher.applescript
├── WhatsAppLauncher.app/
├── backup-whatsapp.sh
├── relink-whatsapp.sh
└── package.json
```

## Support

If you encounter issues:

1. Check that all files are in the correct location
2. Verify Node.js is properly installed
3. Ensure you have administrator privileges
4. Try running the setup scripts again

---

**Warning**: This is a basic security implementation. For sensitive data, consider using more robust security solutions.
