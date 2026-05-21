# Prometheus E2E Test

This app starts the normal AzerothCore Docker worldserver stack with the built-in
Prometheus exporter enabled, runs a Prometheus container beside it, waits for real
scrapes, and executes PromQL queries for gauges and histogram quantiles.

```bash
bash apps/prometheus-test/run.sh
```

The script leaves the stack running so the Prometheus UI can be inspected at
`http://localhost:9090`. Use `--down` to remove the compose stack when the test
finishes.

```bash
bash apps/prometheus-test/run.sh --down
```

Useful knobs:

- `--no-build` skips rebuilding the AzerothCore images. Use it only when the
  images already include the local observability code.
- `--timeout SECONDS` changes the readiness wait limit.
- `DOCKER_PROMETHEUS_EXTERNAL_PORT` changes the Prometheus host port.
- `DOCKER_PROMETHEUS_EXPORTER_EXTERNAL_PORT` changes the exported `/metrics` host port.
- `DOCKER_DB_EXTERNAL_PORT`, `DOCKER_WORLD_EXTERNAL_PORT`, `DOCKER_SOAP_EXTERNAL_PORT`,
  and `DOCKER_AUTH_EXTERNAL_PORT` change the AzerothCore host ports. The script
  defaults these to high ports to avoid clashing with local services.
- `AC_PROMETHEUS_IMAGE` changes the Prometheus image.
