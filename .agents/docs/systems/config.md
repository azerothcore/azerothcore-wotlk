# Config options

## Reading

Read with `sConfigMgr->GetOption<T>("Name", default)` once at startup/reload and cache the value; never in hot paths
or per-call gating checks.
