#!/bin/bash
set -euo pipefail

read -p "Enter MySQL username: " DB_USER

read -p "Enter MySQL password: " DB_PASS
echo ""

read -p "Enter MySQL host (default: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "Enter MySQL port (default: 3306): " DB_PORT
DB_PORT=${DB_PORT:-3306}

read -p "Enter database names (space separated) (default: acore_auth acore_characters acore_world): " -a DBS
if [[ ${#DBS[@]} -eq 0 ]]; then
  DBS=(acore_auth acore_characters acore_world)
fi

if [[ ${#DBS[@]} -eq 0 ]]; then
  echo "No databases entered. Exiting."
  exit 1
fi

for DB_NAME in "${DBS[@]}"; do
  echo "Dumping database: $DB_NAME"
  mkdir -p "$DB_NAME"

  TABLES=$(mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -P "$DB_PORT" -N -e "SHOW TABLES FROM \`$DB_NAME\`;")

  if [[ -z "$TABLES" ]]; then
    echo "⚠️ No tables found or failed to connect to database '$DB_NAME'. Skipping."
    continue
  fi

  while IFS= read -r raw_table; do
    TABLE=$(echo "$raw_table" | tr -d '\r"' | xargs)
    if [[ -n "$TABLE" ]]; then
      echo "  Dumping table: $TABLE"
      mysqldump -u $DB_USER -p$DB_PASS -h $DB_HOST -P $DB_PORT --extended-insert $DB_NAME $TABLE > $DB_NAME/$TABLE.sql
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
