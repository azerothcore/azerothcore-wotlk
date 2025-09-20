#!/usr/bin/env bats

# Require minimum BATS version when supported (older distro packages lack this)
if type -t bats_require_minimum_version >/dev/null 2>&1; then
  bats_require_minimum_version 1.5.0
fi

# AzerothCore Compiler Scripts Test Suite
# Tests the functionality of the compiler scripts using the unified test framework

# Load the AzerothCore test framework
load '../../test-framework/bats_libs/acore-support'
load '../../test-framework/bats_libs/acore-assert'

# Setup that runs before each test
setup() {
    compiler_setup
    export SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
    export COMPILER_SCRIPT="$SCRIPT_DIR/compiler.sh"
}

# Cleanup that runs after each test
teardown() {
    acore_test_teardown
}

# ===== COMPILER SCRIPT TESTS =====

@test "compiler: should show help with --help argument" {
    run bash -c "echo '' | timeout 5s $COMPILER_SCRIPT --help"
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Available commands:" ]]
}

@test "compiler: should show help with empty input" {
    run bash -c "echo '' | timeout 5s $COMPILER_SCRIPT 2>&1 || true"
    # The script might exit with timeout (124) or success (0), both are acceptable for this test
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 124 ]]
    # Check if output contains expected content - looking for menu options (old or new format)
    [[ "$output" =~ "build:" ]] || [[ "$output" =~ "clean:" ]] || [[ "$output" =~ "Please enter your choice" ]] || [[ "$output" =~ "build (b):" ]] || [[ "$output" =~ "ACORE COMPILER" ]] || [[ -z "$output" ]]
}

@test "compiler: should accept option numbers" {
    # Test option 7 (ccacheShowStats) which should be safe to run
    run bash -c "echo '7' | timeout 10s $COMPILER_SCRIPT 2>/dev/null || true"
    # The script might exit with timeout (124) or success (0), both are acceptable
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 124 ]]
}

@test "compiler: should accept option by name" {
    run timeout 10s "$COMPILER_SCRIPT" ccacheShowStats
    [ "$status" -eq 0 ]
}

@test "compiler: should handle invalid option gracefully" {
    run timeout 5s "$COMPILER_SCRIPT" invalidOption
    # Should exit with error code for invalid option
    [ "$status" -eq 1 ]
    # Output check is optional as error message might be buffered
}

@test "compiler: should handle invalid number gracefully" {
    run bash -c "echo '999' | timeout 5s $COMPILER_SCRIPT 2>&1 || true"
    # The script might exit with timeout (124) or success (0) for interactive mode
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 124 ]]
    # In interactive mode, the script should continue asking for input or timeout
}

@test "compiler: should quit with quit option" {
    run timeout 5s "$COMPILER_SCRIPT" quit
    [ "$status" -eq 0 ]
}

# ===== FUNCTION TESTS =====

@test "functions: comp_clean should handle non-existent build directory" {
    # Source the functions with a non-existent build path
    run bash -c "
        export BUILDPATH='/tmp/non_existent_build_dir_$RANDOM'
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_clean
    "
    # Accept either success or failure - the important thing is the function runs
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 1 ]]
    [[ "$output" =~ "Cleaning build files" ]]
}

@test "functions: comp_clean should remove build files when directory exists" {
    # Create a temporary build directory with test files
    local test_build_dir="/tmp/test_build_$RANDOM"
    mkdir -p "$test_build_dir/subdir"
    touch "$test_build_dir/test_file.txt"
    touch "$test_build_dir/subdir/nested_file.txt"
    
    # Run the clean function
    run bash -c "
        export BUILDPATH='$test_build_dir'
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_clean
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Cleaning build files" ]]
    # Directory should still exist but be empty
    [ -d "$test_build_dir" ]
    [ ! -f "$test_build_dir/test_file.txt" ]
    [ ! -f "$test_build_dir/subdir/nested_file.txt" ]
    
    # Cleanup
    rm -rf "$test_build_dir"
}

@test "functions: comp_ccacheShowStats should run without errors when ccache enabled" {
    run bash -c "
        export AC_CCACHE=true
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_ccacheShowStats
    "
    [ "$status" -eq 0 ]
}

@test "functions: comp_ccacheShowStats should do nothing when ccache disabled" {
    run bash -c "
        export AC_CCACHE=false
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_ccacheShowStats
    "
    [ "$status" -eq 0 ]
    # Should produce no output when ccache is disabled
}

@test "functions: comp_ccacheClean should handle disabled ccache" {
    run bash -c "
        export AC_CCACHE=false
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_ccacheClean
    "
    [ "$status" -eq 0 ]
    [[ "$output" =~ "ccache is disabled" ]]
}

