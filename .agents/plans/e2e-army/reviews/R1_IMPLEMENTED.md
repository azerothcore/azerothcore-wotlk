# R1 Implemented — e2e consumer suite

**Branch:** `e2e`  
**Harness:** AzerothGhost `feat/e2e-harness-ac-army` (via `e2e/go.work`)  
**Source feedback:** `reviews/R1_SUMMARY.md`

## Changes

### 1. `meta.Begin` (serial-safe Parallel)

- Added `meta.HasTag` + `meta.Begin` in `e2e/internal/meta/meta.go`.
- `Begin` = `Gate` then `t.Parallel()` **only if** tag `serial` is absent.
- Replaced every `t.Parallel()` + `meta.Gate` / bare `meta.Gate` test entry with `meta.Begin` across smoke + all suites (~102 call sites).

### 2. Loot harness migration (`social/loot`)

- Removed local `tryOpenLoot` / `killLootCorpse` / `itoa`.
- Uses `SpawnKillLootable`, `TryOpenLoot`, `ArmLootStartRoll`, `WaitLootMethod`.
- Issue tests **#26894** / **#26862** (and other outdoor roll paths): **`SoftPass`** when fixture never produces a loot window / group roll (optional outdoor critter rolls). No `Preconditionf` for missing outdoor rolls.
- Soft path logging uses `e2eharness.SoftPass(reason, …)` (grep `SOFT-PASS`) instead of `t.Logf("PASS soft…")`.
- #26862 also uses `WaitUnitHPKnown` + `DamageToFraction`.

### 3. Severity hygiene

| Was | Now | Where |
|-----|-----|--------|
| `Preconditionf` after trade accept / cancel / OOR / stack conserve | `Assertf` | `social/trade` |
| `ConfirmedBugf(t, 0, …)` | `Assertf` | group leave, death HP, quest relog |
| Winner GUID unexpected (after roll exercised) | `Assertf` | loot NBG |
| Inventory count oracle post-AddItem | `Assertf` | loot inventory |

Setup-only failures remain `Preconditionf` / `HarnessFailf`.

### 4. Death → `DieMust`

- Removed local `dieSelf`.
- All death tests use `bot.DieMust(t, 15*time.Second)`.
- Reclaim uses `WaitNear` after tele back to corpse.

### 5. HardDisconnect dual-bot probe

Replaced `HardDisconnect` + `ProbeWorldAlive` / `AssertWorldAlive` pairs with `HardDisconnectAndProbe`:

- `combat/charm` (×3)
- `protocol/session` hard drop
- `combat/vehicles` hard drop
- `quests/escort` logout near unit

### 6. Group loot method wait

- `TestGroup_SetLootMethodNBG` and loot suite `SetLootMethod` call sites wait with `WaitLootMethod`.

### 7. Charm CancelCast (no cast goroutine)

- `CastSpellAtPosition` fire-and-forget on test goroutine.
- `CancelCastWhenChanneling` (with SoftPass if channel never observed).

## Verification

- `go test -tags=e2e -c` all e2e packages: **OK** (compile).
- `go test ./internal/meta`: **OK**.
- Live full suite (`go test -tags=e2e ./... -count=1 -timeout 90m -parallel 1` with local `E2E_*`):
  - First pass: all packages **ok** except `social/trade` — `WaitPlayerMoney` harness fail (live coinage cache lag under pad combat).
  - Fix: trade setup uses `AssertMoneyAtLeast` (CharDB) instead of live `WaitPlayerMoney`.
  - Re-run `./suites/social/trade`: **PASS** (~18s).
  - All other packages green on first live run (loot ~87s, pets ~50s, ulduar ~26s, …).

## R1 checklist mapping

| R1 item | Status |
|---------|--------|
| SoftPass + assert severity | Done |
| Deterministic loot + TryOpenLoot + ArmLootStartRoll | Done |
| DieMust | Done |
| WaitNear / WaitUnitHPKnown / DamageToFraction | Used where applicable |
| serial tag + no Parallel | Done via `meta.Begin` |
| tryOpenLoot goroutine race | Local helper removed; harness TryOpenLoot |
| Soft-pass on issue outdoor rolls | SoftPass (#26894, #26862, NBG, master) |
| Preconditionf / ConfirmedBugf(0) misuse | Assertf for post-drive oracles |
| HardDisconnectAndProbe | Dual-bot probes |
| WaitLootMethod | Group + loot |
| CancelCastWhenChanneling no goroutine | Charm-05 |

## Files touched (primary)

- `e2e/internal/meta/meta.go`
- `e2e/smoke/smoke_e2e_test.go`
- `e2e/suites/**/**/*_e2e_test.go` (all suite packages)
- This report: `reviews/R1_IMPLEMENTED.md`
