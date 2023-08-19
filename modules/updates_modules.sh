#!/bin/bash
set -euo pipefail

for i in ./*; do
    if [[ -d "$i" ]]; then
        git -C "$i" config pull.rebase false
        git -C "$i" pull origin "$(git rev-parse --abbrev-ref HEAD)"
    fi
done