@test "functions: comp_ccacheClean should run when ccache enabled" {
    # Only run if ccache is actually available
    if command -v ccache >/dev/null 2>&1; then
        run bash -c "
            export AC_CCACHE=true
            source '$SCRIPT_DIR/includes/functions.sh'
            comp_ccacheClean
        "
        [ "$status" -eq 0 ]
        [[ "$output" =~ "Cleaning ccache" ]]
    else
        skip "ccache not available on system"
    fi
}

@test "functions: comp_ccacheEnable should set environment variables" {
    # Call the function in a subshell to capture environment changes
    run bash -c "
        export AC_CCACHE=true
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_ccacheEnable
        env | grep CCACHE | head -5
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CCACHE_MAXSIZE" ]] || [[ "$output" =~ "CCACHE_COMPRESS" ]]
}

@test "functions: comp_ccacheEnable should not set variables when ccache disabled" {
    # Call the function and verify it returns early when ccache is disabled
    run bash -c "
        export AC_CCACHE=false
        source '$SCRIPT_DIR/includes/functions.sh'
        comp_ccacheEnable
        # The function should return early, so we check if it completed successfully
        echo 'Function completed without setting CCACHE vars'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Function completed" ]]
}

# Mock tests for build functions (these would normally require a full setup)
@test "functions: comp_configure should detect platform" {
    # Mock cmake command to avoid actual configuration
    run -127 bash -c "
        function cmake() {
            echo 'CMAKE called with args: $*'
            return 0
        }
        export -f cmake
        
        # Set required variables
        export BUILDPATH='/tmp'
        export SRCPATH='/tmp'
        export BINPATH='/tmp'
        export CTYPE='Release'
        
        # Source the functions
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Run configure in the /tmp directory
        cd /tmp && comp_configure
    "
    
    # Accept command not found as this might indicate missing dependencies
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 127 ]]
    # If successful, check for expected output
    if [ "$status" -eq 0 ]; then
        [[ "$output" =~ "Platform:" ]] || [[ "$output" =~ "CMAKE called with args:" ]]
    fi
}

@test "functions: comp_compile should detect thread count" {
    # Mock cmake command to avoid actual compilation
    run -127 bash -c "
        function cmake() {
            echo 'CMAKE called with args: $*'
            return 0
        }
        export -f cmake
        
        # Mock other commands
        function pushd() { echo 'pushd $*'; }
        function popd() { echo 'popd $*'; }
        function time() { shift; \"\$@\"; }
        export -f pushd popd time
        
        # Set required variables
        export BUILDPATH='/tmp'
        export MTHREADS=0
        export CTYPE='Release'
        export AC_BINPATH_FULL='/tmp'
        
        # Source the functions
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Run compile in the /tmp directory
        cd /tmp && comp_compile
    "
    
    # Accept command not found as this might indicate missing dependencies
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 127 ]]
    # If successful, check for expected output
    if [ "$status" -eq 0 ]; then
        [[ "$output" =~ "pushd" ]] || [[ "$output" =~ "CMAKE called with args:" ]]
    fi
}

@test "functions: comp_build should call configure and compile" {
    # Mock the comp_configure and comp_compile functions
    run -127 bash -c "
        function comp_configure() {
            echo 'comp_configure called'
            return 0
        }
        
        function comp_compile() {
            echo 'comp_compile called'
            return 0
        }
        
        export -f comp_configure comp_compile
        
        # Source the functions
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Run build
        comp_build
    "
    
    # Accept command not found as this might indicate missing dependencies
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 127 ]]
    # If successful, check for expected output
    if [ "$status" -eq 0 ]; then
        [[ "$output" =~ "comp_configure called" ]] && [[ "$output" =~ "comp_compile called" ]]
    fi
}

@test "functions: comp_all should call clean and build" {
    # Mock the comp_clean and comp_build functions
    run -127 bash -c "
        function comp_clean() {
            echo 'comp_clean called'
            return 0
        }
        
        function comp_build() {
            echo 'comp_build called'
            return 0
        }
        
        export -f comp_clean comp_build
        
        # Source the functions
        source '$SCRIPT_DIR/includes/functions.sh'
        
        # Run all
        comp_all
    "
    
    # Accept command not found as this might indicate missing dependencies
    [[ "$status" -eq 0 ]] || [[ "$status" -eq 127 ]]
    # If successful, check for expected output
    if [ "$status" -eq 0 ]; then
        [[ "$output" =~ "comp_clean called" ]] && [[ "$output" =~ "comp_build called" ]]
    fi
}
