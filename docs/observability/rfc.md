# Observability v1 RFC

Status: Draft

## Summary

Observability v1 adds a Prometheus metrics exporter to `worldserver` for operational metrics. It is intentionally separate from the existing Influx/Grafana `Metric` system. The first version focuses on safe, low-cardinality Prometheus export for runtime health and performance. Event, alarm, and QuestDB-style observability are out of scope for v1 and should be designed as a separate backend later.

The v1 implementation should be enabled by default at runtime, bind safely by default, and have a compile-time option to remove it from builds that do not want observability code.

## Goals

- Expose `worldserver` operational metrics through a built-in Prometheus `/metrics` endpoint.
- Keep the design orthogonal to the existing `Metric` system during v1.
- Support counters, gauges, and classic histograms.
- Support labels, with strict low-cardinality rules.
- Add a constant `realm` label to all exported AzerothCore metrics.
- Instrument a small required set of high-value worldserver metrics.
- Prefer call-site metric declarations for scoped timings, with duplicate metric-name detection.
- Keep the exporter secure by default.

## Non-Goals

- No `authserver` exporter in v1.
- No Grafana dashboards in v1.
- No alerting/alarm rules in v1.
- No QuestDB/event backend in v1.
- No shared abstraction between Prometheus metrics and future event/alarm storage.
- No Prometheus client library dependency.
- No native histograms in v1.
- No player names, account IDs, session IDs, GUIDs, IPs, or other high-cardinality/private values in metrics.
- No removal of the existing `Metric` system as part of v1.

## Background

The current metric system is Influx-oriented and mixes producer API, queueing, line protocol formatting, transport, and event-style records. That shape does not map cleanly to Prometheus. Prometheus is best used for low-cardinality operational time series, while richer events and alarms fit a later append-oriented backend such as QuestDB.

The existing design also has producer-side and data-model problems that Observability v1 should avoid:

- It encourages high-cardinality tags and event fields. Existing call sites include values such as `account_id`, player names, and map instance IDs, which are bad dimensions for time-series databases in general. In Prometheus specifically, they would create large, expensive, hard-to-query series sets.
- It can produce a large amount of low-value throughput. Fine-grained timers and event-style records are pushed continuously even when the result is not a useful operational time series.
- Each metric sample allocates. `Metric::LogValue` and `Metric::LogEvent` allocate a `MetricData`; the non-intrusive `MPSCQueue` allocates a queue node; records carry dynamic `std::string` and `std::vector<MetricTag>` storage; sending then formats the batch into another dynamic stream.
- The queue is unbounded. If the backend is slow or unavailable, metric production can continue growing memory instead of applying backpressure or dropping low-priority samples deliberately.
- Formatting happens too early and too specifically. Values are converted into Influx line-protocol strings before the backend boundary, which makes the public metric API depend on an output format.
- Events, gauges, counters, and timings are blurred together as category/value or category/title/text records. That is awkward for Prometheus, where metric type and label cardinality are part of the contract.
- Transport, formatting, backend config, batching, retry behavior, and the producer API live in one `Metric` class, making it difficult to reason about cost and difficult to evolve safely.
- The old event model stores arbitrary text. That text is useful for logs or a future event backend, but it is not useful as Prometheus metric data.

Observability v1 should therefore be a Prometheus-shaped module, not a new backend bolted onto the existing `Metric` pipeline.

The existing `Metric` system should remain untouched while Observability v1 proves the new Prometheus path. Once the new approach works well, useful instrumentation can be ported and the old metrics system should be fully removed to avoid maintaining two competing systems.

## Export Model

`worldserver` exposes metrics directly through a built-in HTTP `/metrics` endpoint.

The endpoint should:

- Be enabled at runtime by default.
- Bind to loopback by default, for example `127.0.0.1`.
- Require explicit config to bind publicly.
- Have no built-in auth in v1.
- Document that public binding can expose operational data.
- Be disabled at compile time through a dedicated CMake option.

If the exporter cannot start or bind its configured endpoint, `worldserver` should log a clear error and continue normal operation without the exporter.

The implementation should use the existing Boost asynchronous runtime. Boost.Beast is preferred for HTTP framing if available in supported Boost builds. Raw Asio HTTP parsing should only be used if Beast is unavailable and the implementation remains deliberately tiny and well-tested.

## Metric Model

V1 supports:

- Counter: monotonically increasing values such as processed packets or error totals.
- Gauge: current values such as online players or DB queue size.
- Classic histogram: duration observations exported as `_bucket`, `_sum`, and `_count` series.

V1 may use the Prometheus info-as-gauge convention for metadata:

```text
ac_build_info{realm="...",version="...",revision="..."} 1
```

Summaries, native histograms, and stateset/enum metrics are deferred.

Metric updates and scrapes must be thread-safe. The exact synchronization and snapshot model is an implementation detail.

