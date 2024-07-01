#!/bin/bash

# Function to display help information
display_help() {
    echo "Usage: $0 <kerbrute_command> <output_list> [--emails]"
    echo
    echo "This script executes the Kerbrute command to enumerate valid usernames"
    echo "in an Active Directory environment. While the command is running, an"
    echo "ASCII art is displayed. After the command completes, the valid usernames"
    echo "are saved to a specified file."
    echo
    echo "Options:"
    echo "  --emails   Save full email addresses instead of just usernames."
    echo
    echo "Example:"
    echo "  $0 \"kerbrute userenum -d inlanefreight.local --dc 172.16.5.5 /opt/jsmith.txt\" valid_usernames.txt"
    echo "  $0 \"kerbrute userenum -d inlanefreight.local --dc 172.16.5.5 /opt/jsmith.txt\" valid_usernames.txt --emails"
    exit 0
}

# Check if help is requested
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    display_help
fi

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <kerbrute_command> <output_list> [--emails]"
    exit 1
fi

# Run the Kerbrute command and save the output to a temporary file
KERBRUTE_COMMAND=$1
OUTPUT_LIST=$2
TEMP_FILE=$(mktemp)
EXTRACT_EMAILS=false

if [ "$#" -eq 3 ] && [ "$3" == "--emails" ]; then
    EXTRACT_EMAILS=true
fi

# Function to display ASCII Art
display_ascii_art() {
    echo "
 _   __          _                _       _   _                                         _    _               _ _ _     _   
 | | / /         | |              | |     | | | |                                       | |  | |             | | (_)   | |  
 | |/ /  ___ _ __| |__  _ __ _   _| |_ ___| | | |___  ___ _ __ ___ _ __  _   _ _ __ ___ | |  | | ___  _ __ __| | |_ ___| |_ 
 |    \ / _ \ '__| '_ \| '__| | | | __/ _ \ | | / __|/ _ \ '__/ _ \ '_ \| | | | '_ \` _ \| |/\| |/ _ \| '__/ _\` | | / __| __|
 | |\  \  __/ |  | |_) | |  | |_| | ||  __/ |_| \__ \  __/ | |  __/ | | | |_| | | | | | \  /\  / (_) | | | (_| | | \__ \ |_ 
 \_| \_/\___|_|  |_.__/|_|   \__,_|\__\___|\___/|___/\___|_|  \___|_| |_|\__,_|_| |_| |_|\/  \/ \___/|_|  \__,_|_|_|___/\__|
                                                                                                                            
                                                                                                                            
    "
}

# Display ASCII Art while running the command
display_ascii_art &
ART_PID=$!

# Notify user about the output format
if $EXTRACT_EMAILS; then
    echo "Storing full email addresses..."
else
    echo "Storing only usernames..."
fi

# Execute the Kerbrute command and save the output, suppressing the output display
eval $KERBRUTE_COMMAND > $TEMP_FILE 2>&1

# Kill the ASCII Art display process
kill $ART_PID 2>/dev/null

# Extract valid usernames from the output
if $EXTRACT_EMAILS; then
    grep '\[+\] VALID USERNAME:' $TEMP_FILE | awk -F':\t' '{print $2}' > $OUTPUT_LIST
else
    grep '\[+\] VALID USERNAME:' $TEMP_FILE | awk -F':\t' '{split($2,a,"@"); print a[1]}' > $OUTPUT_LIST
fi

# Clean up the temporary file
rm $TEMP_FILE

echo "Valid usernames have been saved to $OUTPUT_LIST"
