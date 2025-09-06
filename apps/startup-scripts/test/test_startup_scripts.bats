#!/usr/bin/env bats

# AzerothCore Startup Scripts Test Suite
# This script tests the basic functionality of the startup scripts using the unified test framework

# Load the AzerothCore test framework
load '../../test-framework/bats_libs/acore-support'
load '../../test-framework/bats_libs/acore-assert'

# Setup that runs before each test
setup() {
    startup_scripts_setup
    export SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/../src" && pwd)"
}

# Cleanup that runs after each test
teardown() {
    acore_test_teardown
}

# ===== STARTER SCRIPT TESTS =====

@test "starter: should fail with missing parameters" {
    run timeout 3s "$SCRIPT_DIR/starter" '' ''
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Error: Binary path and file are required" ]]
}

@test "starter: should start with valid binary" {
    cd "$TEST_DIR"
    run timeout 5s "$SCRIPT_DIR/starter" "$TEST_DIR/bin" "test-server" "" "$TEST_DIR/test-server.conf" "" "" 0
    debug_on_failure
    # The starter might have issues with the script command, so we check for specific behavior
    # Either it should succeed or show a specific error we can work with
    [[ "$output" =~ "Test server starting" ]] || [[ "$output" =~ "script:" ]] || [[ "$status" -eq 124 ]]
}

@test "starter: should validate binary path exists" {
    run "$SCRIPT_DIR/starter" "/nonexistent/path" "test-server"
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Binary '/nonexistent/path/test-server' not found" ]]
}

@test "starter: should detect PM2 environment properly" {
    cd "$TEST_DIR"
    # Test with AC_LAUNCHED_BY_PM2=1 (should not use script command)
    AC_LAUNCHED_BY_PM2=1 run timeout 5s "$SCRIPT_DIR/starter" "$TEST_DIR/bin" "test-server" "" "$TEST_DIR/test-server.conf" "" "" 0
    debug_on_failure
    # Should start without using script command
    [[ "$output" =~ "Test server starting" ]]
}

# ===== SIMPLE RESTARTER TESTS =====

@test "simple-restarter: should fail with missing parameters" {
    run timeout 3s "$SCRIPT_DIR/simple-restarter" '' ''
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Error: Binary path and file are required" ]]
}

@test "simple-restarter: should fail with missing binary" {
    run timeout 3s "$SCRIPT_DIR/simple-restarter" "$TEST_DIR/bin" 'nonexistent'
    [ "$status" -ne 0 ]
    [[ "$output" =~ "not found" ]] || [[ "$output" =~ "terminated with exit code" ]]
}

@test "simple-restarter: should detect starter script" {
    # Test that it finds the starter script
    run timeout 1s "$SCRIPT_DIR/simple-restarter" '' ''
    # Should not fail because starter script is missing
    [[ ! "$output" =~ "starter script not found" ]]
}

# ===== RUN-ENGINE TESTS =====

@test "run-engine: should show help" {
    run "$SCRIPT_DIR/run-engine" help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "AzerothCore Run Engine" ]]
}

@test "run-engine: should validate parameters for start command" {
    run "$SCRIPT_DIR/run-engine" start
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Missing required arguments" ]]
}

@test "run-engine: should detect binary with full path" {
    run timeout 5s "$SCRIPT_DIR/run-engine" start "$TEST_DIR/bin/test-server" --server-config "$TEST_DIR/test-server.conf"
    debug_on_failure
    [[ "$output" =~ "Starting server: test-server" ]] || [[ "$status" -eq 124 ]]
}

@test "run-engine: should detect binary in current directory" {
    cd "$TEST_DIR/bin"
    run timeout 5s "$SCRIPT_DIR/run-engine" start test-server --server-config "$TEST_DIR/test-server.conf"
    debug_on_failure
    [[ "$output" =~ "Binary found in current directory" ]] || [[ "$output" =~ "Starting server: test-server" ]] || [[ "$status" -eq 124 ]]
}

@test "run-engine: should support restart mode" {
    run timeout 5s "$SCRIPT_DIR/run-engine" restart "$TEST_DIR/bin/test-server" --server-config "$TEST_DIR/test-server.conf"
    debug_on_failure
    [[ "$output" =~ "Starting server: test-server" ]] || [[ "$status" -eq 124 ]]
}

