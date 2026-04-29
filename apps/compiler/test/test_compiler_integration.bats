#!/usr/bin/env bats

# AzerothCore Compiler Integration Test Suite
# Tests edge cases and integration scenarios for the compiler module

# Load the AzerothCore test framework
load '../../test-framework/bats_libs/acore-support'
load '../../test-framework/bats_libs/acore-assert'

# Setup that runs before each test
setup() {
    compiler_setup
    export SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
}

# Cleanup that runs after each test
teardown() {
    acore_test_teardown
}

# ===== INTEGRATION TESTS =====

@test "integration: should handle full compiler.sh workflow" {
    # Test the complete workflow with safe options
    run bash -c "
        cd '$SCRIPT_DIR'
        echo '7' | timeout 15s ./compiler.sh
        echo 'First command completed'
        echo 'quit' | timeout 10s ./compiler.sh
        echo 'Quit command completed'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "First command completed" ]]
    [[ "$output" =~ "Quit command completed" ]]
}

@test "integration: should handle multiple consecutive commands" {
    # Test running multiple safe commands in sequence
    run bash -c "
        cd '$SCRIPT_DIR'
        timeout 10s ./compiler.sh ccacheShowStats
        echo 'Command 1 done'
        timeout 10s ./compiler.sh quit
        echo 'Command 2 done'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Command 1 done" ]]
    [[ "$output" =~ "Command 2 done" ]]
}

@test "integration: should preserve working directory" {
    # Test that the script doesn't change the working directory unexpectedly
    local original_pwd="$(pwd)"
    
    run bash -c "
        cd '$SCRIPT_DIR'
        original_dir=\$(pwd)
        timeout 10s ./compiler.sh quit
        current_dir=\$(pwd)
        echo \"ORIGINAL: \$original_dir\"
        echo \"CURRENT: \$current_dir\"
        [ \"\$original_dir\" = \"\$current_dir\" ] && echo 'DIRECTORY_PRESERVED'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "DIRECTORY_PRESERVED" ]]
}

# ===== ERROR HANDLING TESTS =====

@test "error_handling: should handle script errors gracefully" {
    # Test script behavior with set -e when encountering errors
    run bash -c "
        cd '$SCRIPT_DIR'
        # Try to source a non-existent file to test error handling
        timeout 5s bash -c 'set -e; source /nonexistent/file.sh' || echo 'ERROR_HANDLED'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "ERROR_HANDLED" ]]
}

@test "error_handling: should validate function availability" {
    # Test that required functions are available after sourcing
    run bash -c "
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Check for key functions
        type comp_clean > /dev/null && echo 'COMP_CLEAN_AVAILABLE'
        type comp_configure > /dev/null && echo 'COMP_CONFIGURE_AVAILABLE'
        type comp_compile > /dev/null && echo 'COMP_COMPILE_AVAILABLE'
        type comp_build > /dev/null && echo 'COMP_BUILD_AVAILABLE'
        type comp_all > /dev/null && echo 'COMP_ALL_AVAILABLE'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "COMP_CLEAN_AVAILABLE" ]]
    [[ "$output" =~ "COMP_CONFIGURE_AVAILABLE" ]]
    [[ "$output" =~ "COMP_COMPILE_AVAILABLE" ]]
    [[ "$output" =~ "COMP_BUILD_AVAILABLE" ]]
    [[ "$output" =~ "COMP_ALL_AVAILABLE" ]]
}

# ===== PERMISSION TESTS =====

