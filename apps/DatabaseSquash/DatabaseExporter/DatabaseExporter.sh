#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

if [[ "$PROJECT_ROOT" =~ ^/([a-zA-Z])/(.*) ]]; then
  DRIVE_LETTER="${BASH_REMATCH[1]}"
  PATH_REMAINDER="${BASH_REMATCH[2]}"
  PROJECT_ROOT="${DRIVE_LETTER^^}:/${PATH_REMAINDER}"
fi

BASE_OUTPUT_DIR="$PROJECT_ROOT/data/sql/base"

read -p "Enter MySQL username: " DB_USER
read -p "Enter MySQL password: " DB_PASS
read -p "Enter MySQL host (default: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}
read -p "Enter MySQL port (default: 3306): " DB_PORT
DB_PORT=${DB_PORT:-3306}

# Prompt for database names
read -p "Enter name of Auth database [default: acore_auth]: " DB_AUTH
DB_AUTH=${DB_AUTH:-acore_auth}
read -p "Enter name of Characters database [default: acore_characters]: " DB_CHARACTERS
DB_CHARACTERS=${DB_CHARACTERS:-acore_characters}
read -p "Enter name of World database [default: acore_world]: " DB_WORLD
DB_WORLD=${DB_WORLD:-acore_world}

# Mapping for folder names
declare -A DB_MAP=(
  ["$DB_AUTH"]="db_auth"
  ["$DB_CHARACTERS"]="db_characters"
  ["$DB_WORLD"]="db_world"
)

# Dump each database
for DB_NAME in "${!DB_MAP[@]}"; do
  FOLDER_NAME="${DB_MAP[$DB_NAME]}"
  echo "📦 Dumping database '$DB_NAME' into folder '$FOLDER_NAME'"
  echo "$BASE_OUTPUT_DIR/$FOLDER_NAME"
  mkdir -p "$BASE_OUTPUT_DIR/$FOLDER_NAME"

  TABLES=$(mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" -N -e "SHOW TABLES FROM \`$DB_NAME\`;")
  
  if [[ -z "$TABLES" ]]; then
    echo "⚠️  No tables found or failed to connect to '$DB_NAME'. Skipping."
    continue
  fi

  while IFS= read -r raw_table; do
    TABLE=$(echo "$raw_table" | tr -d '\r"' | xargs)
    if [[ -n "$TABLE" ]]; then
      echo "  ➤ Dumping table: $TABLE"
      # --skip-tz-utc needed to keep TIMESTAMP values as-is
      mysqldump -u $DB_USER -p$DB_PASS -h $DB_HOST -P $DB_PORT --skip-tz-utc --extended-insert $DB_NAME $TABLE > $BASE_OUTPUT_DIR/$FOLDER_NAME/$TABLE.sql

      # cleanup files
      sed -E '
        s/VALUES[[:space:]]*/VALUES\n/;
        :a
        s/\),\(/\),\n\(/g;
        ta
      ' "$BASE_OUTPUT_DIR/$FOLDER_NAME/$TABLE.sql" > "$BASE_OUTPUT_DIR/$FOLDER_NAME/${TABLE}_formatted.sql"
      mv "$BASE_OUTPUT_DIR/$FOLDER_NAME/${TABLE}_formatted.sql" "$BASE_OUTPUT_DIR/$FOLDER_NAME/$TABLE.sql"
    fi
  done <<< "$TABLES"
done

echo "✅ Done dumping all specified databases."