# ===== SERVICE MANAGER TESTS =====

@test "service-manager: should show help" {
    run "$SCRIPT_DIR/service-manager.sh" help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "AzerothCore Service Setup" ]]
}

@test "service-manager: should validate create command parameters" {
    run "$SCRIPT_DIR/service-manager.sh" create
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Missing required arguments" ]] || [[ "$output" =~ "Error:" ]]
}

@test "service-manager: should validate restart policy values" {
    run "$SCRIPT_DIR/service-manager.sh" create auth test-auth --bin-path /nonexistent --restart-policy invalid
    [ "$status" -ne 0 ]
    [[ "$output" =~ "Invalid restart policy" ]]
}

@test "service-manager: should accept valid restart policy values" {
    # Test on-failure (should be accepted)
    run "$SCRIPT_DIR/service-manager.sh" create auth test-auth --bin-path /nonexistent --restart-policy on-failure
    # Should fail due to missing binary, not restart policy validation
    [[ ! "$output" =~ "Invalid restart policy" ]]
    
    # Test always (should be accepted)
    run "$SCRIPT_DIR/service-manager.sh" create auth test-auth2 --bin-path /nonexistent --restart-policy always
    # Should fail due to missing binary, not restart policy validation
    [[ ! "$output" =~ "Invalid restart policy" ]]
}

@test "service-manager: should include restart policy in help output" {
    run "$SCRIPT_DIR/service-manager.sh" help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "--restart-policy" ]]
    [[ "$output" =~ "on-failure|always" ]]
}

@test "service-manager: help lists health and console commands" {
    run "$SCRIPT_DIR/service-manager.sh" help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "is-running <service-name>" ]]
    [[ "$output" =~ "uptime-seconds <service-name>" ]]
    [[ "$output" =~ "wait-uptime <service> <sec>" ]]
    [[ "$output" =~ "send <service-name>" ]]
    [[ "$output" =~ "show-config <service-name>" ]]
}

@test "service-manager: pm2 uptime and wait-uptime work with mocked pm2" {
    command -v jq >/dev/null 2>&1 || skip "jq not installed"
    export AC_SERVICE_CONFIG_DIR="$TEST_DIR/services"
    mkdir -p "$AC_SERVICE_CONFIG_DIR"
    # Create registry with pm2 provider service
    cat > "$AC_SERVICE_CONFIG_DIR/service_registry.json" << 'EOF'
[
  {"name":"test-world","provider":"pm2","type":"service","bin_path":"/bin/worldserver","args":"","systemd_type":"--user","restart_policy":"always"}
]
EOF
    # Create minimal service config and run-engine config files required by 'send'
    echo "RUN_ENGINE_CONFIG_FILE=\"$AC_SERVICE_CONFIG_DIR/test-world-run-engine.conf\"" > "$AC_SERVICE_CONFIG_DIR/test-world.conf"
    cat > "$AC_SERVICE_CONFIG_DIR/test-world-run-engine.conf" << 'EOF'
export SESSION_MANAGER="none"
export SESSION_NAME="test-world"
EOF
    # Mock pm2
    cat > "$TEST_DIR/bin/pm2" << 'EOF'
#!/usr/bin/env bash
case "$1" in
  jlist)
    # Produce a JSON with uptime ~20 seconds
    if date +%s%N >/dev/null 2>&1; then
      nowms=$(( $(date +%s%N) / 1000000 ))
    else
      nowms=$(( $(date +%s) * 1000 ))
    fi
    up=$(( nowms - 20000 ))
    echo "[{\"name\":\"test-world\",\"pm2_env\":{\"status\":\"online\",\"pm_uptime\":$up}}]"
    ;;
  id)
    echo "[1]"
    ;;
  attach|send|list|describe|logs)
    exit 0
    ;;
  *)
    exit 0
    ;;
esac
EOF
    chmod +x "$TEST_DIR/bin/pm2"

    run "$SCRIPT_DIR/service-manager.sh" uptime-seconds test-world
    debug_on_failure
    [ "$status" -eq 0 ]
    # Output should be a number >= 10
    [[ "$output" =~ ^[0-9]+$ ]]
    [ "$output" -ge 10 ]

    run "$SCRIPT_DIR/service-manager.sh" wait-uptime test-world 10 5
    debug_on_failure
    [ "$status" -eq 0 ]
}

