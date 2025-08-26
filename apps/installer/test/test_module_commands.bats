#!/usr/bin/env bats

# Tests for installer module commands (search/install/update/remove)
# Focused on installer:module install behavior using a mocked joiner

load '../../test-framework/bats_libs/acore-support'
load '../../test-framework/bats_libs/acore-assert'

setup() {
    acore_test_setup
    # Point to the installer src directory (not needed in this test)

    # Set installer/paths environment for the test
    export AC_PATH_APPS="$TEST_DIR/apps"
    export AC_PATH_ROOT="$TEST_DIR"
    export AC_PATH_DEPS="$TEST_DIR/deps"
    export AC_PATH_MODULES="$TEST_DIR/modules"
    export MODULES_LIST_FILE="$TEST_DIR/conf/modules.list"

    # Create stubbed deps: joiner.sh (sourced by includes) and semver
    mkdir -p "$TEST_DIR/deps/acore/joiner"
    cat > "$TEST_DIR/deps/acore/joiner/joiner.sh" << 'EOF'
#!/usr/bin/env bash
# Stub joiner functions used by installer
Joiner:add_repo() {
    # arguments: url name branch basedir
    echo "ADD $@" > "$TEST_DIR/joiner_called.txt"
    return 0
}
Joiner:upd_repo() {
    echo "UPD $@" > "$TEST_DIR/joiner_called.txt"
    return 0
}
Joiner:remove() {
    echo "REM $@" > "$TEST_DIR/joiner_called.txt"
    return 0
}
# Provide legacy double-colon variants
Joiner::add_repo() { Joiner:add_repo "$@"; }
Joiner::upd_repo() { Joiner:upd_repo "$@"; }
Joiner::remove() { Joiner:remove "$@"; }
EOF
    chmod +x "$TEST_DIR/deps/acore/joiner/joiner.sh"

    mkdir -p "$TEST_DIR/deps/semver_bash"
    # Minimal semver stub
    cat > "$TEST_DIR/deps/semver_bash/semver.sh" << 'EOF'
#!/usr/bin/env bash
# semver stub
semver::satisfies() { return 0; }
EOF
    chmod +x "$TEST_DIR/deps/semver_bash/semver.sh"

    # Provide a minimal compiler includes file expected by installer
    mkdir -p "$TEST_DIR/apps/compiler/includes"
    touch "$TEST_DIR/apps/compiler/includes/includes.sh"

    # Provide minimal bash_shared includes to satisfy installer include
    mkdir -p "$TEST_DIR/apps/bash_shared"
    cat > "$TEST_DIR/apps/bash_shared/includes.sh" << 'EOF'
#!/usr/bin/env bash
# minimal stub
EOF

    # Copy the real installer app into the test apps dir
    mkdir -p "$TEST_DIR/apps"
    cp -r "$(cd "$AC_TEST_ROOT/apps/installer" && pwd)" "$TEST_DIR/apps/installer"
}

teardown() {
    acore_test_teardown
}

@test "module install should call joiner and record entry in modules list" {
    cd "$TEST_DIR"

    # Source installer includes and call the install function directly to avoid menu interaction
    run bash -c "source '$TEST_DIR/apps/installer/includes/includes.sh' && inst_module_install example-module:main:abcd1234"

    # Check that joiner was called
    [ -f "$TEST_DIR/joiner_called.txt" ]
    grep -q "ADD" "$TEST_DIR/joiner_called.txt"

    # Check modules list was created and contains the repo_ref and branch
    [ -f "$TEST_DIR/conf/modules.list" ]
    grep -q "azerothcore/example-module main" "$TEST_DIR/conf/modules.list"
}

@test "module install with owner/name format should work" {
    cd "$TEST_DIR"

    # Test with owner/name format
    run bash -c "source '$TEST_DIR/apps/installer/includes/includes.sh' && inst_module_install myorg/mymodule"

    # Check that joiner was called with correct URL
    [ -f "$TEST_DIR/joiner_called.txt" ]
    grep -q "ADD https://github.com/myorg/mymodule mymodule" "$TEST_DIR/joiner_called.txt"

    # Check modules list contains the entry
    [ -f "$TEST_DIR/conf/modules.list" ]
    grep -q "myorg/mymodule" "$TEST_DIR/conf/modules.list"
}

@test "module remove should call joiner remove and update modules list" {
    cd "$TEST_DIR"

    # First install a module
    bash -c "source '$TEST_DIR/apps/installer/includes/includes.sh' && inst_module_install test-module"
    
    # Then remove it
    run bash -c "source '$TEST_DIR/apps/installer/includes/includes.sh' && inst_module_remove test-module"

    # Check that joiner remove was called
    [ -f "$TEST_DIR/joiner_called.txt" ]
    grep -q "REM test-module azerothcore" "$TEST_DIR/joiner_called.txt"

    # Check modules list no longer contains the entry
    [ -f "$TEST_DIR/conf/modules.list" ]
    ! grep -q "azerothcore/test-module" "$TEST_DIR/conf/modules.list"
}

