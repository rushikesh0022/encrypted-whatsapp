const applescript = require('applescript');
const prompt = require('prompt-sync')();
const crypto = require('crypto');

const HASH_KEY = '9490366'; // Updated secure key
let storedHash = null;

const WHATSAPP_PATH = '/Applications/WhatsApp.app';

function hashPassword(password) {
    return crypto.createHmac('sha256', HASH_KEY)
        .update(password)
        .digest('hex');
}

function setupPassword() {
    let password, confirmPassword;
    do {
        password = prompt('Set up your WhatsApp password (minimum 6 characters): ', {echo: '*'});
        if (password.length < 6) {
            console.log('Password must be at least 6 characters long!');
            continue;
        }
        confirmPassword = prompt('Confirm your password: ', {echo: '*'});
        if (password !== confirmPassword) {
            console.log('Passwords do not match! Try again.');
        }
    } while (password.length < 6 || password !== confirmPassword);

    storedHash = hashPassword(password);
    require('fs').writeFileSync(
        require('os').homedir() + '/.whatsapp-lock',
        storedHash
    );
    console.log('Password successfully set!');
}

function verifyPassword() {
    const password = prompt('Enter WhatsApp password: ', {echo: '*'});
    return hashPassword(password) === storedHash;
}

function checkWhatsAppStatus() {
    applescript.execString(`
        tell application "System Events"
            set isRunning to (exists (processes where name is "WhatsApp"))
            if isRunning then
                tell application "WhatsApp" to quit
                return true
            end if
            return false
        end tell
    `, (err, wasRunning) => {
        if (wasRunning && !verifyPassword()) {
            console.log('Re-authentication required!');
            process.exit(1);
        }
    });
}

function ensureDependencies() {
    try {
        require('applescript');
        require('prompt-sync');
    } catch (e) {
        console.log('Installing required dependencies...');
        require('child_process').execSync('npm install applescript prompt-sync');
    }
}

function launchWhatsApp() {
    applescript.execString(`
        tell application "System Events"
            set isRunning to (exists (processes where name is "WhatsApp"))
            if isRunning then
                tell application "WhatsApp" to quit
                delay 1
            end if
        end tell
        
        -- Launch actual WhatsApp
        do shell script "open -a 'WhatsApp'"
    `, (err) => {
        if (err) {
            console.log('Error launching WhatsApp:', err);
            process.exit(1);
        }
    });
}

function main() {
    ensureDependencies();
    console.log('WhatsApp Password Protection');
    console.log('---------------------------');
    
    // Check if WhatsApp exists
    if (!require('fs').existsSync(WHATSAPP_PATH)) {
        console.log('ERROR: WhatsApp not found in Applications folder');
        process.exit(1);
    }

    try {
        storedHash = require('fs').readFileSync(
            require('os').homedir() + '/.whatsapp-lock',
            'utf8'
        );
    } catch (e) {
        console.log('First time setup:');
        setupPassword();
    }

    if (!verifyPassword()) {
        console.log('Incorrect password!');
        process.exit(1);
    }

    launchWhatsApp();

    // Add periodic check every 5 minutes
    setInterval(checkWhatsAppStatus, 300000);
}

main();
