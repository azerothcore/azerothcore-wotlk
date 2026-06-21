#!/usr/bin/env bash
#
# core-purity.sh -- enforce the pure-core / adapter split (ARCHITECTURE.md §2).
#
# Nothing under src/core/ may depend on AzerothCore. The cores are plain C++20 + STL and are
# unit-tested standalone (tests/standalone). The moment a core file pulls in an AzerothCore header
# it stops being portable and the fast standalone test build breaks.
#
# Rule enforced: every quoted #include in src/core/ must resolve to a header that actually exists
# somewhere under src/core/. Anything else -- e.g. "Player.h", "ScriptMgr.h", "Config.h" -- is a
# violation. Angle-bracket includes are taken to be the C/C++ standard library (the cores use only
# <cstdint>, <algorithm>, <cmath>, <array>, ...).
#
# Usage: tools/core-purity.sh [CORE_DIR]
#   CORE_DIR defaults to <module-root>/src/core relative to this script.
#
# Exit 0 = pure; exit 1 = at least one violation (printed as file:line); exit 2 = bad invocation.

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
MODULE_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd)"
CORE_DIR="${1:-${MODULE_ROOT}/src/core}"

if [[ ! -d "${CORE_DIR}" ]]; then
    echo "core-purity: directory not found: ${CORE_DIR}" >&2
    exit 2
fi

# Index every header basename that legitimately lives in the core tree.
declare -A CORE_HEADERS=()
while IFS= read -r -d '' header; do
    CORE_HEADERS["$(basename "${header}")"]=1
done < <(find "${CORE_DIR}" -type f \( -name '*.h' -o -name '*.hpp' \) -print0)

violations=0

# Walk every quoted #include in the core and check its basename is a known core header.
while IFS= read -r line; do
    file="${line%%:*}"
    rest="${line#*:}"
    lineno="${rest%%:*}"
    inc="$(printf '%s\n' "${line}" | sed -E 's/.*#[[:space:]]*include[[:space:]]*"([^"]+)".*/\1/')"
    base="$(basename "${inc}")"
    if [[ -z "${CORE_HEADERS[${base}]:-}" ]]; then
        echo "CORE-PURITY VIOLATION: ${file}:${lineno} includes \"${inc}\" (not a src/core/ header -- looks like an AzerothCore dependency)" >&2
        violations=$((violations + 1))
    fi
done < <(grep -rEn '#[[:space:]]*include[[:space:]]*"[^"]+"' "${CORE_DIR}" || true)

if [[ "${violations}" -gt 0 ]]; then
    echo "core-purity: FAILED with ${violations} violation(s)." >&2
    echo "src/core/ must stay free of AzerothCore headers (see ARCHITECTURE.md section 2)." >&2
    exit 1
fi

echo "core-purity: OK -- src/core/ is free of AzerothCore dependencies."
exit 0
