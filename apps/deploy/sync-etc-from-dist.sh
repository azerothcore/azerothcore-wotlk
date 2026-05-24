#!/usr/bin/env bash
# Seed env/dist/etc/*.conf from repo *.conf.dist when missing, so Docker
# bind-mounts have files on first deploy. Does NOT overwrite existing .conf
# unless SYNC_ETC_FORCE=1 (avoids resetting SOAP, rates, etc. every deploy).
#
# Database and paths: docker-compose sets AC_* env vars; those override file
# values at runtime where supported.
#
# Template resolution (first match wins):
#   - Full tree: src/server/apps/{worldserver,authserver}/*.conf.dist
#   - Slim VPS:  apps/deploy/templates/*.conf.dist (same content; no src/)
# If no template exists but live env/dist/etc/*.conf already does, we keep it
# and exit 0 so CI deploy can run on minimal checkouts.
#
# Intentional full reset from templates:
#   SYNC_ETC_FORCE=1 bash apps/deploy/sync-etc-from-dist.sh .

set -euo pipefail

repo_root="${1:-.}"
cd "$repo_root"

etc_dir="env/dist/etc"
world_dst="$etc_dir/worldserver.conf"
auth_dst="$etc_dir/authserver.conf"

pick_first_file() {
  local f
  for f in "$@"; do
    if [[ -f "$f" ]]; then
      echo "$f"
      return 0
    fi
  done
  return 1
}

force=0
if [[ "${SYNC_ETC_FORCE:-}" == "1" || "${SYNC_ETC_FORCE:-}" == "true" ]]; then
  force=1
fi

world_src=""
if world_src=$(pick_first_file \
  "src/server/apps/worldserver/worldserver.conf.dist" \
  "apps/deploy/templates/worldserver.conf.dist"); then
  :
else
  world_src=""
fi

auth_src=""
if auth_src=$(pick_first_file \
  "src/server/apps/authserver/authserver.conf.dist" \
  "apps/deploy/templates/authserver.conf.dist"); then
  :
else
  auth_src=""
fi

mkdir -p "$etc_dir"

if [[ -z "$world_src" ]]; then
  if [[ -f "$world_dst" ]]; then
    echo "sync-etc-from-dist: no world template (no src/ or apps/deploy/templates); keeping $world_dst" >&2
  else
    echo "sync-etc-from-dist: missing world template (tried src/... and apps/deploy/templates/...)" >&2
    exit 1
  fi
else
  if [[ "$force" -eq 1 ]] || [[ ! -f "$world_dst" ]]; then
    cp -f "$world_src" "$world_dst"
    echo "sync-etc-from-dist: wrote $world_dst (from $world_src)"
  else
    echo "sync-etc-from-dist: skip $world_dst (exists; SYNC_ETC_FORCE=1 to replace)"
  fi
fi

if [[ -n "$auth_src" ]]; then
  if [[ "$force" -eq 1 ]] || [[ ! -f "$auth_dst" ]]; then
    cp -f "$auth_src" "$auth_dst"
    echo "sync-etc-from-dist: wrote $auth_dst (from $auth_src)"
  else
    echo "sync-etc-from-dist: skip $auth_dst (exists; SYNC_ETC_FORCE=1 to replace)"
  fi
elif [[ -f "$auth_dst" ]]; then
  echo "sync-etc-from-dist: no auth template; keeping $auth_dst" >&2
fi

# Skip lines above are normal — live edits keep your .conf; pipeline does not overwrite.
echo "sync-etc-from-dist: ok"
