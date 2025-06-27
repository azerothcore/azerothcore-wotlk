#!/bin/bash
set -euo pipefail

read -p "Enter MySQL username: " DB_USER
read -p "Enter MySQL password: " DB_PASS
echo ""
read -p "Enter MySQL host (default: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}
read -p "Enter MySQL port (default: 3306): " DB_PORT
DB_PORT=${DB_PORT:-3306}

# Prompt for database names
read -p "Enter name of Auth database [default: db_auth]: " DB_AUTH
DB_AUTH=${DB_AUTH:-db_auth}
read -p "Enter name of Characters database [default: db_characters]: " DB_CHARACTERS
DB_CHARACTERS=${DB_CHARACTERS:-db_characters}
read -p "Enter name of World database [default: db_world]: " DB_WORLD
DB_WORLD=${DB_WORLD:-db_world}

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
  mkdir -p "$FOLDER_NAME"

  TABLES=$(mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" -N -e "SHOW TABLES FROM \`$DB_NAME\`;")
  
  if [[ -z "$TABLES" ]]; then
    echo "⚠️  No tables found or failed to connect to '$DB_NAME'. Skipping."
    continue
  fi

  while IFS= read -r raw_table; do
    TABLE=$(echo "$raw_table" | tr -d '\r"' | xargs)
    if [[ -n "$TABLE" ]]; then
      echo "  ➤ Dumping table: $TABLE"
      mysqldump -u $DB_USER -p$DB_PASS -h $DB_HOST -P $DB_PORT --extended-insert $DB_NAME $TABLE > $DB_NAME/$TABLE.sql

      # cleanup files
      sed -E '
        s/VALUES/VALUES\n/;
        :a
        s/\),\(/\),\n\(/g;
        ta
      ' "$DB_NAME/$TABLE.sql" > "$DB_NAME/${TABLE}_formatted.sql"
      mv "$DB_NAME/${TABLE}_formatted.sql" "$DB_NAME/$TABLE.sql"
    fi
  done <<< "$TABLES"
done

echo "✅ Done dumping all specified databases."
