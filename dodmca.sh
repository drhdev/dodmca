#!/bin/bash

# dodmca.sh
# version: 0.1
# author: drhdev
# license: GNU Public License
# This script logs into an email account via IMAP, checks for new emails that meet certain criteria,
# and processes them according to the user's specifications. 
# Installation: Ensure you have mailutils, mutt, and necessary permissions set up for IMAP access and executing this script.

# Default configurations
EMAIL_ADDRESS=""
IMAP_SERVER=""
IMAP_PORT=""
PASSWORD=""
SEARCH_SENDER="digitalocean"
SEARCH_SUBJECT="abuse|ticket|dmca|copyright|infringement|ref:"
SEARCH_BODY="Security Operations Center"
SEND_TO_TELEGRAM="off"
TEXT_FILE_PATH="/var/log/dodmca/"
MAX_FILES=10
LOG_FILE="/var/log/dodmca.log"
VERBOSE="silent"

# Parse command line options for configurations
while getopts ":e:s:p:w:k:l:m:n:o:q:r:t:u:v:" opt; do
  case ${opt} in
    e ) EMAIL_ADDRESS=$OPTARG ;;
    s ) IMAP_SERVER=$OPTARG ;;
    p ) IMAP_PORT=$OPTARG ;;
    w ) PASSWORD=$OPTARG ;;
    k ) SEARCH_SENDER=$OPTARG ;;
    l ) SEARCH_SUBJECT=$OPTARG ;;
    m ) SEARCH_BODY=$OPTARG ;;
    n ) SEND_TO_TELEGRAM=$OPTARG ;;
    o ) TEXT_FILE_PATH=$OPTARG ;;
    q ) MAX_FILES=$OPTARG ;;
    r ) LOG_FILE=$OPTARG ;;
    t ) VERBOSE=$OPTARG ;;
    \? ) echo "Usage: cmd [-e] email [-s] server [-p] port [-w] password" 
         exit 1 ;;
  esac
done

# Function to log messages
log_message() {
    if [ "$VERBOSE" == "verbose" ]; then
        echo "$1"
    fi
    if [ -n "$LOG_FILE" ]; then
        echo "$(hostname) - $(date): $1" >> "$LOG_FILE"
    fi
}

log_message "Starting dodmca.sh script."

# Check for required commands
command -v mutt >/dev/null 2>&1 || { log_message "Mutt is not installed. Aborting."; exit 1; }
command -v mail >/dev/null 2>&1 || { log_message "Mailutils is not installed. Aborting."; exit 1; }

# Ensure the text file directory exists
mkdir -p "$TEXT_FILE_PATH"

# Processing emails
process_emails() {
    local temp_file=$(mktemp)
    
    # Login and fetch emails command here. This is a placeholder command.
    # You need to replace this with actual command(s) to fetch emails from your IMAP server.
    # For security reasons, direct password usage in scripts is discouraged. Consider using a secure method for authentication.
    
    # Example placeholder:
    # fetchmail --sslcertck --sslcertpath /etc/ssl/certs -u "$EMAIL_ADDRESS" --password "$PASSWORD" -S "$IMAP_SERVER":"$IMAP_PORT"
    
    # Placeholder loop to simulate email processing
    for email in "${emails[@]}"; do
        # Your email processing logic here
        
        # Check conditions and write to file if met
        if [ condition_met ]; then
            local filename="${TEXT_FILE_PATH}dodmca_$(date +%Y%m%d%H%M%S).txt"
            echo "Hostname: $(hostname)" > "$filename"
            # Add sender, subject, and body to the file
            echo "Received: $(date)" >> "$filename"
            
            if [ "$SEND_TO_TELEGRAM" == "on" ]; then
                ./totelgram.sh -message "$filename" --verbose
            fi
        fi
    done
    
    # Clean up old files
    if [ "$(ls -1q $TEXT_FILE_PATH | wc -l)" -gt "$MAX_FILES" ]; then
        ls -tp | grep -v '/$' | tail -n +$((MAX_FILES + 1)) | xargs -I {} rm -- {}
    fi
    
    rm "$temp_file"
}

# Main
process_emails

log_message "dodmca.sh script finished."
