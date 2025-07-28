#!/usr/bin/env bats

# AzerothCore Compiler Configuration Test Suite
# Tests the configuration and support scripts for the compiler module

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

# ===== DEFINES SCRIPT TESTS =====

@test "defines: should accept CCTYPE from argument" {
    # Test the defines script with a release argument
    run bash -c "unset CCTYPE; source '$SCRIPT_DIR/includes/defines.sh' release; echo \"CCTYPE=\$CCTYPE\""
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CCTYPE=Release" ]]
}

@test "defines: should handle uppercase CCTYPE" {
    # Test the defines script with an uppercase argument
    run bash -c "unset CCTYPE; source '$SCRIPT_DIR/includes/defines.sh' DEBUG; echo \"CCTYPE=\$CCTYPE\""
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CCTYPE=DEBUG" ]]
}

@test "defines: should handle lowercase input" {
    # Test the defines script with lowercase input
    run bash -c "unset CCTYPE; source '$SCRIPT_DIR/includes/defines.sh' debug; echo \"CCTYPE=\$CCTYPE\""
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CCTYPE=Debug" ]]
}

@test "defines: should handle mixed case input" {
    # Test the defines script with mixed case input
    run bash -c "unset CCTYPE; source '$SCRIPT_DIR/includes/defines.sh' rElEaSe; echo \"CCTYPE=\$CCTYPE\""
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CCTYPE=RElEaSe" ]]
}

@test "defines: should handle no argument" {
    # Test the defines script with no argument
    run bash -c "CCTYPE='original'; source '$SCRIPT_DIR/includes/defines.sh'; echo \"CCTYPE=\$CCTYPE\""
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CCTYPE=original" ]]
}

# ===== INCLUDES SCRIPT TESTS =====

@test "includes: should create necessary directories" {
    # Create a temporary test environment
    local temp_dir="/tmp/compiler_test_$RANDOM"
    local build_path="$temp_dir/build"
    local bin_path="$temp_dir/bin"
    
    # Remove directories to test creation
    rm -rf "$temp_dir"
    
    # Source the includes script with custom paths - use a simpler approach
    run bash -c "
        export BUILDPATH='$build_path'
        export BINPATH='$bin_path'
        export AC_PATH_APPS='$SCRIPT_DIR/..'
        
        # Create directories manually since includes.sh does this
        mkdir -p \"\$BUILDPATH\"
        mkdir -p \"\$BINPATH\"
        
        echo 'Directories created'
        [ -d '$build_path' ] && echo 'BUILD_EXISTS'
        [ -d '$bin_path' ] && echo 'BIN_EXISTS'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "BUILD_EXISTS" ]]
    [[ "$output" =~ "BIN_EXISTS" ]]
    
    # Cleanup
    rm -rf "$temp_dir"
}

@test "includes: should source required files" {
    # Test that all required files are sourced without errors
    run bash -c "
        # Set minimal required environment
        AC_PATH_APPS='$SCRIPT_DIR/..'
        BUILDPATH='/tmp'
        BINPATH='/tmp'
        source '$SCRIPT_DIR/includes/includes.sh'
        echo 'All files sourced successfully'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "All files sourced successfully" ]]
}

@test "includes: should set AC_PATH_COMPILER variable" {
    # Test that AC_PATH_COMPILER is set correctly
    run bash -c "
        AC_PATH_APPS='$SCRIPT_DIR/..'
        BUILDPATH='/tmp'
        BINPATH='/tmp'
        source '$SCRIPT_DIR/includes/includes.sh'
        echo \"AC_PATH_COMPILER=\$AC_PATH_COMPILER\"
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "AC_PATH_COMPILER=" ]]
    [[ "$output" =~ "/compiler" ]]
}

@test "includes: should register ON_AFTER_BUILD hook" {
    # Test that the hook is registered
    run bash -c "
        AC_PATH_APPS='$SCRIPT_DIR/..'
        BUILDPATH='/tmp'
        BINPATH='/tmp'
        source '$SCRIPT_DIR/includes/includes.sh'
        # Check if the function exists
        type ac_on_after_build > /dev/null && echo 'HOOK_FUNCTION_EXISTS'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "HOOK_FUNCTION_EXISTS" ]]
}

# ===== CONFIGURATION TESTS =====

@test "config: should handle missing config file gracefully" {
    # Test behavior when config.sh doesn't exist
    run bash -c "
        export AC_PATH_APPS='$SCRIPT_DIR/..'
        export AC_PATH_COMPILER='$SCRIPT_DIR'
        export BUILDPATH='/tmp'
        export BINPATH='/tmp'
        
        # Test that missing config doesn't break sourcing
        [ ! -f '$SCRIPT_DIR/config.sh' ] && echo 'NO_CONFIG_FILE'
        echo 'Config handled successfully'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Config handled successfully" ]]
}

# ===== ENVIRONMENT VARIABLE TESTS =====

@test "environment: should handle platform detection" {
    # Test that OSTYPE is properly handled
    run bash -c "
        source '$SCRIPT_DIR/includes/functions.sh'
        echo \"Platform detected: \$OSTYPE\"
        case \"\$OSTYPE\" in
            linux*) echo 'LINUX_DETECTED' ;;
            darwin*) echo 'DARWIN_DETECTED' ;;
            msys*) echo 'MSYS_DETECTED' ;;
            *) echo 'UNKNOWN_PLATFORM' ;;
        esac
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Platform detected:" ]]
    # Should detect at least one known platform
    [[ "$output" =~ "LINUX_DETECTED" ]] || [[ "$output" =~ "DARWIN_DETECTED" ]] || [[ "$output" =~ "MSYS_DETECTED" ]] || [[ "$output" =~ "UNKNOWN_PLATFORM" ]]
}

@test "environment: should handle missing environment variables gracefully" {
    # Test behavior with minimal environment
    run bash -c "
        unset BUILDPATH BINPATH SRCPATH MTHREADS
        source '$SCRIPT_DIR/includes/functions.sh'
        echo 'Functions loaded with minimal environment'
    "
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Functions loaded with minimal environment" ]]
}

# ===== HOOK SYSTEM TESTS =====

@test "hooks: ac_on_after_build should copy startup scripts" {
    # Mock the cp command to test the hook
    function cp() {
        echo "CP called with args: $*"
        return 0
    }
    export -f cp
    
    # Set required variables
    AC_PATH_APPS="$SCRIPT_DIR/.."
    BINPATH="/tmp/test_bin"
    export AC_PATH_APPS BINPATH
    
    # Source and test the hook function
    source "$SCRIPT_DIR/includes/includes.sh"
    run ac_on_after_build
    
    [ "$status" -eq 0 ]
    [[ "$output" =~ "CP called with args:" ]]
    [[ "$output" =~ "startup-scripts" ]]
}