Prometheus documentation currently recommends native histograms when available, but v1 uses classic histograms because the planned exporter is simple text exposition without a Prometheus client library. Native histograms can be revisited later.

References:

- [Prometheus metric types](https://prometheus.io/docs/concepts/metric_types/)
- [Prometheus histograms and summaries](https://prometheus.io/docs/practices/histograms/)

## Labels

Labels are supported in v1, but only for bounded, low-cardinality dimensions.

All AzerothCore metrics exported by `worldserver` include:

- `realm`: realm name from loaded realm info.

Allowed label examples:

- `database`: `login`, `character`, `world`
- `phase`: a fixed set of world update phase names
- `opcode`: opcode name from the opcode table
- `map_id`: map ID
- `state`: fixed state values such as `active`, `queued`, `active_and_queued`

Disallowed label examples:

- Account ID
- Character/player name
- Session ID
- IP address
- GUID
- Map instance ID
- Arbitrary text
- Connection strings, tokens, or secrets

If a value would create unbounded or user-specific series, it belongs in a future event/alarm backend, not Prometheus v1.

Label values should be emitted safely for Prometheus text exposition and should keep canonical bounded values stable instead of cosmetically rewriting them.

## Producer API Direction

The v1 producer API should use long-lived metric objects. A file-local metrics aggregate keeps ownership explicit and avoids accidental counter or histogram resets when normal gameplay objects are recreated. For example:

```cpp
namespace
{
    struct WorldMetrics
    {
        Acore::Observability::Histogram UpdateDuration
        {
            "ac_world_update_duration_seconds",
            "Duration of one world update tick.",
            Acore::Observability::DefaultDurationBuckets()
        };
    };

    WorldMetrics Metrics;
}

void World::Update(uint32 diff)
{
    Acore::Observability::ScopedHistogramTimer updateTimer = Metrics.UpdateDuration.Measure();

    // ...
}
```

Final class and helper names are implementation details, but the important behavior is:

- Metric state should be owned by long-lived objects, not by recreated gameplay objects.
- Observations should be cheap after first registration.
- Duration histograms should use the shared default duration buckets unless a metric has a clearly different scale.
- A metric name has a single owner.
- The same metric name must not be used from multiple code locations.
- Duplicate metric name registration from another file/line/function should fail loudly in debug builds. In release builds, it should log an error, ignore the duplicate registration, and keep the first registered owner.
- If related work is measured in multiple places, use distinct metric names or one intentional owner block with bounded labels.

## Histograms

V1 uses classic histograms with explicit bucket boundaries.

Buckets provide in-process aggregation for many observations. AzerothCore should not store every duration in memory for percentile calculation. It should update histogram bucket counters, and Prometheus/Grafana should calculate averages and p95/p99-style views from scraped bucket data.

Duration histograms should use a shared default bucket list covering fast paths and visible stalls:
`100us`, `250us`, `500us`, `1ms`, `2.5ms`, `5ms`, `10ms`, `25ms`, `50ms`, `100ms`, `250ms`, `500ms`, `1s`, and `2.5s`.

Bucket lists may still differ per metric when a measurement has a clearly different scale. Durations should use seconds as the base unit in metric names and values.

Custom runtime bucket configuration is deferred.

## Required V1 Metrics

The exact names are examples, but the required v1 metric set should cover these measurements.

### Build Info

- Metric: `ac_build_info`
- Type: info-as-gauge
- Labels: `realm`, `version`, `revision`
- Instrumentation point: after realm info is loaded in [`src/server/apps/worldserver/Main.cpp`](../../src/server/apps/worldserver/Main.cpp#L286)
- Data sources: `realm.Name`, `GitRevision::GetFullVersion()`, `GitRevision::GetHash()`

### World Status Gauges

- Metrics:
  - `ac_world_online_players`
  - `ac_world_sessions`
  - `ac_database_queue_size`
- Types: gauge
- Labels:
  - `ac_world_sessions`: `state`
  - `ac_database_queue_size`: `database`
- Instrumentation point: a new runtime status collection function called from [`src/server/game/World/World.cpp`](../../src/server/game/World/World.cpp#L1320), near the existing metrics update block
- Data sources:
  - `sWorldSessionMgr->GetPlayerCount()`
  - `sWorldSessionMgr->GetActiveSessionCount()`
  - `sWorldSessionMgr->GetQueuedSessionCount()`
  - `sWorldSessionMgr->GetActiveAndQueuedSessionCount()`
  - `LoginDatabase.QueueSize()`
  - `CharacterDatabase.QueueSize()`
  - `WorldDatabase.QueueSize()`

### World Update Duration

- Metric: `ac_world_update_duration_seconds`
- Type: classic histogram
- Labels: none beyond constant `realm`
- Instrumentation point: top of `World::Update(uint32 diff)` in [`src/server/game/World/World.cpp`](../../src/server/game/World/World.cpp#L1099)
- Current related metric: `world_update_time_total`

### World Update Interval

- Metric: `ac_world_update_interval_seconds`
- Type: classic histogram
- Labels: none beyond constant `realm`
- Instrumentation point: near `sWorldUpdateTime.UpdateWithDiff(diff)` in [`src/server/game/World/World.cpp`](../../src/server/game/World/World.cpp#L1107)
- Current related metric: `update_time_diff` in [`src/server/game/World/World.cpp`](../../src/server/game/World/World.cpp#L1323)

### World Update Phases

- Metric: `ac_world_update_phase_duration_seconds`
- Type: classic histogram
- Labels: `phase`
- Instrumentation points: existing named world update phase timers in [`src/server/game/World/World.cpp`](../../src/server/game/World/World.cpp#L1136) through [`src/server/game/World/World.cpp`](../../src/server/game/World/World.cpp#L1320)
- Current related metric: `world_update_time` with `type` tag

The `phase` label must come from a fixed set of string literals.

### Map Update Duration

- Metric: `ac_map_update_duration_seconds`
- Type: classic histogram
- Labels: `map_id`
- Instrumentation point: around `m_map.Update(m_diff, s_diff)` in [`src/server/game/Maps/MapUpdater.cpp`](../../src/server/game/Maps/MapUpdater.cpp#L45)
- Current related metric: `map_update_time_diff`

Do not include `map_instanceid` in v1.

### Session Update Duration

- Metric: `ac_world_session_update_duration_seconds`
- Type: classic histogram
- Labels: none beyond constant `realm`
- Instrumentation point: around `WorldSessionMgr::UpdateSessions(uint32 const diff)` in [`src/server/game/Server/WorldSessionMgr.cpp`](../../src/server/game/Server/WorldSessionMgr.cpp#L92)

Do not add per-account or per-session labels. The existing `world_update_sessions_time` detailed metric uses `account_id`; that shape is not Prometheus-friendly and is out of scope for v1.

### Opcode Duration

- Metric: `ac_world_opcode_duration_seconds`
- Type: classic histogram
- Labels: `opcode`
- Instrumentation point: around opcode handler execution in [`src/server/game/Server/WorldSession.cpp`](../../src/server/game/Server/WorldSession.cpp#L390)
- Current related metric: `worldsession_update_opcode_time`

The `opcode` label should use the opcode name from `opHandle->Name`. Opcode names are bounded by the opcode table and are acceptable for v1.

### Packet Counters

- Metrics:
  - `ac_world_packets_processed_total`
  - `ac_world_addon_messages_total`
- Type: counter
- Labels: none beyond constant `realm`
- Instrumentation point: where processed packet and addon message counts are known in [`src/server/game/Server/WorldSession.cpp`](../../src/server/game/Server/WorldSession.cpp#L543)
- Current related metrics: `processed_packets`, `addon_messages`

Counters should increment by the observed count. They should not be gauges reset to zero.

## Deferred Existing Metric Sites

These existing metric sites should not be part of the required v1 pass:

- Player login/logout event records with player names.
- Map tile load/unload event text.
- MMap/path calculation event-style records.
- Per-map-instance object counts from [`src/server/game/Maps/Map.cpp`](../../src/server/game/Maps/Map.cpp#L523).

Some of these may become counters or histograms later, but event-shaped data with names or text belongs to the future event backend.

## Configuration

Suggested runtime configuration keys:

```ini
Observability.Enable = 1
Observability.Prometheus.Enable = 1
Observability.Prometheus.IP = "127.0.0.1"
Observability.Prometheus.Port = 9200
```

Suggested compile-time option:

```cmake
WITHOUT_OBSERVABILITY=0
```

Final names may change to match project conventions.

The compile-time option has the strongest precedence: `WITHOUT_OBSERVABILITY=1` removes all observability features from the build. At runtime, `Observability.Enable` is the global switch for all observability features. `Observability.Prometheus.Enable` controls only the Prometheus exporter. In v1, Prometheus is the only concrete observability backend, but future backends should still remain behind `Observability.Enable`.

Prometheus export is enabled only when both `Observability.Enable` and `Observability.Prometheus.Enable` are enabled.

## Security

The exporter must not expose secrets or player-private information.

The endpoint should bind to loopback by default. Operators who bind it to `0.0.0.0` are responsible for network policy, reverse proxy auth, firewalling, or other protections.

Metrics should be useful for operations without exposing player identity, account identity, network identity, database connection strings, auth tokens, or arbitrary text payloads.

## Open Questions

- Exact producer helper and namespace names.
- Exact default port.
- Exact custom bucket lists for metrics that do not use the default duration buckets.
- Whether Boost.Beast is available across all supported Boost configurations, and if not, whether to add a constrained raw-Asio HTTP implementation.
- Whether status gauges should be updated every world tick, on a lightweight interval, or via an explicit observability timer on the world thread.
