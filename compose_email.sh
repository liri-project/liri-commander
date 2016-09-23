#!/bin/bash
echo "tell application \"Mail\"
    activate

    set MyEmail to make new outgoing message with properties {visible:true, subject:\"$2\", content:\"$3\"}
    tell MyEmail
        make new to recipient at end of to recipients with properties {address:\"$1\"}
        make new attachment with properties {file name:((\"$3\" as POSIX file) as alias)}
    end tell
end tell
" | osascript