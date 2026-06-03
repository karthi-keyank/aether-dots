#!/bin/bash

LOG_FILE="$HOME/.config/hypr/scripts/gammastep.log"
exec >> "$LOG_FILE" 2>&1

echo "------------------------------"
echo "Time: $(date)"

# Ensure environment
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

APP_NAME="Gammastep"
ICON_ON="weather-clear-night"
ICON_OFF="weather-clear"

# Prevent spam/race
LOCK_FILE="/tmp/gammastep-toggle.lock"
if [ -f "$LOCK_FILE" ]; then
    echo "Blocked: already running"
    exit 0
fi
trap "rm -f $LOCK_FILE" EXIT
touch "$LOCK_FILE"

if pgrep -x gammastep > /dev/null; then
    echo "Stopping gammastep"
    pkill -x gammastep
    sleep 0.2
    notify-send -a "$APP_NAME" -i "$ICON_OFF" "Night Mode Disabled"
else
    echo "Starting gammastep"
    gammastep -O 4500 &
    sleep 0.2
    notify-send -a "$APP_NAME" -i "$ICON_ON" "Night Mode Enabled"
fi

echo "Done"