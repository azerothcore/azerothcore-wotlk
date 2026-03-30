# Configuration Severity Policy

The configuration loader can decide how strictly it should react when it
encounters missing files, undefined options or invalid values. This document
describes the available knobs and provides ready-to-use presets.

## Severity Levels

Each policy entry maps a **key** to one of the following severities:

| Severity | Description                                                                 |
|----------|-----------------------------------------------------------------------------|
| `skip`   | Ignore the problem and continue silently.                                   |
| `warn`   | Log a warning and continue.                                                 |
| `error`  | Log an error and continue (useful to surface issues without aborting).      |
| `fatal`  | Log a fatal message and abort the process immediately.                      |

## Policy Keys

The following keys can be customised:

| Key                | Applies to                                                            |
|--------------------|----------------------------------------------------------------------|
| `default`          | Fallback severity for any key that is not explicitly overridden.     |
| `missing_file`     | Missing or empty configuration files (worldserver.conf, modules, …). |
| `missing_option`   | Options looked up in code but not present in any config file.         |
| `critical_option`  | Required options (`RealmID`, `*DatabaseInfo`, …).                     |
| `unknown_option`   | Options found in optional configs that the core does not recognise.   |
| `value_error`      | Options that cannot be converted to the expected type.                |

> Critical options remain fatal by default to prevent the core from booting with
> incomplete database details; you can relax them if required.

## Configuration Channels

### `config.sh`

`conf/dist/config.sh` exposes the `AC_CONFIG_POLICY` variable alongside a few
presets:

```bash
# Mirrors the default behaviour (errors, with fatal criticals)
export AC_CONFIG_POLICY="$AC_CONFIG_POLICY_PRESET_DEFAULT"

# Skip anything non-critical so the core can bootstrap from defaults + env vars
export AC_CONFIG_POLICY="$AC_CONFIG_POLICY_PRESET_ZERO_CONF"

# Treat everything strictly (useful for CI)
export AC_CONFIG_POLICY="$AC_CONFIG_POLICY_PRESET_STRICT"
```

The presets are defined as:

```bash
AC_CONFIG_POLICY_PRESET_DEFAULT='missing_file=error,missing_option=warn,critical_option=fatal,unknown_option=error,value_error=error'
AC_CONFIG_POLICY_PRESET_ZERO_CONF='default=skip,critical_option=fatal,unknown_option=warn,value_error=warn'
AC_CONFIG_POLICY_PRESET_STRICT='default=error,missing_file=fatal,missing_option=error,critical_option=fatal,unknown_option=error,value_error=error'
```

Modify or extend these entries to suit your deployment.

### Environment Variable

The runtime honours the `AC_CONFIG_POLICY` environment variable, so you can
override the policy without editing `config.sh`:

```bash
export AC_CONFIG_POLICY="default=skip,critical_option=fatal"
./acore.sh run-worldserver
```

### CLI Override

Every server/tool executable accepts `--config-policy`:

```bash
./bin/worldserver --config-policy="missing_file=fatal,unknown_option=warn"
./bin/authserver --config-policy "$AC_CONFIG_POLICY_PRESET_STRICT"
```

The CLI flag takes precedence over the environment and `config.sh`.

## Quick Presets

| Preset        | Intended use                                                              |
|---------------|---------------------------------------------------------------------------|
| `legacy`      | Default behaviour before this feature (errors for missing files/options). |
| `zero-conf`   | Zero-touch deployments; rely on defaults/env vars where possible.         |
| `strict`      | Fail-fast in CI or controlled environments.                               |

Feel free to clone these presets and store your own variants inside
`config.sh` or deployment scripts.

## Tips

- Pair `fatal` severities with monitoring so regressions in configuration
  surface quickly.
- When experimenting locally, start with `zero-conf` and elevate specific keys
  to `error`/`fatal` as you validate your setup.
- Remember that number parsing errors (`value_error`) often indicate typos;
  keep them at least `error` unless you have a very good reason.
