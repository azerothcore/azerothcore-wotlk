#!/usr/bin/env bash
# ============================================================================
# Live-inject Faegrim's hard-CC immunity profile.
#
# Applies the same rows as the persistent migration
# (modules/mod-blackrose/data/sql/db-world/2026_05_24_09_blackrose_boss_immunities.sql)
# directly against the running acore_world DB and prints the GM commands
# you need to issue in-game (or via SOAP) so the live boss instance picks
# up the new profile WITHOUT a worldserver restart.
#
# Usage:
#   ./tools/inject_faegrim_immunity.sh
#   ./tools/inject_faegrim_immunity.sh --host 127.0.0.1 --user acore --password acore
# ============================================================================

set -euo pipefail

DB_HOST="${DB_HOST:-127.0.0.1}"
DB_USER="${DB_USER:-acore}"
DB_PASS="${DB_PASS:-acore}"
DB_NAME="${DB_NAME:-acore_world}"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --host)     DB_HOST="$2"; shift 2 ;;
        --user)     DB_USER="$2"; shift 2 ;;
        --password) DB_PASS="$2"; shift 2 ;;
        --db)       DB_NAME="$2"; shift 2 ;;
        *) echo "unknown arg: $1" >&2; exit 2 ;;
    esac
done

MIGRATION="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/modules/mod-blackrose/data/sql/db-world/2026_05_24_09_blackrose_boss_immunities.sql"

if [[ ! -f "$MIGRATION" ]]; then
    echo "missing migration: $MIGRATION" >&2
    exit 1
fi

echo "==> applying $MIGRATION to $DB_USER@$DB_HOST/$DB_NAME"
mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$MIGRATION"

echo
echo "==> verifying"
mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -t -e "
SELECT entry, name, CreatureImmunitiesId FROM creature_template WHERE entry = 900200;
SELECT ID, MechanicsMask, Comment FROM creature_immunities WHERE ID = 900200;
"

cat <<'EOF'

==> DB is updated. Now apply to the running worldserver (no restart needed).
==> In-game as a GM (or via SOAP), run these in order:

   .reload creature_immunities
   .reload creature_template

   # find the live Faegrim:
   .gonpc 900200          # teleport to him, OR
   .npc near 100          # list nearby NPCs, target him manually

   # then refresh his immunity state by respawning the targeted instance:
   .respawn

After .respawn the running boss is re-pulled from the (now updated)
creature_template and re-applies the new MechanicsMask via
Creature::LoadTemplateImmunities(). No world restart required.

To test:
   - Try to fear/stun/polymorph him   -> should show "Immune"
   - Try to slow him (Hamstring, frost spell) -> should land normally

EOF
