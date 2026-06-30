#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

PROMETHEUS_SERVICE="${PROMETHEUS_SERVICE:-ac-prometheus}"
WORLD_SERVICE="${WORLD_SERVICE:-ac-worldserver}"
PROMETHEUS_INTERNAL_URL="http://localhost:9090"

export DOCKER_DB_EXTERNAL_PORT="${DOCKER_DB_EXTERNAL_PORT:-13306}"
export DOCKER_WORLD_EXTERNAL_PORT="${DOCKER_WORLD_EXTERNAL_PORT:-18085}"
export DOCKER_SOAP_EXTERNAL_PORT="${DOCKER_SOAP_EXTERNAL_PORT:-17878}"
export DOCKER_AUTH_EXTERNAL_PORT="${DOCKER_AUTH_EXTERNAL_PORT:-13724}"
export DOCKER_PROMETHEUS_EXTERNAL_PORT="${DOCKER_PROMETHEUS_EXTERNAL_PORT:-9090}"
export DOCKER_PROMETHEUS_EXPORTER_EXTERNAL_PORT="${DOCKER_PROMETHEUS_EXPORTER_EXTERNAL_PORT:-9200}"

PROMETHEUS_URL="${PROMETHEUS_URL:-http://localhost:${DOCKER_PROMETHEUS_EXTERNAL_PORT:-9090}}"
EXPORTER_URL="${EXPORTER_URL:-http://localhost:${DOCKER_PROMETHEUS_EXPORTER_EXTERNAL_PORT:-9200}/metrics}"
WAIT_TIMEOUT="${AC_PROMETHEUS_TEST_TIMEOUT:-300}"
SCRAPE_SETTLE_SECONDS="${AC_PROMETHEUS_TEST_SCRAPE_SETTLE_SECONDS:-8}"

BUILD=1
DOWN_ON_EXIT=0

COMPOSE=(
    docker compose
    --project-directory "$ROOT_DIR"
    -f "$ROOT_DIR/docker-compose.yml"
    -f "$SCRIPT_DIR/docker-compose.yml"
)

function usage() {
    cat <<EOF
Run the AzerothCore Prometheus end-to-end Docker test.

Usage:
  $(basename "$0") [--no-build] [--down] [--timeout SECONDS]

Options:
  --no-build         Start existing images without rebuilding them. Use only when
                     the images already include the local observability code.
  --down             Stop and remove the compose stack after the test.
  --timeout SECONDS  Wait limit for Prometheus/worldserver readiness.
  -h, --help         Show this help text.

Environment:
  DOCKER_PROMETHEUS_EXTERNAL_PORT           Host port for Prometheus, default 9090.
  DOCKER_PROMETHEUS_EXPORTER_EXTERNAL_PORT  Host port for worldserver /metrics, default 9200.
  DOCKER_DB_EXTERNAL_PORT                   Host port for MySQL, default 13306.
  DOCKER_WORLD_EXTERNAL_PORT                Host port for worldserver, default 18085.
  DOCKER_SOAP_EXTERNAL_PORT                 Host port for SOAP, default 17878.
  DOCKER_AUTH_EXTERNAL_PORT                 Host port for authserver, default 13724.
  AC_PROMETHEUS_IMAGE                       Prometheus image, default prom/prometheus:v2.54.1.
  AC_PROMETHEUS_TEST_TIMEOUT                Readiness timeout, default 300.
EOF
}

function log() {
    printf '[prometheus-e2e] %s\n' "$*"
}

function compose() {
    "${COMPOSE[@]}" "$@"
}

function promql() {
    compose exec -T "$PROMETHEUS_SERVICE" promtool query instant "$PROMETHEUS_INTERNAL_URL" "$1"
}

function query_matches() {
    local expression="$1"
    local pattern="$2"
    local output

    if ! output="$(promql "$expression" 2>&1)"; then
        return 1
    fi

    printf '%s\n' "$output" | grep -Eq "$pattern"
}

function wait_until() {
    local name="$1"
    shift

    local start
    start="$(date +%s)"

    while true; do
        if "$@"; then
            log "$name is ready."
            return 0
        fi

        local now
        now="$(date +%s)"
        if (( now - start >= WAIT_TIMEOUT )); then
            log "$name did not become ready within ${WAIT_TIMEOUT}s."
            return 1
        fi

        sleep 2
    done
}

