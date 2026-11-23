# Config options

Core options load in `src/server/game/World/WorldConfig.cpp` into `CONFIG_*`/`RATE_*` values; keys are documented in
the `*.conf.dist` templates (`src/server/apps/**`, `modules/*/conf/`).

## Reading

Read with `sConfigMgr->GetOption<T>("Name", default)` once at startup/reload and cache the value; never in hot paths
or per-call gating checks.

## Validation and bad setup

- Validate values where they are loaded: in `WorldConfig.cpp`, give `SetConfigValue` a validator lambda and description
  matching the real downstream limit (e.g. the spline layer's min/max speed), not a loose bound like `> 0`. A
  rejected value falls back to the default; it isn't clamped.
- Reject invalid setup (zero thread or connection count, an inconsistently wired component) with an error, never
  report success and then silently do nothing.
- Never `ASSERT` on misconfiguration: `LOG_ERROR` and fall back to a safe default, or fail startup by returning non-zero
  like the other `Main.cpp` checks, not with `ABORT`. When failing before the logging io_context runs with async logging
  on, make sure the message still prints (`sLog->SetSynchronous()` or stderr).

## `.conf.dist` entry

When adding an option or changing its behaviour, its `.conf.dist` block matches what the code does after the change:

- Bounded values get a `Range:` line directly above `Default:` (see `CharactersPerRealm`).
- State what an invalid or out-of-range value does: rejected with fallback to the default, or clamped. No
  "Maximum"/"Minimum" wording for a rejected value.
- Describe every situation the code applies the option in, not just the main one.
- Say plainly when it disables a security or enforcement check (bans, IP/country lock, digest verification, security
  level).
