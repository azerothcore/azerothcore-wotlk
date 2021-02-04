#!/bin/bash

if [ -n "$START_AS_AUTHSERVER" ]; then
    exec "/azeroth-server/bin/authserver"
fi

exec "$@"