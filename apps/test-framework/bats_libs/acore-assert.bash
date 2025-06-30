#!/usr/bin/env bash

# AzerothCore BATS Assertions Library
# Custom assertions for AzerothCore testing

# Assert that a binary exists and is executable
assert_binary_exists() {
    local binary_path="$1"
    local message="${2:-Binary should exist and be executable}"
    
    if [[ ! -f "$binary_path" ]]; then
        echo "Binary not found: $binary_path"
        echo "$message"
        return 1
    fi
    
    if [[ ! -x "$binary_path" ]]; then
        echo "Binary not executable: $binary_path"
        echo "$message"
        return 1
    fi
}

# Assert that output contains specific AzerothCore patterns
assert_acore_server_started() {
    local output="$1"
    local server_type="$2"
    local message="${3:-Server should show startup message}"
    
    if [[ ! "$output" =~ $server_type.*starting ]]; then
        echo "Server start message not found for $server_type"
        echo "Expected pattern: '$server_type.*starting'"
        echo "Actual output: $output"
        echo "$message"
        return 1
    fi
}

# Assert that configuration file was loaded
assert_config_loaded() {
    local output="$1"
    local config_file="$2"
    local message="${3:-Configuration file should be loaded}"
    
    if [[ ! "$output" =~ config.*$config_file ]] && [[ ! "$output" =~ $config_file ]]; then
        echo "Configuration file loading not detected: $config_file"
        echo "Expected to find: config.*$config_file OR $config_file"
        echo "Actual output: $output"
        echo "$message"
        return 1
    fi
}

# Assert that a process exited with expected code
assert_exit_code() {
    local actual_code="$1"
    local expected_code="$2"
    local message="${3:-Process should exit with expected code}"
    
    if [[ "$actual_code" -ne "$expected_code" ]]; then
        echo "Expected exit code: $expected_code"
        echo "Actual exit code: $actual_code"
        echo "$message"
        return 1
    fi
}

# Assert that output contains specific error pattern
assert_error_message() {
    local output="$1"
    local error_pattern="$2"
    local message="${3:-Output should contain expected error message}"
    
    if [[ ! "$output" =~ $error_pattern ]]; then
        echo "Expected error pattern not found: $error_pattern"
        echo "Actual output: $output"
        echo "$message"
        return 1
    fi
}

# Assert that a file was created
assert_file_created() {
    local file_path="$1"
    local message="${2:-File should be created}"
    
    if [[ ! -f "$file_path" ]]; then
        echo "File not created: $file_path"
        echo "$message"
        return 1
    fi
}

# Assert that a directory was created
assert_directory_created() {
    local dir_path="$1"
    local message="${2:-Directory should be created}"
    
    if [[ ! -d "$dir_path" ]]; then
        echo "Directory not created: $dir_path"
        echo "$message"
        return 1
    fi
}

# Assert that output contains success message
assert_success_message() {
    local output="$1"
    local success_pattern="${2:-success|completed|finished|done}"
    local message="${3:-Output should contain success message}"
    
    if [[ ! "$output" =~ $success_pattern ]]; then
        echo "Success message not found"
        echo "Expected pattern: $success_pattern"
        echo "Actual output: $output"
        echo "$message"
        return 1
    fi
}

# Assert that build was successful
assert_build_success() {
    local output="$1"
    local message="${2:-Build should complete successfully}"
    
    local build_success_patterns="Build completed|compilation successful|build.*success|make.*success"
    assert_success_message "$output" "$build_success_patterns" "$message"
}

# Assert that server is responsive
assert_server_responsive() {
    local output="$1"
    local server_type="$2"
    local message="${3:-Server should be responsive}"
    
    if [[ ! "$output" =~ $server_type.*initialized ]] && [[ ! "$output" =~ $server_type.*ready ]]; then
        echo "Server responsiveness not detected for $server_type"
        echo "Expected pattern: '$server_type.*initialized' OR '$server_type.*ready'"
        echo "Actual output: $output"
        echo "$message"
        return 1
    fi
}

# Assert that timeout occurred (for long-running processes)
assert_timeout() {
    local exit_code="$1"
    local message="${2:-Process should timeout as expected}"
    
    if [[ "$exit_code" -ne 124 ]]; then
        echo "Expected timeout (exit code 124)"
        echo "Actual exit code: $exit_code"
        echo "$message"
        return 1
    fi
}

# Assert that log file contains expected content
assert_log_contains() {
    local log_file="$1"
    local expected_content="$2"
    local message="${3:-Log file should contain expected content}"
    
    if [[ ! -f "$log_file" ]]; then
        echo "Log file not found: $log_file"
        echo "$message"
        return 1
    fi
    
    if ! grep -q "$expected_content" "$log_file"; then
        echo "Expected content not found in log: $expected_content"
        echo "Log file: $log_file"
        echo "Log contents:"
        cat "$log_file" | head -20
        echo "$message"
        return 1
    fi
}
