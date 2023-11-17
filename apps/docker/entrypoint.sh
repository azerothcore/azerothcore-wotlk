#!/usr/bin/env bash
set -euo pipefail

# Copy all default config files to env/dist/etc if they don't already exist
# -r == recursive
# -n == no clobber (don't overwrite)
# -v == be verbose
cp -rnv /azerothcore/env/ref/etc/* /azerothcore/env/dist/etc

CONF="/azerothcore/env/dist/etc/$ACORE_COMPONENT.conf"
CONF_DIST="/azerothcore/env/dist/etc/$ACORE_COMPONENT.conf.dist"

# Copy the "dist" file to the "conf" if the conf doesn't already exist
if [[ -f "$CONF_DIST" ]]; then
    cp -vn "$CONF_DIST" "$CONF"
else
    touch "$CONF"
fi

echo "Starting $ACORE_COMPONENT..."

exec "$@"
