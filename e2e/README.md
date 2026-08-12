# AzerothCore live-stack e2e

Protocol-level regression tests for this repository. They import
[`github.com/walkline/AzerothGhost/e2e/e2eharness`](https://github.com/walkline/AzerothGhost)
and run against a live authserver + worldserver + MySQL.

## Layout

| Path | Role |
|------|------|
| `smoke/` | Fast connectivity / login guards |
| `suites/<category>/…` | Hierarchical scenarios (**directory = Go package**) |
| `internal/meta` | `TestMeta` + env tag filters |
| `internal/fixtures` | Shared pads / IDs |

Harness authoring: AzerothGhost `e2e/LLM_GUIDE.md` and `e2e/EXAMPLES.md`.

## Environment

```bash
export E2E_AUTH_ADDR=127.0.0.1:3724
export E2E_AUTH_DSN='trinity:trinity@tcp(127.0.0.1:3306)/acore_auth'
export E2E_CHAR_DSN='trinity:trinity@tcp(127.0.0.1:3306)/acore_characters'
export E2E_WORLD_DSN='trinity:trinity@tcp(127.0.0.1:3306)/acore_world'  # required for spawn SQL cleanup
unset E2E_ALLOW_SOFT_PASS   # SoftPass fail-closed unless explicitly allowed
```

## Run (package-parallel, test-serial)

```bash
cd e2e
# Packages (folders) run in parallel; tests inside a package run one at a time.
go test -tags=e2e ./... -count=1 -timeout 180m -parallel 1

# Cap package concurrency if the world feels overloaded:
go test -tags=e2e ./... -count=1 -timeout 180m -parallel 1 -p 4

make e2e-smoke
make e2e-category C=quests
make e2e-sub C=spells/aura
```

### Isolation pads (`PackagePad`)

Parallel packages must not share one Stormwind cell. Each suite folder gets a
**sticky** pad via `e2eharness.PackagePad(t)` (process lifetime).

| Pad | Map | Typical suite |
|-----|-----|----------------|
| Tower1 | 0 EK (SW) | combat/threat |
| Tower2 | 0 EK (SW) | combat/death |
| AbandonHouse | 0 Elwynn | combat/pets |
| NagrandArena | 530 | combat/charm |
| FloatingIsland1–3 | 530 Nagrand | vehicles, loot, group |
| InMountains1–3 | 1 Kalimdor | trade, spells/cast, spells/effects |

Usage in tests:

```go
pad := e2eharness.PackagePad(t)
bot.TeleportPad(t, pad)
// multi-bot: TeleportAllPad(t, bots, pad) or FormPartyAtPad(t, pad, leader, mates...)
```

Do **not** hard-code a single SW outskirts coordinate for combat suites.

### Spawn / pet cleanup

- Persistent `.npc add` / `.gobject add` → use harness helpers (`Spawn`, `SpawnKillLootable`, `SpawnGameObject`) so **SQL + live** cleanup runs.
- Set `E2E_WORLD_DSN` or spawn-id capture fails and litter accumulates.
- Pets / Risen Ghoul: `NewScenario` registers `CleanupOwnedSummons`; call it after Raise Dead while still in-world.

## On-demand CI

Live e2e is **not** run on every PR by default. Trigger via GitHub label / workflow
dispatch when the workflow lands (see `.github/workflows/` and the CI section
maintained with the pipeline).
