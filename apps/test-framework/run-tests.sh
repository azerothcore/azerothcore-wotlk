#!/usr/bin/env bash

# AzerothCore Universal Test Runner
# This script provides a unified way to run BATS tests across all modules

# Get the script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Count cores for parallel execution
if [[ -z "$ACORE_TEST_CORES" ]]; then
    if command -v nproc >/dev/null 2>&1; then
        ACORE_TEST_CORES=$(nproc)
    elif command -v sysctl >/dev/null 2>&1; then
        ACORE_TEST_CORES=$(sysctl -n hw.ncpu)
    else
        ACORE_TEST_CORES=1  # Fallback to single core if detection fails
    fi
    export ACORE_TEST_CORES
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${BLUE}AzerothCore Universal Test Runner${NC}"
    echo ""
    echo "Usage: $0 [OPTIONS] [TEST_MODULES...]"
    echo ""
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -v, --verbose   Enable verbose output"
    echo "  -t, --tap       Use TAP output format (for CI/CD)"
    echo "  -p, --pretty    Use pretty output format (default)"
    echo "  -f, --filter    Run only tests matching pattern"
    echo "  -c, --count     Show test count only"
    echo "  -d, --debug     Enable debug mode (shows output on failure)"
    echo "  -l, --list      List available test modules"
    echo "  -j, --jobs <num>  Set number of parallel jobs (default: $ACORE_TEST_CORES)"
    echo "  --dir <path>    Run tests in specific directory"
    echo "  --all           Run all tests in all modules"
    echo ""
    echo "Test Modules:"
    echo "  startup-scripts - Startup script tests"
    echo "  compiler        - Compiler script tests"
    echo "  docker          - Docker-related tests"
    echo "  installer       - Installer script tests"
    echo ""
    echo "Examples:"
    echo "  $0                              # Run tests in current directory"
    echo "  $0 --all                        # Run all tests in all modules"
    echo "  $0 startup-scripts              # Run startup-scripts tests only"
    echo "  $0 --dir apps/docker            # Run tests in specific directory"
    echo "  $0 --verbose startup-scripts    # Run with verbose output"
    echo "  $0 --filter starter             # Run only tests matching 'starter'"
    echo "  $0 --tap                         # Output in TAP format for CI"
}

# Parse command line arguments
VERBOSE=false
TAP=false
PRETTY=true
FILTER=""
COUNT_ONLY=false
DEBUG=false
LIST_MODULES=false
RUN_ALL=false
TEST_DIRS=()
TEST_MODULES=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -t|--tap)
            TAP=true
            PRETTY=false
            shift
            ;;
        -p|--pretty)
            PRETTY=true
            TAP=false
            shift
            ;;
        -f|--filter)
            FILTER="$2"
            shift 2
            ;;
        -c|--count)
            COUNT_ONLY=true
            shift
            ;;
        -d|--debug)
            DEBUG=true
            shift
            ;;
        -l|--list)
            LIST_MODULES=true
            shift
            ;;
        --dir)
            TEST_DIRS+=("$2")
            shift 2
            ;;
        --all)
            RUN_ALL=true
            shift
            ;;
        -j|--jobs)
            if [[ "$2" =~ ^[0-9]+$ ]]; then
                ACORE_TEST_CORES="$2"
                export ACORE_TEST_CORES
                shift 2
            else
                echo -e "${RED}Error: Invalid number of jobs specified: $2${NC}"
                echo "Please provide a valid number."
                exit 1
            fi
            ;;
        *.bats)
            # Individual test files
            TEST_FILES+=("$1")
            shift
            ;;
        *)
            # Assume it's a module name
            TEST_MODULES+=("$1")
            shift
            ;;
    esac
done

# Check if BATS is installed
if ! command -v bats >/dev/null 2>&1; then
    echo -e "${RED}Error: BATS is not installed${NC}"
    echo "Please install BATS first:"
    echo "  sudo apt install bats    # On Ubuntu/Debian"
    echo "  brew install bats-core   # On macOS"
    echo "Or run: make install-bats"
    exit 1
fi

