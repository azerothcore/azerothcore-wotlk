#!/bin/bash

# Bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

set -x


# Begin env variables for configuration
#
# Config for this script. Only matters if you're using SAFE_WORLDSERVER
SAFE_WORLDSERVER=${SAFE_WORLDSERVER:-}
ACORE_SKIP_CREATE_ACCOUNT="${ACORE_SKIP_CREATE_ACCOUNT:-}"
ACORE_GM_LEVEL="${ACORE_GM_LEVEL:-3}"
ACORE_USERNAME="${ACORE_USERNAME:-admin}"
ACORE_PASSWORD="${ACORE_PASSWORD:-admin}"
[ grep -qE  "[^a-zA-Z0-9]" <<< "$ACORE_PASSWORD" ] && \
  echo "ACORE_PASSWORD is not alphanumeric. ACORE_PASSWORD should only be letters and numbers. Exiting..." && \
  exit 1
PIPE_NAME="/azerothcore/worldserver-stdin"

# Config for the application itself

MYSQL_HOST="${MYSQL_HOST:-ac-database}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-azerothcore}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
# End env variables for configuration


function send_worldserver_command {
  local command="$1"
  echo "$command" > "$PIPE_NAME"
  echo > "$PIPE_NAME"
}

function safe_shutdown {
  cat << EOF 
#==============================================================================#
#
# Shutting down the WorldServer
#
#==============================================================================#
EOF
  send_worldserver_command "server shutdown 5s 0"

  wait "$(cat "/azerothcore/worldserver.pid")" 
}

CMD="${CMD:=$@}"

# Install configs

conf="/azerothcore/env/dist/etc/$ACORE_COMPONENT.conf" 

[ -f "$conf" ] && \
  # Substitute the configuration with environment variables
  envsubst < "$conf" > "$conf.new" && \
  mv "$conf.new" "$conf"

if [ -n "$SAFE_WORLDSERVER" ] && \
   [ "$ACORE_COMPONENT" == "worldserver" ] && \
   grep -q "$ACORE_COMPONENT" "$CMD" ; then
  trap safe_shutdown SIGTERM SIGINT SIGQUIT

  tmpfile=$(mktemp -u)
  mkfifo "$tmpfile"
  ln -snf "$tmpfile" $PIPE_NAME

  cat << EOF 
#==============================================================================#
# You are using SAFE_WORLDSERVER mode.
#
# Be aware:
#   - You CANNOT use the worldserver console.
#   - All commands must be performed over SOAP, telnet, or by sending them to the named pipe.
#
# Please see [ https://www.azerothcore.org/wiki/remote-access ] for further info.
#==============================================================================#
EOF

  # Make the password safe for stdout
  HIDDEN_PASS=$(tr '[:print:]' '*' <<< "$ACORE_PASSWORD")

  # Start the worldserver
  "$CMD" < \
    "$PIPE_NAME" | sed "s/$ACORE_PASSWORD/$HIDDEN_PASS/" &

  until [ -f "/azerothcore/worldserver.pid" ]; do
    echo "Waiting on the worldserver to start"
    echo > "$PIPE_NAME"
    sleep 1
  done

  if [[ -z "$ACORE_SKIP_CREATE_ACCOUNT" ]]; then
    send_worldserver_command "account create $ACORE_USERNAME $ACORE_PASSWORD"
    send_worldserver_command "account set gmlevel $ACORE_USERNAME $ACORE_GM_LEVEL -1"
  fi
  
  wait "$(cat "/azerothcore/worldserver.pid")"
else 
  exec $CMD
fi
