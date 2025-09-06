#!/usr/bin/env bash

# Test script for module parsing functionality
# This tests the fix for URL parsing with ports

# Source the modules.sh file to get the functions
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_PATH/apps/installer/includes/modules-manager/modules.sh"

# Test cases for module specification parsing
echo "Testing module specification parsing..."
echo "======================================"

# Test cases that should work correctly
test_cases=(
    # Simple module names
    "mod-transmog"
    "mod-transmog:custom-dir"
    "mod-transmog@develop"
    "mod-transmog:custom-dir@develop:abc123"
    
    # Owner/repo format
    "azerothcore/mod-transmog"
    "azerothcore/mod-transmog:custom-dir"
    "azerothcore/mod-transmog@develop"
    "azerothcore/mod-transmog:custom-dir@develop:abc123"
    
    # URLs without ports (should work as before)
    "https://github.com/azerothcore/mod-transmog"
    "https://github.com/azerothcore/mod-transmog:custom-dir"
    "https://github.com/azerothcore/mod-transmog@develop"
    "https://github.com/azerothcore/mod-transmog.git:custom-dir@develop:abc123"
    
    # URLs with ports (these were problematic before the fix)
    "https://example.com:8080/user/repo.git"
    "https://example.com:8080/user/repo.git:custom-dir"
    "https://example.com:8080/user/repo.git@develop"
    "https://example.com:8080/user/repo.git:custom-dir@develop:abc123"
    
    # SSH URLs with ports
    "ssh://git@example.com:2222/user/repo"
    "ssh://git@example.com:2222/user/repo:custom-dir"
    "ssh://git@example.com:2222/user/repo@develop"
    "ssh://git@example.com:2222/user/repo:custom-dir@develop:abc123"
    
    # Git SSH format
    "git@github.com:azerothcore/mod-transmog.git"
    "git@github.com:azerothcore/mod-transmog.git:custom-dir"
    "git@github.com:azerothcore/mod-transmog.git@develop"
    "git@github.com:azerothcore/mod-transmog.git:custom-dir@develop:abc123"
)

# Function to test a single case
test_case() {
    local spec="$1"
    echo ""
    echo "Testing: '$spec'"
    echo "----------------------------------------"
    
    # Parse the module spec
    local result
    result=$(inst_parse_module_spec "$spec")
    
    if [[ $? -eq 0 ]]; then
        # Parse the result
        local repo_ref owner name branch commit url dirname
        read -r repo_ref owner name branch commit url dirname <<< "$result"
        
        echo "  repo_ref: '$repo_ref'"
        echo "  owner:    '$owner'"
        echo "  name:     '$name'"
        echo "  branch:   '$branch'"
        echo "  commit:   '$commit'"
        echo "  url:      '$url'"
        echo "  dirname:  '$dirname'"
        
        # Validate the parsing for URLs with ports
        if [[ "$spec" =~ :// ]] && [[ "$spec" =~ :[0-9]+/ ]]; then
            # This is a URL with a port
            if [[ "$dirname" =~ ^[0-9]+$ ]]; then
                echo "  ❌ ERROR: Port number '$dirname' incorrectly parsed as dirname!"
                return 1
            else
                echo "  ✅ SUCCESS: Port not confused with dirname"
            fi
        fi
        
        # Check if dirname is reasonable
        if [[ -n "$dirname" ]] && [[ "$dirname" != "-" ]]; then
            echo "  ✅ SUCCESS: Valid dirname specified"
        fi
        
    else
        echo "  ❌ ERROR: Failed to parse module spec"
        return 1
    fi
    
    return 0
}

# Run all test cases
failed_tests=0
passed_tests=0

for test_spec in "${test_cases[@]}"; do
    if test_case "$test_spec"; then
        ((passed_tests++))
    else
        ((failed_tests++))
    fi
done

echo ""
echo "======================================"
echo "Test Summary:"
echo "  Passed: $passed_tests"
echo "  Failed: $failed_tests"
echo "  Total:  $((passed_tests + failed_tests))"

if [[ $failed_tests -eq 0 ]]; then
    echo "  ✅ ALL TESTS PASSED!"
    exit 0
else
    echo "  ❌ SOME TESTS FAILED!"
    exit 1
fi