# Function to find test directories
find_test_directories() {
    local search_paths=()
    
    if [[ "$RUN_ALL" == true ]]; then
        # Find all test directories
        mapfile -t search_paths < <(find "$PROJECT_ROOT/apps" -type d -name "test" 2>/dev/null)
    elif [[ ${#TEST_DIRS[@]} -gt 0 ]]; then
        # Use specified directories
        for dir in "${TEST_DIRS[@]}"; do
            if [[ -d "$PROJECT_ROOT/$dir/test" ]]; then
                search_paths+=("$PROJECT_ROOT/$dir/test")
            elif [[ -d "$dir/test" ]]; then
                search_paths+=("$dir/test")
            elif [[ -d "$dir" ]]; then
                search_paths+=("$dir")
            else
                echo -e "${YELLOW}Warning: Test directory not found: $dir${NC}"
            fi
        done
    elif [[ ${#TEST_MODULES[@]} -gt 0 ]]; then
        # Use specified modules
        for module in "${TEST_MODULES[@]}"; do
            if [[ -d "$PROJECT_ROOT/apps/$module/test" ]]; then
                search_paths+=("$PROJECT_ROOT/apps/$module/test")
            else
                echo -e "${YELLOW}Warning: Module test directory not found: $module${NC}"
            fi
        done
    else
        # Default: use current directory or startup-scripts if run from test-framework
        if [[ "$(basename "$PWD")" == "test-framework" ]]; then
            search_paths=("$PROJECT_ROOT/apps/startup-scripts/test")
        elif [[ -d "./test" ]]; then
            search_paths=("./test")
        else
            echo -e "${YELLOW}No test directory found. Use --all or specify a module.${NC}"
            exit 0
        fi
    fi
    
    echo "${search_paths[@]}"
}

# Function to list available modules
list_modules() {
    echo -e "${BLUE}Available test modules:${NC}"
    find "$PROJECT_ROOT/apps" -type d -name "test" 2>/dev/null | while read -r test_dir; do
        module_name=$(basename "$(dirname "$test_dir")")
        test_count=$(find "$test_dir" -name "*.bats" | wc -l)
        echo -e "  ${GREEN}$module_name${NC} ($test_count test files)"
    done
}

# Show available modules if requested
if [[ "$LIST_MODULES" == true ]]; then
    list_modules
    exit 0
fi

# Find test directories
TEST_SEARCH_PATHS=($(find_test_directories))

if [[ ${#TEST_SEARCH_PATHS[@]} -eq 0 ]]; then
    echo -e "${YELLOW}No test directories found.${NC}"
    echo "Use --list to see available modules."
    exit 0
fi

# Collect all test files
TEST_FILES=()
for test_dir in "${TEST_SEARCH_PATHS[@]}"; do
    if [[ -d "$test_dir" ]]; then
        if [[ -n "$FILTER" ]]; then
            # Find test files matching filter
            mapfile -t filtered_files < <(find "$test_dir" -name "*.bats" -exec grep -l "$FILTER" {} \; 2>/dev/null)
            TEST_FILES+=("${filtered_files[@]}")
        else
            # Use all test files in directory
            mapfile -t dir_files < <(find "$test_dir" -name "*.bats" 2>/dev/null)
            TEST_FILES+=("${dir_files[@]}")
        fi
    fi
done

if [[ ${#TEST_FILES[@]} -eq 0 ]]; then
    if [[ -n "$FILTER" ]]; then
        echo -e "${YELLOW}No test files found matching filter: $FILTER${NC}"
    else
        echo -e "${YELLOW}No test files found in specified directories.${NC}"
    fi
    exit 0
fi

# Show test count only
if [[ "$COUNT_ONLY" == true ]]; then
    total_tests=0
    for file in "${TEST_FILES[@]}"; do
        count=$(grep -c "^@test" "$file" 2>/dev/null || echo 0)
        total_tests=$((total_tests + count))
    done
    echo "Total tests: $total_tests"
    echo "Test files: ${#TEST_FILES[@]}"
    echo "Test directories: ${#TEST_SEARCH_PATHS[@]}"
    exit 0
fi

# Build BATS command
BATS_CMD="bats --jobs $ACORE_TEST_CORES"

# Set output format
if [[ "$TAP" == true ]]; then
    BATS_CMD+=" --formatter tap"
elif [[ "$PRETTY" == true ]]; then
    BATS_CMD+=" --formatter pretty"
fi

# Enable verbose output
if [[ "$VERBOSE" == true ]]; then
    BATS_CMD+=" --verbose-run"
fi

# Add filter if specified
if [[ -n "$FILTER" ]]; then
    BATS_CMD+=" --filter '$FILTER'"
fi

# Add test files
BATS_CMD+=" ${TEST_FILES[*]}"

echo -e "${BLUE}Running AzerothCore Tests with ${ACORE_TEST_CORES} jobs${NC}"
echo -e "${YELLOW}Test directories: ${TEST_SEARCH_PATHS[*]}${NC}"
echo -e "${YELLOW}Test files: ${#TEST_FILES[@]}${NC}"
if [[ -n "$FILTER" ]]; then
    echo -e "${YELLOW}Filter: $FILTER${NC}"
fi
echo ""

# Run tests
if [[ "$DEBUG" == true ]]; then
    echo -e "${YELLOW}Command: $BATS_CMD${NC}"
    echo ""
fi

# Execute BATS
if eval "$BATS_CMD"; then
    echo ""
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
else
    exit_code=$?
    echo ""
    echo -e "${RED}❌ Some tests failed!${NC}"
    
    if [[ "$DEBUG" == true ]]; then
        echo -e "${YELLOW}Tip: Check the output above for detailed error information${NC}"
        echo -e "${YELLOW}You can also run individual tests for more detailed debugging:${NC}"
        echo -e "${YELLOW}  $0 --verbose --filter <test_name>${NC}"
    fi
    
    exit $exit_code
fi
