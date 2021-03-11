#!/bin/bash
set -e
#set -x

TTYD_ARGS="login"

# Check if this is the container's first run
if [ -f /etc/.firstrun ]; then
    # Create user account
    adduser -D --shell=/bin/bash $USERNAME

    # Add a password to the user
    echo "$USERNAME:$PASSWORD" | chpasswd

    # Allow access to sudo if permitted
    if [ $SUDO_OK == "true" ]; then
        addgroup $USERNAME wheel
        sed -i '/%wheel ALL=(ALL) ALL/s/^# //g' /etc/sudoers
    fi

    # Prevent this from running again
    rm -f /etc/.firstrun
fi

# Auto login the user, if allowed
[ $AUTOLOGIN == "true" ] && TTYD_ARGS="$TTYD_ARGS -f $USERNAME"

# Start ttyd
exec ttyd $TTYD_ARGS "$@"

