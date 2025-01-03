#!/bin/bash

#used to simplify connecting to overthewire for the wargames

# Check if the level is provided as a command-line argument
if [[ -z "$1" ]]; then
    echo "Usage: $0 <level>"
    exit 1
fi

level="$1"

# Validate input (ensure level is a number)
if ! [[ "$level" =~ ^[0-9]+$ ]]; then
    echo "Error: Level must be a number."
    exit 1
fi

# Check if keyring.txt exists
if [[ ! -f "keyring.txt" ]]; then
    echo "Error: keyring.txt not found in the current directory."
    exit 1
fi

# Retrieve the password for the specified level
password=$(grep "^level$level=" keyring.txt | cut -d '=' -f 2)

# Check if the password was found
if [[ -z "$password" ]]; then
    echo "Error: Password for level$level not found in keyring.txt."
    exit 1
fi

# Check if expect is installed
if ! command -v expect &> /dev/null; then
    echo "Error: expect is not installed. Please install it to proceed."
    exit 1
fi

# Copy the password to the clipboard (optional, for manual pasting)
if command -v xclip &> /dev/null; then
    echo -n "$password" | xclip -selection clipboard
    echo "Password copied to clipboard. The password will be automatically pasted in 5 seconds."
elif command -v pbcopy &> /dev/null; then
    echo -n "$password" | pbcopy
    echo "Password copied to clipboard. The password will be automatically pasted in 5 seconds."
else
    echo "Error: No clipboard utility found (xclip or pbcopy)."
    echo "Password: $password"
fi

# Open SSH in a new terminal window using port 2220 and automate password entry after 5 seconds, then close the term
if command -v gnome-terminal &> /dev/null; then
    gnome-terminal -- bash -c "expect -c '
    spawn ssh -p 2220 bandit$level@bandit.labs.overthewire.org
    sleep 5
    send \"$password\r\"
    interact
    exit
    '"
elif command -v xterm &> /dev/null; then
    xterm -hold -e "expect -c '
    spawn ssh -p 2220 bandit$level@bandit.labs.overthewire.org
    sleep 5
    send \"$password\r\"
    interact
    exit
    '"
elif command -v konsole &> /dev/null; then
    konsole --noclose -e "expect -c '
    spawn ssh -p 2220 bandit$level@bandit.labs.overthewire.org
    sleep 5
    send \"$password\r\"
    interact
    exit
    '"
else
    echo "Error: No supported terminal emulator found (gnome-terminal, xterm, or konsole)."
    exit 1
fi

