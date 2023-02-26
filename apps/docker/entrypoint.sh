#!/bin/bash

# Bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Begin env variables for configuration
#
# Config for this script. Only matters if you're using SAFE_WORLDSERVER
SAFE_WORLDSERVER="${SAFE_WORLDSERVER:-}"
ACORE_SKIP_CREATE_ACCOUNT="${ACORE_SKIP_CREATE_ACCOUNT:-}"
ACORE_GM_LEVEL="${ACORE_GM_LEVEL:-3}"
ACORE_USERNAME="${ACORE_USERNAME:-admin}"
ACORE_PASSWORD="${ACORE_PASSWORD:-admin}"
grep -qE  "[^a-zA-Z0-9]" <<< "$ACORE_PASSWORD" && \
  echo "ACORE_PASSWORD is not alphanumeric. ACORE_PASSWORD should only be letters and numbers. Exiting..." && \
  exit 1

# Config for the application itself

export MYSQL_HOST="${MYSQL_HOST:-ac-database}"
export MYSQL_USER="${MYSQL_USER:-root}"
export MYSQL_PASSWORD="${MYSQL_PASSWORD:-azerothcore}"
export MYSQL_PORT="${MYSQL_PORT:-3306}"
# End env variables for configuration

CMD="${CMD:=$@}"

# Template env vars into configs

cp -rvn /azerothcore/env/ref/etc/* /azerothcore/env/dist/etc

conf="/azerothcore/env/dist/etc/$ACORE_COMPONENT.conf" 

[ -f "$conf" ] && \
  # Substitute the configuration with environment variables
  envsubst < "$conf" > "$conf.new" && \
  mv "$conf.new" "$conf"

if [ -n "$SAFE_WORLDSERVER" ] && \
   [ "$ACORE_COMPONENT" == "worldserver" ] && \
   grep -q "$ACORE_COMPONENT" <<< "$CMD" ; then
  cat << EOF 
#==============================================================================#
# You are using SAFE_WORLDSERVER mode.
#
# Be aware:
#   - You CANNOT use the worldserver console.
#   - All commands must be performed over SOAP or telnet.
#
# Please see [ https://www.azerothcore.org/wiki/remote-access ] for further info.
#==============================================================================#
EOF

  exec env \
       ACORE_USERNAME="$ACORE_USERNAME" \
       ACORE_PASSWORD="$ACORE_PASSWORD" \
       ACORE_GM_LEVEL="$ACORE_GM_LEVEL" \
       /azerothcore/worldserver.exp
else 
  exec $CMD
fi
