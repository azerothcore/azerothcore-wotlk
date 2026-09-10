# e2e/local — scratch / debug tests (not committed)

Everything under this directory is **gitignored** except this README.
Do not add tests here unless asked. Do not promote scratch into `smoke/` or `suites/` unless asked.

Do **not** put permanent regressions here; CI and reviewers only look at `smoke/` and `suites/`.

## How to run

From `e2e/` with stack up and `E2E_*` set (see parent [README.md](../README.md)):

```bash
# all scratch packages
go test -tags=e2e ./local/... -count=1 -v -timeout 30m -parallel 1

# one existing package
go test -tags=e2e ./local/foo -count=1 -v -timeout 15m -parallel 1
```

From the repository root: `make -C e2e e2e-local`. From `e2e/`: `make e2e-local`.