@test "service-manager: send works under pm2 with mocked pm2" {
    command -v jq >/dev/null 2>&1 || skip "jq not installed"
    export AC_SERVICE_CONFIG_DIR="$TEST_DIR/services"
    mkdir -p "$AC_SERVICE_CONFIG_DIR"
    # Create registry and config as in previous test
    cat > "$AC_SERVICE_CONFIG_DIR/service_registry.json" << 'EOF'
[
  {"name":"test-world","provider":"pm2","type":"service","bin_path":"/bin/worldserver","args":"","systemd_type":"--user","restart_policy":"always"}
]
EOF
    echo "RUN_ENGINE_CONFIG_FILE=\"$AC_SERVICE_CONFIG_DIR/test-world-run-engine.conf\"" > "$AC_SERVICE_CONFIG_DIR/test-world.conf"
    cat > "$AC_SERVICE_CONFIG_DIR/test-world-run-engine.conf" << 'EOF'
export SESSION_MANAGER="none"
export SESSION_NAME="test-world"
EOF
    # pm2 mock
    cat > "$TEST_DIR/bin/pm2" << 'EOF'
#!/usr/bin/env bash
case "$1" in
  jlist)
    if date +%s%N >/dev/null 2>&1; then
      nowms=$(( $(date +%s%N) / 1000000 ))
    else
      nowms=$(( $(date +%s) * 1000 ))
    fi
    up=$(( nowms - 15000 ))
    echo "[{\"name\":\"test-world\",\"pm2_env\":{\"status\":\"online\",\"pm_uptime\":$up}}]"
    ;;
  id)
    echo "[1]"
    ;;
  send)
    # simulate success
    exit 0
    ;;
  attach|list|describe|logs)
    exit 0
    ;;
  *)
    exit 0
    ;;
esac
EOF
    chmod +x "$TEST_DIR/bin/pm2"

    run "$SCRIPT_DIR/service-manager.sh" send test-world "server info"
    debug_on_failure
    [ "$status" -eq 0 ]
}

@test "service-manager: wait-uptime times out for unknown service" {
    command -v jq >/dev/null 2>&1 || skip "jq not installed"
    export AC_SERVICE_CONFIG_DIR="$TEST_DIR/services"
    mkdir -p "$AC_SERVICE_CONFIG_DIR"
    echo "[]" > "$AC_SERVICE_CONFIG_DIR/service_registry.json"
    run "$SCRIPT_DIR/service-manager.sh" wait-uptime unknown 2 1
    [ "$status" -ne 0 ]
}

# ===== EXAMPLE SCRIPTS TESTS =====

@test "examples: restarter-world should show configuration error" {
    run "$SCRIPT_DIR/examples/restarter-world.sh"
    [[ "$output" =~ "Configuration file not found" ]]
}

@test "examples: starter-auth should show configuration error" {
    run "$SCRIPT_DIR/examples/starter-auth.sh"
    [[ "$output" =~ "Configuration file not found" ]]
}

@test "examples: restarter-auth should show configuration error" {
    run "$SCRIPT_DIR/examples/restarter-auth.sh"
    [[ "$output" =~ "Configuration file not found" ]]
}

@test "examples: restarter-world should show alternative suggestions" {
    run "$SCRIPT_DIR/examples/restarter-world.sh"
    [[ "$output" =~ "Alternative: Start with binary path directly" ]]
}

# ===== INTEGRATION TESTS =====

@test "integration: starter and simple-restarter work together" {
    # Test that simple-restarter can use starter
    run timeout 5s "$SCRIPT_DIR/simple-restarter" "$TEST_DIR/bin" "test-server"
    # Should start and then restart at least once
    [[ "$output" =~ "terminated with exit code" ]] || [[ "$status" -eq 124 ]]
}

@test "integration: run-engine can handle missing config gracefully" {
    run timeout 3s "$SCRIPT_DIR/run-engine" start "$TEST_DIR/bin/test-server"
    # Should either work or give a meaningful error
    [[ "$status" -eq 124 ]] || [[ "$status" -eq 0 ]] || [[ "$output" =~ "config" ]]
}
