#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <kerbrute_command> <output_list>"
    exit 1
fi

# Run the Kerbrute command and save the output to a temporary file
KERBRUTE_COMMAND=$1
OUTPUT_LIST=$2
TEMP_FILE=$(mktemp)

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

# Execute the Kerbrute command and save the output, suppressing the output display
eval $KERBRUTE_COMMAND > $TEMP_FILE 2>&1

# Kill the ASCII Art display process
kill $ART_PID 2>/dev/null

# Extract valid usernames from the output
grep '\[+\] VALID USERNAME:' $TEMP_FILE | awk -F':\t' '{print $2}' > $OUTPUT_LIST

# Clean up the temporary file
rm $TEMP_FILE

echo "Valid usernames have been saved to $OUTPUT_LIST"