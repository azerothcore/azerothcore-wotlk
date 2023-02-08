#!/bin/bash

# Bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Begin env variables for configuration
#
# Config for this script. Only matters if you're using SAFE_WORLDSERVER
ACORE_GM_LEVEL="${ACORE_GM_LEVEL:-3}"
ACORE_USERNAME="${ACORE_USERNAME:-admin}"
ACORE_PASSWORD="${ACORE_USERNAME:-}"
#
# Config for the application itself
MYSQL_HOST="${MYSQL_HOST:-ac-database}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-azerothcore}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
# End env variables for configuration

# Apply variables to conf

function send_worldserver_command {
  command="$1"
  screen -S worldserver -p 0 -X stuff $"$command\r"
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
}

# Ok, you're logging the screen to a file
# What if it gets too big?
function logfile_prune {
  (
    while true; do
      sleep 3600
      truncate -s <1M screenlog.0
    done
  ) &
}

PROGRAM="$@"

# Install configs

cp -avn env/ref/etc/* env/dist/etc

if [ -z "${SAFE_WORLDSERVER:-}" ] && \
   [ "$ACORE_COMPONENT" == "worldserver" ] && \
   [ "$PROGRAM" =~ ".*/?$ACORE_COMPONENT" ] ; then
  trap safe_shutdown SIGTERM SIGINT SIGQUIT SIGHUP ERR

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

  # Make the password safe for stdout
  HIDDEN_PASS=$(tr '[:print:]' '*' <<< "$ACORE_PASSWORD")

  # Spit worldserver output to the screen
  touch "screenlog.0"
  (tail -f "screenlog.0" | sed "s/$ACORE_PASSWORD/$HIDDEN_PASS/") &

  # Start the worldserver in a screen
  screen -AmDSL worldserver "${AC_WORLDSERVER_BINARY:-$PROGRAM}" &

  PROGRAM_PID="$!"


  until grep -q "World Initialized" screenlog.0; do
    cat << EOF
#==============================================================================#
#
# Waiting for the WorldServer to Initialize 
#
#==============================================================================#
EOF
    sleep 3
  done

  printf "Creating account\n"

  send_worldserver_command "account create $ACORE_USERNAME $ACORE_PASSWORD"
  send_worldserver_command "account set gmlevel $ACORE_USERNAME $ACORE_GM_LEVEL -1"

  logfile_prune
  wait "$PROGRAM_PID"
else 
  exec $PROGRAM
fi
