on run
    try
        -- Kill any existing WhatsApp instances
        tell application "System Events"
            set whatsappProcesses to processes where name contains "WhatsApp"
            repeat with proc in whatsappProcesses
                do shell script "kill -9 " & ((unix id of proc) as string)
            end repeat
        end tell
        
        -- Launch password protection
        set nodePath to do shell script "which node"
        set scriptPath to "/Users/rushikesh/encryption/whatsapp-locker.js"
        do shell script quoted form of nodePath & " " & quoted form of scriptPath
        
    on error errMsg
        display dialog "WhatsApp Protection Error: " & errMsg buttons {"OK"} default button "OK" with icon stop
    end try
end run

on idle
    -- Prevent direct access to original WhatsApp
    tell application "System Events"
        if exists (processes where name is "WhatsApp-Original") then
            do shell script "killall 'WhatsApp-Original'"
        end if
    end tell
    return 1
end idle

on quit
    continue quit
end quit
