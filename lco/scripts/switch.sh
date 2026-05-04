#!/bin/bash
# lco/scripts/switch.sh
# Switches between different LCO configurations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LCO_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="${HOME}/.config/opencode"
BACKUP_DIR="${CONFIG_DIR}/backups"

CONFIG_FILE_NEW="${CONFIG_DIR}/oh-my-openagent.jsonc"

echo "=== LCO Configuration Switcher ==="
echo ""

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup current config before switching
if [ -f "$CONFIG_FILE_NEW" ]; then
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    BACKUP_FILE="${BACKUP_DIR}/oh-my-openagent.jsonc.backup-${TIMESTAMP}"
    echo "Backing up current config to: $BACKUP_FILE"
    cp "$CONFIG_FILE_NEW" "$BACKUP_FILE"
fi

# List available configs
echo "Available configurations in ${LCO_DIR}/config/:"
echo ""
CONFIG_DIR_PATH="${LCO_DIR}/config"
if [ "$(ls -A "$CONFIG_DIR_PATH" 2>/dev/null)" ]; then
    select CONFIG in "$(ls "$CONFIG_DIR_PATH"/*.jsonc 2>/dev/null)" "Exit (no change)"; do
        if [ "$CONFIG" = "Exit (no change)" ] || [ "$CONFIG" = "" ]; then
            echo "No change made."
            exit 0
        fi

        SELECTED_FILE="$CONFIG"
        break
    done
else
    echo "No configurations found in ${CONFIG_DIR_PATH}/"
    exit 1
fi

# Install selected config
if [ -n "$SELECTED_FILE" ] && [ -f "$SELECTED_FILE" ]; then
    echo ""
    echo "Installing: $SELECTED_FILE"
    cp "$SELECTED_FILE" "$CONFIG_FILE_NEW"
    echo ""
    echo "Switched successfully. Restart OpenCode to apply."
else
    echo "ERROR: Invalid selection"
    exit 1
fi