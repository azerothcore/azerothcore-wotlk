#!/bin/bash
set -e

echo "Codestyle check script:"
echo

declare -A singleLineRegexChecks=(
    ["[[:blank:]]$"]="Remove whitespace at the end of the lines above"
    ["\t"]="Replace tabs with 4 spaces in the lines above"
)

for check in ${!singleLineRegexChecks[@]}; do
    echo "  Checking RegEx: '${check}'"
    
    if grep -P -r -I -n ${check} src; then
        echo
        echo "${singleLineRegexChecks[$check]}"
        exit 1
    fi
done

echo
echo "Everything looks good"