# Tests for intelligent module management (duplicate prevention and cross-format removal)

@test "inst_extract_owner_name should extract owner/name from various formats" {
    cd "$TEST_DIR"
    source "$TEST_DIR/apps/installer/includes/includes.sh"

    # Test simple name
    run inst_extract_owner_name "mod-transmog"
    [ "$output" = "azerothcore/mod-transmog" ]

    # Test owner/name format
    run inst_extract_owner_name "azerothcore/mod-transmog"
    [ "$output" = "azerothcore/mod-transmog" ]

    # Test HTTPS URL
    run inst_extract_owner_name "https://github.com/azerothcore/mod-transmog.git"
    [ "$output" = "azerothcore/mod-transmog" ]

    # Test SSH URL
    run inst_extract_owner_name "git@github.com:azerothcore/mod-transmog.git"
    [ "$output" = "azerothcore/mod-transmog" ]

    # Test GitLab URL
    run inst_extract_owner_name "https://gitlab.com/myorg/mymodule.git"
    [ "$output" = "myorg/mymodule" ]
}

@test "duplicate module entries should be prevented across different formats" {
    cd "$TEST_DIR"
    source "$TEST_DIR/apps/installer/includes/includes.sh"

    # Add module via simple name
    inst_mod_list_upsert "mod-transmog" "master" "abc123"
    
    # Verify it's in the list
    grep -q "mod-transmog master abc123" "$TEST_DIR/conf/modules.list"
    
    # Add same module via owner/name format - should replace, not duplicate
    inst_mod_list_upsert "azerothcore/mod-transmog" "dev" "def456"
    
    # Should only have one entry (the new one)
    [ "$(grep -c "azerothcore/mod-transmog" "$TEST_DIR/conf/modules.list")" -eq 1 ]
    grep -q "azerothcore/mod-transmog dev def456" "$TEST_DIR/conf/modules.list"
    ! grep -q "mod-transmog master abc123" "$TEST_DIR/conf/modules.list"
}

@test "module installed via URL should be recognized when checking with different formats" {
    cd "$TEST_DIR"
    source "$TEST_DIR/apps/installer/includes/includes.sh"

    # Install via HTTPS URL
    inst_mod_list_upsert "https://github.com/azerothcore/mod-transmog.git" "master" "abc123"
    
    # Should be detected as installed using simple name
    run inst_mod_is_installed "mod-transmog"
    [ "$status" -eq 0 ]
    
    # Should be detected as installed using owner/name
    run inst_mod_is_installed "azerothcore/mod-transmog"
    [ "$status" -eq 0 ]
    
    # Should be detected as installed using SSH URL
    run inst_mod_is_installed "git@github.com:azerothcore/mod-transmog.git"
    [ "$status" -eq 0 ]
    
    # Non-existent module should not be detected
    run inst_mod_is_installed "mod-nonexistent"
    [ "$status" -ne 0 ]
}

@test "cross-format module removal should work" {
    cd "$TEST_DIR"
    source "$TEST_DIR/apps/installer/includes/includes.sh"

    # Install via SSH URL
    inst_mod_list_upsert "git@github.com:azerothcore/mod-transmog.git" "master" "abc123"
    
    # Verify it's installed
    grep -q "git@github.com:azerothcore/mod-transmog.git" "$TEST_DIR/conf/modules.list"
    
    # Remove using simple name
    inst_mod_list_remove "mod-transmog"
    
    # Should be completely removed
    ! grep -q "azerothcore/mod-transmog" "$TEST_DIR/conf/modules.list"
    ! grep -q "git@github.com:azerothcore/mod-transmog.git" "$TEST_DIR/conf/modules.list"
}

@test "module installation should prevent duplicates when already installed" {
    cd "$TEST_DIR"
    source "$TEST_DIR/apps/installer/includes/includes.sh"

    # Install via simple name first
    inst_mod_list_upsert "mod-worldchat" "master" "abc123"
    
    # Try to install same module via URL - should detect it's already installed
    run inst_mod_is_installed "https://github.com/azerothcore/mod-worldchat.git"
    [ "$status" -eq 0 ]
    
    # Add via URL should replace the existing entry
    inst_mod_list_upsert "https://github.com/azerothcore/mod-worldchat.git" "dev" "def456"
    
    # Should only have one entry
    [ "$(grep -c "azerothcore/mod-worldchat" "$TEST_DIR/conf/modules.list")" -eq 1 ]
    grep -q "https://github.com/azerothcore/mod-worldchat.git dev def456" "$TEST_DIR/conf/modules.list"
}
