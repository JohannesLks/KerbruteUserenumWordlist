# Kerbrute User Enumeration Script

This script executes the Kerbrute command to enumerate valid usernames in an Active Directory environment. After the command completes, the valid usernames are saved to a specified file. This script is based on a Use-Case in Hack The Box.

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
3. An optional `--emails` flag to indicate if full email addresses should be saved instead of just usernames.

### Example

#### Save Only Usernames

```bash
./KerbruteUserenumWordlist.sh "kerbrute userenum -d inlanefreight.local --dc 172.16.5.5 /usr/share/seclists/Usernames/top-usernames-shortlist.txt" valid_usernames.txt
```

#### Save Full Email Addresses

```bash
./KerbruteUserenumWordlist.sh "kerbrute userenum -d inlanefreight.local --dc 172.16.5.5 /usr/share/seclists/Usernames/top-usernames-shortlist.txt" valid_usernames.txt --emails
```

