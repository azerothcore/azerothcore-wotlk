#!/usr/bin/env bash

echo "❗CAUTION"
echo "This tool is only supposed to be used by AzerothCore Maintainers."
echo "The tool is used to prepare for, and generate a database squash."
echo
echo "Before you continue make sure you have read"
echo "https://github.com/azerothcore/azerothcore-wotlk/blob/master/data/sql/base/database-squash.md"
echo
read -p "Are you sure you want to continue (Y/N)?" choice
case "$choice" in
  y|Y ) echo "Starting...";;
  * ) echo "Aborted"; exit 0 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

if [[ "$PROJECT_ROOT" =~ ^/([a-zA-Z])/(.*) ]]; then
  DRIVE_LETTER="${BASH_REMATCH[1]}"
  PATH_REMAINDER="${BASH_REMATCH[2]}"
  PROJECT_ROOT="${DRIVE_LETTER^^}:/${PATH_REMAINDER}"
fi

VERSION_UPDATER_PATH="$PROJECT_ROOT/apps/DatabaseSquash/VersionUpdater/versionupdater.sh"

"$VERSION_UPDATER_PATH"

echo "✅ VersionUpdater Completed..."
echo
echo "❗IMPORTANT!"
echo "1. Before you continue you need to drop all your databases."
echo "2. Run WorldServer to populate the database."
echo
echo "❗DO NOT continue before you have completed the steps above!"
echo
echo "The next step will export your database and overwrite the base files."
echo
read -p "Are you sure you want to export your database (Y/N)?" choice
case "$choice" in
  y|Y ) echo "Starting...";;
  * ) echo "Aborted"; exit 0 ;;
esac

DATABASE_EXPORTER_PATH="$PROJECT_ROOT/apps/DatabaseSquash/DatabaseExporter/databaseexporter.sh"

"$DATABASE_EXPORTER_PATH"

echo "✅ DatabaseExporter Completed..."
echo "✅ DatabaseSquash Completed... "
echo
read -p "Press Enter to exit..."
