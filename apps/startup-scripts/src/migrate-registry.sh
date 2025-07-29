#!/usr/bin/env bash

# One-time migration script for service registry
# Converts old format to new format

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${AC_SERVICE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/azerothcore/services}"
REGISTRY_FILE="$CONFIG_DIR/service_registry.json"
BACKUP_FILE="$CONFIG_DIR/service_registry.json.backup"

# Colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}AzerothCore Service Registry Migration Tool${NC}"
echo "=============================================="

# Check dependencies
if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}Error: jq is required but not installed. Please install jq package.${NC}"
    exit 1
fi

# Check if registry exists
if [ ! -f "$REGISTRY_FILE" ]; then
    echo -e "${YELLOW}No registry file found. Nothing to migrate.${NC}"
    exit 0
fi

# Check if it's already new format
if jq -e '.[0] | has("bin_path")' "$REGISTRY_FILE" >/dev/null 2>&1; then
    echo -e "${GREEN}Registry is already in new format. No migration needed.${NC}"
    exit 0
fi

# Check if it's old format
if ! jq -e '.[0] | has("config")' "$REGISTRY_FILE" >/dev/null 2>&1; then
    echo -e "${YELLOW}Registry format not recognized. Manual review needed.${NC}"
    echo "Current registry content:"
    cat "$REGISTRY_FILE"
    exit 1
fi

echo -e "${YELLOW}Old format detected. Starting migration...${NC}"

# Create backup
cp "$REGISTRY_FILE" "$BACKUP_FILE"
echo -e "${BLUE}Backup created: $BACKUP_FILE${NC}"

# Convert to new format
echo "[]" > "$REGISTRY_FILE.new"

services_migrated=0
while IFS= read -r service; do
    if [ -n "$service" ]; then
        name=$(echo "$service" | jq -r '.name')
        provider=$(echo "$service" | jq -r '.provider')
        type=$(echo "$service" | jq -r '.type')
        config=$(echo "$service" | jq -r '.config // ""')
        
        echo -e "${YELLOW}Migrating service: $name${NC}"
        
        # Create new format entry
        new_entry=$(jq -n \
            --arg name "$name" \
            --arg provider "$provider" \
            --arg type "$type" \
            --arg bin_path "unknown" \
            --arg args "" \
            --arg created "$(date -Iseconds)" \
            --arg status "migrated" \
            --arg legacy_config "$config" \
            '{
                name: $name,
                provider: $provider,
                type: $type,
                bin_path: $bin_path,
                args: $args,
                created: $created,
                status: $status,
                legacy_config: $legacy_config
            }')
        
        # Add to new registry
        jq --argjson entry "$new_entry" '. += [$entry]' "$REGISTRY_FILE.new" > "$REGISTRY_FILE.new.tmp"
        mv "$REGISTRY_FILE.new.tmp" "$REGISTRY_FILE.new"
        
        services_migrated=$((services_migrated + 1))
    fi
done < <(jq -c '.[]' "$BACKUP_FILE")

# Replace old registry with new one
mv "$REGISTRY_FILE.new" "$REGISTRY_FILE"

echo -e "${GREEN}Migration completed successfully!${NC}"
echo -e "${BLUE}Services migrated: $services_migrated${NC}"
echo -e "${BLUE}Use 'service-manager.sh restore' to review and update services.${NC}"
echo -e "${YELLOW}Note: Migrated services have bin_path='unknown' and need manual recreation.${NC}"
echo ""
echo -e "${BLUE}To recreate services, use commands like:${NC}"
echo "  ./service-manager.sh create auth authserver --provider pm2 --bin-path /path/to/your/bin"
echo "  ./service-manager.sh create world worldserver --provider systemd --bin-path /path/to/your/bin"
