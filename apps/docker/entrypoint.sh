#!/bin/bash/entrypoint.sh

# Bash strict mode
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

trap safe_shutdown SIGTERM SIGINT SIGQUIT SIGHUP ERR

# Stupid hack to initiate a safe shutdown (ie, save characters)
function safe_shutdown {
  cat <<EOF > /dev/tcp/127.0.0.1/3443
server shutdown 1s 0
EOF
}

PROGRAM="$@"

"$PROGRAM" 2>&1 &

PROGRAM_PID="$!"

wait "$PROGRAM_PID"

