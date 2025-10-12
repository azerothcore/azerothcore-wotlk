# AzerothCore Test Framework

This is the centralized test framework for all AzerothCore bash scripts. It provides a unified way to write, run, and manage tests across all modules.

## Structure

```
apps/test-framework/
├── test-main.sh           # Unified test framework entry point
├── run-bash-tests.sh      # Bash test runner for BATS tests
├── run-core-tests.sh      # AzerothCore unit test runner
├── README.md              # This documentation
├── bats_libs/             # Custom BATS libraries
│   ├── acore-support.bash # Test setup and helpers
│   └── acore-assert.bash  # Custom assertions
└── helpers/               # Test utilities
    └── test_common.sh     # Common test functions and setup
```

## Quick Start

### Using acore.sh (Recommended):
```bash
# Run the unified test framework (interactive menu)
./acore.sh test

# Run bash tests directly
./acore.sh test bash --all

# Run AzerothCore unit tests
./acore.sh test core
```

### From any module directory:
```bash
# Run tests for current module
../test-framework/run-bash-tests.sh --dir .

```

### From test-framework directory:
```bash
# Run all tests in all modules
./run-bash-tests.sh --all

# Run tests for specific module
./run-bash-tests.sh startup-scripts

# List available modules
./run-bash-tests.sh --list

# Run tests with debug info
./run-bash-tests.sh --all --debug
```

### From project root:
```bash
# Run all tests
apps/test-framework/run-bash-tests.sh --all

# Run specific module
apps/test-framework/run-bash-tests.sh startup-scripts

# Run with verbose output
apps/test-framework/run-bash-tests.sh startup-scripts --verbose
```

## Test Types

The framework now supports two types of tests:

1. **Bash Tests** - BATS-based tests for bash scripts and functionality
2. **Core Tests** - AzerothCore C++ unit tests

### Unified Test Framework

The test framework provides a unified entry point through `test-main.sh` which presents an interactive menu:

- **bash**: Run BATS-based bash script tests
- **core**: Run AzerothCore C++ unit tests
- **quit**: Exit the test framework

```bash
# Interactive test menu
./acore.sh test

# Direct test execution
./acore.sh test bash --all        # Run all bash tests
./acore.sh test core              # Run core unit tests
```

## Usage

### Basic Commands

```bash
# Run all tests
./run-bash-tests.sh --all

# Run tests for specific module
./run-bash-tests.sh startup-scripts

# Run tests matching pattern
./run-bash-tests.sh --filter starter

# Run tests in specific directory
./run-bash-tests.sh --dir apps/docker

# Show available modules
./run-bash-tests.sh --list

# Show test count
./run-bash-tests.sh --count
```

### Output Formats

```bash
# Pretty output (default)
./run-bash-tests.sh --pretty

# TAP output for CI/CD
./run-bash-tests.sh --tap

# Verbose output with debug info
./run-bash-tests.sh --verbose --debug
```

## Writing Tests

### Basic Test Structure

```bash
#!/usr/bin/env bats

# Load the AzerothCore test framework
load '../../test-framework/bats_libs/acore-support'
load '../../test-framework/bats_libs/acore-assert'

setup() {
    acore_test_setup    # Standard setup
    # or
    startup_scripts_setup  # For startup scripts
    # or
    compiler_setup         # For compiler tests
    # or
    docker_setup          # For docker tests
}

teardown() {
    acore_test_teardown
}

@test "my test description" {
    run my_command
    assert_success
    assert_output "expected output"
}
```

### Available Setup Functions

- `acore_test_setup` - Basic setup for all tests
- `startup_scripts_setup` - Setup for startup script tests
- `compiler_setup` - Setup for compiler tests
- `docker_setup` - Setup for docker tests
- `extractor_setup` - Setup for extractor tests

### Custom Assertions

```bash
# Assert binary exists and is executable
assert_binary_exists "$TEST_DIR/bin/authserver"

# Assert server started correctly
assert_acore_server_started "$output" "authserver"

# Assert config was loaded
assert_config_loaded "$output" "authserver.conf"

# Assert build success
assert_build_success "$output"

# Assert timeout occurred (for long-running processes)
assert_timeout "$status"

# Assert log contains content
assert_log_contains "$log_file" "Server started"
```

### Test Environment Variables

When using the framework, these variables are automatically set:

- `$TEST_DIR` - Temporary test directory
- `$AC_TEST_ROOT` - Project root directory
- `$AC_TEST_APPS` - Apps directory
- `$BUILDPATH` - Build directory path
- `$SRCPATH` - Source directory path
- `$BINPATH` - Binary directory path
- `$LOGS_PATH` - Logs directory path

### Helper Functions

```bash
# Create test binary
create_test_binary "authserver" 0 2 "Server started"

# Create test config
create_test_config "authserver.conf" "Database.Info = \"127.0.0.1;3306;root;pass;db\""

# Create AzerothCore specific binaries and configs
create_acore_binaries
create_acore_configs

# Run command with timeout
run_with_timeout 5s my_command

# Wait for condition
wait_for_condition "test -f $TEST_DIR/ready" 10 1

# Debug test failure
debug_on_failure
```

## Module Integration

### Adding Tests to a New Module

