#!/bin/bash
set -e
#set -x

TTYD_ARGS="login"

# Check if this is the container's first run
if [ -f /etc/.firstrun ]; then
    # Create user account
    adduser -D --shell=/bin/bash $TTYD_USERNAME

    # Add a password to the user
    echo "$TTYD_USERNAME:$TTYD_PASSWORD" | chpasswd

    # Allow access to sudo if permitted
    if [ $TTYD_SUDO == "true" ]; then
        addgroup $TTYD_USERNAME wheel
        sed -i '/%wheel ALL=(ALL) ALL/s/^# //g' /etc/sudoers
    fi

    # Prevent this from running again
    rm -f /etc/.firstrun
fi

# Auto login the user, if allowed
[ $TTYD_AUTOLOGIN == "true" ] && TTYD_ARGS="$TTYD_ARGS -f $TTYD_USERNAME"

# Start ttyd
exec ttyd $TTYD_ARGS "$@"

