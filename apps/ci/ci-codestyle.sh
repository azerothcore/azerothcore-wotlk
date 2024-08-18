#!/bin/bash
set -e

echo "Codestyle check script:"
echo

declare -A singleLineRegexChecks=(
    ["LOG_.+GetCounter"]="Use ObjectGuid::ToString().c_str() method instead of ObjectGuid::GetCounter() when logging. Check the lines above"
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

declare -A multiLineRegexChecks=(
    ["LOG_[^;]+GetCounter"]="Use ObjectGuid::ToString().c_str() method instead of ObjectGuid::GetCounter() when logging. Check the lines above"
    ["\n\n\n"]="Multiple blank lines detected, keep only one. Check the files above"
)

for check in ${!multiLineRegexChecks[@]}; do
    echo "  Checking RegEx: '${check}'"

    if grep -Pzo -r -I ${check} src; then
        echo
        echo
        echo "${multiLineRegexChecks[$check]}"
        exit 1
    fi
done

declare -A classTtypeIdChecks=(
    ["GetTypeId\(\)[[:space:]]*==[[:space:]]*TYPEID_PLAYER"]="Use IsPlayer() instead of GetTypeId() == TYPEID_PLAYER. Check the lines above"
    ["GetTypeId\(\)[[:space:]]*==[[:space:]]*TYPEID_CORPSE"]="Use IsCorpse() instead of GetTypeId() == TYPEID_CORPSE. Check the lines above"
    ["GetTypeId\(\)[[:space:]]*==[[:space:]]*TYPEID_ITEM"]="Use IsItem() instead of GetTypeId() == TYPEID_ITEM. Check the lines above"
    ["GetTypeId\(\)[[:space:]]*==[[:space:]]*TYPEID_DYNAMICOBJECT"]="Use IsDynObject() instead of GetTypeId() == TYPEID_DYNAMICOBJECT. Check the lines above"
)

EXCLUDE_PATTERN="--exclude=src/server/game/Entities/Object/Object.h"

for check in ${!classTtypeIdChecks[@]}; do
    echo "  Checking RegEx: '${check}'"

    if grep -P -r -I -n ${EXCLUDE_PATTERN} ${check} src; then
        echo
        echo "${classTtypeIdChecks[$check]}"
        exit 1
    fi
done

echo
echo "Everything looks good"
