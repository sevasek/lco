#!/bin/bash
# lco/scripts/install.sh
# Installs the LCO (Low-Cost OpenCode) configuration
# Backs up existing config first

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LCO_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="${HOME}/.config/opencode"
CONFIG_FILE="${CONFIG_DIR}/oh-my-opencode.jsonc"
CONFIG_FILE_NEW="${CONFIG_DIR}/oh-my-openagent.jsonc"
BACKUP_FILE="${CONFIG_DIR}/oh-my-opencode.jsonc.backup-$(date +%Y%m%d-%H%M%S)"
TEMPLATE_FILE="${LCO_DIR}/config/template.jsonc"

echo "=== LCO: Low-Cost OpenCode Configuration Installer ==="
echo ""

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "ERROR: Template not found at $TEMPLATE_FILE"
    exit 1
fi

# Determine which config file exists
if [ -f "$CONFIG_FILE_NEW" ]; then
    EXISTING_CONFIG="$CONFIG_FILE_NEW"
elif [ -f "$CONFIG_FILE" ]; then
    EXISTING_CONFIG="$CONFIG_FILE"
else
    EXISTING_CONFIG=""
fi

# Backup existing config
if [ -n "$EXISTING_CONFIG" ]; then
    echo "Backing up existing config to: $BACKUP_FILE"
    cp "$EXISTING_CONFIG" "$BACKUP_FILE"
    echo "Backup created."
    echo ""
else
    echo "No existing config found, skipping backup."
    echo ""
fi

# Check if we should proceed
echo "This will install the LCO low-cost config template."
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo ""
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# Install new config
echo "Installing LCO config template..."
cp "$TEMPLATE_FILE" "$CONFIG_FILE_NEW"

echo ""
echo "Done! Config installed to: $CONFIG_FILE_NEW"
echo ""
echo "Restart OpenCode to apply changes."
echo ""