1. Create a `test/` directory in your module:
   ```bash
   mkdir apps/my-module/test
   ```

2. Create test files (ending in `.bats`):
   ```bash
   touch apps/my-module/test/test_my_feature.bats
   ```

3. Write your tests using the framework (see examples above)

### Running Tests

From your module directory:
```bash
../test-framework/run-bash-tests.sh --dir .
```

From the test framework:
```bash
./run-bash-tests.sh my-module
```

From project root:
```bash
apps/test-framework/run-bash-tests.sh my-module
```

## CI/CD Integration

For continuous integration, use TAP output:

```bash
# Recommended: Use acore.sh integration
./acore.sh test bash --tap --all > test-results.tap

# Direct script usage
cd apps/test-framework
./run-bash-tests.sh --all --tap > test-results.tap

# Or from project root
apps/test-framework/run-bash-tests.sh --all --tap > test-results.tap

# Run core unit tests in CI
./acore.sh test core
```

## Core Tests

The framework now includes support for AzerothCore's C++ unit tests through `run-core-tests.sh`:

```bash
# Run core unit tests
./acore.sh test core

# Direct script usage
apps/test-framework/run-core-tests.sh
```

**Prerequisites for Core Tests:**
- Project must be built with unit tests enabled (`CBUILD_TESTING="ON"` inside `conf/config.sh` that works with the acore.sh compiler)
- Unit test binary should be available at `$BUILDPATH/src/test/unit_tests`

The core test runner will:
1. Check if the unit test binary exists
2. Execute the AzerothCore unit tests
3. Return appropriate exit codes for CI/CD integration

## Available Commands

### Unified Test Framework Commands

Recommended usage through `acore.sh`:
- `./acore.sh test` - Interactive test framework menu
- `./acore.sh test bash [options]` - Run bash tests with options
- `./acore.sh test core` - Run AzerothCore unit tests

### Bash Test Commands

All bash test functionality is available through the `run-bash-tests.sh` script:

### Basic Test Execution
- `./run-bash-tests.sh --all` - Run all tests in all modules
- `./run-bash-tests.sh <module>` - Run tests for specific module
- `./run-bash-tests.sh --dir <path>` - Run tests in specific directory
- `./run-bash-tests.sh --list` - List available modules
- `./run-bash-tests.sh --count` - Show test count

### Output Control
- `./run-bash-tests.sh --verbose` - Verbose output with debug info
- `./run-bash-tests.sh --tap` - TAP output for CI/CD
- `./run-bash-tests.sh --debug` - Debug mode with failure details
- `./run-bash-tests.sh --pretty` - Pretty output (default)

### Test Filtering
- `./run-bash-tests.sh --filter <pattern>` - Run tests matching pattern
- `./run-bash-tests.sh <module> --filter <pattern>` - Filter within module

### Utility Functions
- `./run-bash-tests.sh --help` - Show help message
- Install BATS: Use your system package manager (`apt install bats`, `brew install bats-core`, etc.)


### Direct Script Usage

## Examples

### Running Specific Tests
```bash
# Run only starter-related tests
./run-bash-tests.sh --filter starter

# Run only tests in startup-scripts module
./run-bash-tests.sh startup-scripts

# Run all tests with verbose output
./run-bash-tests.sh --all --verbose

# Run tests in specific directory with debug
./run-bash-tests.sh --dir apps/docker --debug
```

### Development Workflow
```bash
# Recommended: Use acore.sh for unified testing
./acore.sh test                    # Interactive menu
./acore.sh test bash --all         # All bash tests
./acore.sh test core               # Core unit tests

# While developing, run tests frequently from module directory
cd apps/my-module
../test-framework/run-bash-tests.sh --dir .

# Debug failing tests
../test-framework/run-bash-tests.sh --dir . --debug --verbose

# Run specific test pattern
../test-framework/run-bash-tests.sh --dir . --filter my-feature

# From project root - run all tests
./acore.sh test bash --all         # Recommended
apps/test-framework/run-bash-tests.sh --all  # Direct

# Quick test count check
./acore.sh test bash --count       # Recommended
apps/test-framework/run-bash-tests.sh --count  # Direct
```

## Benefits

1. **No Boilerplate**: Minimal setup required for new test modules
2. **Consistent Environment**: All tests use the same setup/teardown
3. **Reusable Utilities**: Common functions available across all tests
4. **Centralized Management**: Single place to update test infrastructure
5. **Flexible Execution**: Run tests for one module, multiple modules, or all modules
6. **CI/CD Ready**: TAP output format supported
7. **Easy Debugging**: Built-in debug helpers and verbose output

## Dependencies

- [BATS (Bash Automated Testing System)](https://github.com/bats-core/bats-core)
- Standard Unix utilities (find, grep, timeout, etc.)

Install BATS with your system package manager:
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install bats

# Fedora/RHEL
sudo dnf install bats

# macOS
brew install bats-core

# Arch Linux
sudo pacman -S bats
```

## Contributing

When adding new test utilities:

1. Add common functions to `helpers/test_common.sh`
2. Add BATS-specific helpers to `bats_libs/acore-support.bash`
3. Add custom assertions to `bats_libs/acore-assert.bash`
4. Update this README with new functionality
