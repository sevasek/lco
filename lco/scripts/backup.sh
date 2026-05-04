#!/bin/bash
# lco/scripts/backup.sh
# Creates a timestamped backup of current OpenCode config

set -e

CONFIG_DIR="${HOME}/.config/opencode"
CONFIG_FILE="${CONFIG_DIR}/oh-my-opencode.jsonc"
CONFIG_FILE_NEW="${CONFIG_DIR}/oh-my-openagent.jsonc"
BACKUP_DIR="${CONFIG_DIR}/backups"

# Determine which config file exists
if [ -f "$CONFIG_FILE_NEW" ]; then
    EXISTING_CONFIG="$CONFIG_FILE_NEW"
    CONFIG_NAME="oh-my-openagent.jsonc"
elif [ -f "$CONFIG_FILE" ]; then
    EXISTING_CONFIG="$CONFIG_FILE"
    CONFIG_NAME="oh-my-opencode.jsonc"
else
    echo "ERROR: No config file found in $CONFIG_DIR"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create backup with timestamp
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/${CONFIG_NAME}.backup-${TIMESTAMP}"

echo "=== LCO Backup Script ==="
echo ""
echo "Backing up: $EXISTING_CONFIG"
echo "To: $BACKUP_FILE"
echo ""

cp "$EXISTING_CONFIG" "$BACKUP_FILE"

echo "Backup created successfully."
echo ""
echo "Available backups:"
ls -la "$BACKUP_DIR" | grep "$CONFIG_NAME"