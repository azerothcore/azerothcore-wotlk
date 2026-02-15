#!/usr/bin/env bats
# Test for Slaves to Saronite RP scripting (Issue #24157)
# Validates data/sql/updates/pending_db_world/rev_slaves_to_saronite_rp.sql content

# Project root: apps/ci/test -> apps/ci -> apps -> repo root
REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/../../.." && pwd)"
PENDING_WORLD="${REPO_ROOT}/data/sql/updates/pending_db_world"
SQL_FILE="${PENDING_WORLD}/rev_slaves_to_saronite_rp.sql"

setup() {
    # Optional: also check in db_world in case file was already imported
    if [[ ! -f "$SQL_FILE" ]]; then
        LATEST_REV="$(find "${REPO_ROOT}/data/sql/updates/db_world" -maxdepth 1 -name "*.sql" -exec grep -l "Slaves to Saronite RP scripting" {} \; 2>/dev/null | sort -r | head -1)"
        if [[ -n "$LATEST_REV" && -f "$LATEST_REV" ]]; then
            export SQL_FILE="$LATEST_REV"
        fi
    fi
}

@test "Slaves to Saronite: SQL file exists (pending or imported)" {
    [[ -f "$SQL_FILE" ]]
}

@test "Slaves to Saronite: references Issue #24157" {
    grep -q '24157' "$SQL_FILE"
}

@test "Slaves to Saronite: gossip script includes third outcome 3139702" {
    grep -q 'action_param3.*3139702' "$SQL_FILE"
    grep -q 'entryorguid.*31397.*event_type.*62' "$SQL_FILE"
}

@test "Slaves to Saronite: pit script 3139702 has required actions" {
    grep -q '3139702,9,0,' "$SQL_FILE"   # close gossip (action 72)
    grep -q '33,31866,0,0,0,0,0,7,' "$SQL_FILE"  # quest credit
    grep -q '3139702,9,3,' "$SQL_FILE"   # yell group 0
    grep -q '3139702,9,5,' "$SQL_FILE"   # move to pit (69)
    grep -q '3139702,9,6,' "$SQL_FILE" && grep -q '97,15,15' "$SQL_FILE"   # jump
}

@test "Slaves to Saronite: frenzy emote (GroupID 2) for hostile behavior" {
    grep -q 'CreatureID.*31397.*GroupID.*2' "$SQL_FILE"
    grep -q 'goes into a frenzy' "$SQL_FILE"
    grep -q 'Emote (GroupID 2' "$SQL_FILE"
}

@test "Slaves to Saronite: hostile script 3139701 uses emote (say group 2)" {
    grep -q '3139701,9,2,' "$SQL_FILE"
    grep -q 'GroupID 2 - frenzy' "$SQL_FILE"
}

@test "Slaves to Saronite: creature_text GroupID 1 language Universal" {
    grep -q 'Language.*0' "$SQL_FILE" && grep -q '31397.*GroupID.*1' "$SQL_FILE"
}

@test "Slaves to Saronite: spell_area for whisper aura in Icecrown" {
    grep -q '27769' "$SQL_FILE"
    grep -q '210' "$SQL_FILE"
    grep -q 'spell_area' "$SQL_FILE"
}