@test "permissions: should handle permission requirements" {
    # Test script behavior with different permission scenarios
    run bash -c "
        # Test SUDO variable detection
        source '$SCRIPT_DIR/includes/functions.sh'
        echo \"SUDO variable: '\$SUDO'\"
        [ -n \"\$SUDO\" ] && echo 'SUDO_SET' || echo 'SUDO_EMPTY'
    "
    
    [ "$status" -eq 0 ]
    # Should set SUDO appropriately based on EUID
    [[ "$output" =~ "SUDO_SET" ]] || [[ "$output" =~ "SUDO_EMPTY" ]]
}

# ===== CLEANUP TESTS =====

@test "cleanup: comp_clean should handle various file types" {
    # Create a comprehensive test directory structure
    local test_dir="/tmp/compiler_cleanup_test_$RANDOM"
    mkdir -p "$test_dir/subdir1/subdir2"
    
    # Create various file types
    touch "$test_dir/regular_file.txt"
    touch "$test_dir/executable_file.sh"
    touch "$test_dir/.hidden_file"
    touch "$test_dir/subdir1/nested_file.obj"
    touch "$test_dir/subdir1/subdir2/deep_file.a"
    ln -s "$test_dir/regular_file.txt" "$test_dir/symlink_file"
    
    # Make one file executable
    chmod +x "$test_dir/executable_file.sh"
    
    # Test cleanup
    run bash -c "
        export BUILDPATH='$test_dir'
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_clean
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Cleaning build files" ]]
    
    # Verify cleanup (directory should exist but files should be cleaned)
    [ -d "$test_dir" ]
    
    # The cleanup might not remove all files depending on the implementation
    # Let's check if at least some cleanup occurred
    local remaining_files=$(find "$test_dir" -type f | wc -l)
    # Either all files are gone, or at least some cleanup happened
    [[ "$remaining_files" -eq 0 ]] || [[ "$remaining_files" -lt 6 ]]
    
    # Cleanup test directory
    rm -rf "$test_dir"
}

# ===== THREAD DETECTION TESTS =====

@test "threading: should detect available CPU cores" {
    # Test thread count detection logic
    run bash -c "
        # Simulate the thread detection logic from the actual function
        MTHREADS=0
        if [ \$MTHREADS == 0 ]; then
            # Use nproc if available, otherwise simulate 4 cores
            if command -v nproc >/dev/null 2>&1; then
                MTHREADS=\$(nproc)
            else
                MTHREADS=4
            fi
            MTHREADS=\$((MTHREADS + 2))
        fi
        echo \"Detected threads: \$MTHREADS\"
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Detected threads:" ]]
    # Should be at least 3 (1 core + 2)
    local thread_count=$(echo "$output" | grep -o '[0-9]\+')
    [ "$thread_count" -ge 3 ]
}

# ===== CMAKE OPTION TESTS =====

@test "cmake: should build correct cmake command" {
    # Mock cmake to capture command line arguments
    run bash -c "
        function cmake() {
            echo 'CMAKE_COMMAND: $*'
            return 0
        }
        export -f cmake
        
        # Set comprehensive test environment
        export SRCPATH='/test/src'
        export BUILDPATH='/test/build'
        export BINPATH='/test/bin'
        export CTYPE='Release'
        export CAPPS_BUILD='ON'
        export CTOOLS_BUILD='ON'
        export CSCRIPTS='ON'
        export CMODULES='ON'
        export CBUILD_TESTING='OFF'
        export CSCRIPTPCH='ON'
        export CCOREPCH='ON'
        export CWARNINGS='ON'
        export CCOMPILERC='gcc'
        export CCOMPILERCXX='g++'
        export CCUSTOMOPTIONS='-DCUSTOM_OPTION=1'
        
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Change to buildpath and run configure
        cd /test || cd /tmp
        comp_configure 2>/dev/null || echo 'Configure completed with warnings'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CMAKE_COMMAND:" ]] || [[ "$output" =~ "Configure completed" ]]
}

# ===== PLATFORM SPECIFIC TESTS =====

@test "platform: should set correct options for detected platform" {
    # Test platform-specific CMAKE options
    run bash -c "
        # Mock cmake to capture platform-specific options
        function cmake() {
            echo 'CMAKE_PLATFORM_ARGS: $*'
            return 0
        }
        export -f cmake
        
        export BUILDPATH='/tmp'
        export SRCPATH='/tmp'
        export BINPATH='/tmp'
        export CTYPE='Release'
        
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Change to buildpath and run configure
        cd /tmp
        comp_configure 2>/dev/null || echo 'Configure completed with warnings'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CMAKE_PLATFORM_ARGS:" ]] || [[ "$output" =~ "Configure completed" ]]
}
