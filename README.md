# Kerbrute User Enumeration Script

This script executes the Kerbrute command to enumerate valid usernames in an Active Directory environment. While the command is running, an ASCII art is displayed. After the command completes, the valid usernames are saved to a specified file.

## Prerequisites

- Unix-based operating system (Linux, macOS, etc.)
- Kerbrute tool installed and configured
- Bash shell

## Installation

1. Save the script to a file, e.g., `KerbruteUserenumWordlist.sh`.
2. Grant execute permissions to the script:

    ```bash
    chmod +x KerbruteUserenumWordlist.sh
    ```

## Usage

The script requires two arguments:
1. The Kerbrute command to execute.
2. The path to the output file where valid usernames will be saved.

### Example

```bash
./KerbruteUserenumWordlist.sh "kerbrute userenum -d inlanefreight.local --dc 172.16.5.5 /opt/jsmith.txt" valid_usernames.txt
```
