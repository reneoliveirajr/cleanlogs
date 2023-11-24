#!/bin/bash

# Compatibility Note:
# This script is designed for Linux systems based on common distributions like Ubuntu.
# Ensure compatibility with your specific system before use. Use with caution and proper permissions.

# Check if the current user is the superuser (root)
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as the superuser (root)."
    exit 1
fi

# List of log files to be deleted
log_files=(
    "syslog"
    "auth.log"
    "dmesg"
    "kern.log"
    "apt/history.log"
    "apt/term.log"
    "ufw.log"
    "faillog"
    "lastlog"
    "nginx/access.log"
    "nginx/error.log"
    "apache2/access.log"
    "apache2/error.log"
    "mail.log"
    "mail.err"
)

# Delete log files
for log_file in "${log_files[@]}"; do
    full_path="/var/log/$log_file"
    if [ -f "$full_path" ]; then
        rm -f "$full_path"
        echo "Deleted: $full_path"
    fi
done

# Clear command history for all users
for user in $(getent passwd | cut -d: -f1); do
    history_file="/home/$user/.bash_history"
    if [ -f "$history_file" ]; then
        rm -f "$history_file"
        echo "Cleared history for user: $user"
    fi
done

echo "Operation completed."
