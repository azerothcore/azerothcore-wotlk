#!/usr/bin/env bash

 # shellcheck source-path=SCRIPTDIR
CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Clean up gcda files to avoid false positives in coverage reports
find var/build/obj -name '*.gcda' -delete

# shellcheck source=../bash_shared/includes.sh
source "$CURRENT_PATH/../bash_shared/includes.sh"

TEST_PATH="$BUILDPATH/src/test/unit_tests"

if [[ ! -f "$TEST_PATH" ]]; then
    echo "Unit test binary not found at $TEST_PATH"
    echo "Please ensure the project is built with unit tests enabled."
    exit 1
fi

exec "$TEST_PATH" "$@"