function print_query() {
    local name="$1"
    local expression="$2"
    local output

    log "$name"
    output="$(promql "$expression")"
    if ! printf '%s\n' "$output" | grep -q '=>'; then
        printf 'PromQL query returned no samples: %s\n' "$expression" >&2
        return 1
    fi

    printf '%s\n' "$output" | sed 's/^/  /'
}

function diagnose_failure() {
    log "Prometheus target status:"
    promql 'up{job="azerothcore-worldserver"}' || true
    promql 'scrape_duration_seconds{job="azerothcore-worldserver"}' || true
    promql 'scrape_samples_scraped{job="azerothcore-worldserver"}' || true
    log "Recent $WORLD_SERVICE logs:"
    compose logs --tail=80 "$WORLD_SERVICE" || true
    log "Recent $PROMETHEUS_SERVICE logs:"
    compose logs --tail=80 "$PROMETHEUS_SERVICE" || true
}

function on_exit() {
    local status=$?

    if (( status != 0 )); then
        diagnose_failure
    fi

    if (( DOWN_ON_EXIT == 1 )); then
        log "Stopping compose stack."
        compose down || true
    fi
}

trap on_exit EXIT

while (( $# > 0 )); do
    case "$1" in
        --no-build)
            BUILD=0
            ;;
        --down)
            DOWN_ON_EXIT=1
            ;;
        --timeout)
            if (( $# < 2 )); then
                echo "--timeout requires a value" >&2
                exit 1
            fi
            WAIT_TIMEOUT="$2"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1" >&2
            usage
            exit 1
            ;;
    esac

    shift
done

export AC_PROMETHEUS_TEST_DIR="$SCRIPT_DIR"

up_args=(up -d)
if (( BUILD == 1 )); then
    up_args+=(--build)
fi
up_args+=("$WORLD_SERVICE" "$PROMETHEUS_SERVICE")

log "Starting worldserver and Prometheus with Docker Compose."
compose "${up_args[@]}"

wait_until "Prometheus API" query_matches 'vector(1)' '=>[[:space:]]*1([[:space:]@]|$)'
wait_until "worldserver scrape target" query_matches 'up{job="azerothcore-worldserver"}' '=>[[:space:]]*1([[:space:]@]|$)'
wait_until "world update histogram" query_matches 'sum(ac_world_update_duration_seconds_count)' '=>[[:space:]]*[1-9][0-9]*([.][0-9]+)?([[:space:]@]|$)'
wait_until "world update p95 query" query_matches 'histogram_quantile(0.95, sum(rate(ac_world_update_duration_seconds_bucket[1m])) by (le))' '=>[[:space:]]*[0-9]'

log "Letting Prometheus collect a few more scrapes."
sleep "$SCRAPE_SETTLE_SECONDS"

print_query "scrape target" 'up{job="azerothcore-worldserver"}'
print_query "build info" 'ac_build_info'
print_query "online players" 'ac_world_online_players'
print_query "sessions by state" 'ac_world_sessions'
print_query "database queue size" 'ac_database_queue_size'
print_query "world update p50 seconds" 'histogram_quantile(0.50, sum(rate(ac_world_update_duration_seconds_bucket[1m])) by (le))'
print_query "world update p95 seconds" 'histogram_quantile(0.95, sum(rate(ac_world_update_duration_seconds_bucket[1m])) by (le))'
print_query "world update p99 seconds" 'histogram_quantile(0.99, sum(rate(ac_world_update_duration_seconds_bucket[1m])) by (le))'
print_query "world update average seconds" 'sum(rate(ac_world_update_duration_seconds_sum[1m])) / sum(rate(ac_world_update_duration_seconds_count[1m]))'
print_query "world update interval p95 seconds" 'histogram_quantile(0.95, sum(rate(ac_world_update_interval_seconds_bucket[1m])) by (le))'
print_query "slowest world update phases p95 seconds" 'topk(5, histogram_quantile(0.95, sum(rate(ac_world_update_phase_duration_seconds_bucket[1m])) by (le, phase)))'

log "Prometheus E2E test passed."
log "Prometheus UI: $PROMETHEUS_URL"
log "Worldserver metrics endpoint: $EXPORTER_URL"
