#!/bin/bash
#
# Gotify SSH Notification Script
# This script sends Gotify notifications for different PAM events.
# nano /usr/bin/gotify-ssh-login.sh
# Ensure that the script has execute permissions using the chmod +x /usr/bin/gotify-ssh-login.sh command.
# Add to the end of PAM configuration file (/etc/pam.d/sshd): session optional pam_exec.so /usr/bin/gotify-ssh-login.sh
# The module is included as optional, so that you can still log in if the execution fails. You could change optional to required. However, this will prevent any SSH login unless the script is run successfully.

# Hide script output
exec &> /dev/null

# Gotify configuration
# Fill in the GOTIFY_URL and GOTIFY_TOKEN variables with your actual Gotify server URL and token.
GOTIFY_URL=''
GOTIFY_TOKEN=''

# Function to send Gotify notification
send_notification() {
    local title="$1"
    local message="$2"

    /usr/bin/curl -X POST -s \
        -F "title=${title}" \
        -F "message=${message}" \
        -F "priority=5" \
        "${GOTIFY_URL}/message?token=${GOTIFY_TOKEN}"
}

notify()
{
    host="$(/bin/hostname -f)" # hostname
    hostip="$(hostname -I | awk '{print $1}')" # host ip
    ip="$(dig +short myip.opendns.com @resolver1.opendns.com)" # public IP
    message="User $PAM_USER IP $PAM_RHOST Public IP $ip" # user, IP and Public IP

    # Handle different PAM type events
    if [[ "$PAM_TYPE" == "open_session" ]]; then
        title="SSH Login for $host $hostip"
        send_notification "$title" "$message"

    elif [[ "$PAM_TYPE" == "close_session" ]]; then
        title="SSH Logout for $host $hostip"
        send_notification "$title" "$message"

    elif [[ "$PAM_TYPE" == "auth" ]]; then
        title="Authentication Attempt for $host $hostip"
        send_notification "$title" "$message"
    fi
}

# Run the notification function in the background to prevent holding up the login process
notify &
