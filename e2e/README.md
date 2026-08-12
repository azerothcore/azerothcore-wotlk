# AzerothCore live-stack e2e

Protocol-level regression tests for this repository. They import
[`github.com/walkline/AzerothGhost/e2e/e2eharness`](https://github.com/walkline/AzerothGhost)
and run against a **live** authserver + worldserver + MySQL.

Offline `go test ./...` (without `-tags=e2e`) skips these packages.

Authoring rules for new tests live in the harness:

| Doc | Audience |
|-----|----------|
| [LLM_GUIDE.md](https://github.com/walkline/AzerothGhost/blob/master/e2e/LLM_GUIDE.md) | Compact MUST/NEVER + APIs (LLMs and humans) |
| [EXAMPLES.md](https://github.com/walkline/AzerothGhost/blob/master/e2e/EXAMPLES.md) | Full recipes and skeletons |
| `.agents/docs/e2e-policy.md` | When to add e2e vs unit tests (agent/review policy) |

---

## Prerequisites

1. Running AzerothCore **3.3.5a** authserver + worldserver.
2. MySQL with `acore_auth`, `acore_characters`, and `acore_world` (world DB is required for spawn cleanup and many fixtures).
3. Go **1.24+** and network reachability to auth (default `127.0.0.1:3724`).

Accounts are created by the harness (GM level 3, password `test`). Do not reuse real player accounts.

### Local harness (optional)

For co-development against a local AzerothGhost checkout:

```bash
cd e2e
cp go.work.example go.work   # gitignored; edit the replace path
# replace github.com/walkline/AzerothGhost => /path/to/AzerothGhost
```

CI should pin a real AzerothGhost module version (no path replace).

---

## Environment

Copy and adjust [`e2e/.env.example`](./.env.example). This repo’s local stack often uses `trinity:trinity` credentials.

| Variable | Default (harness) | Meaning |
|----------|-------------------|---------|
| `E2E_AUTH_ADDR` | `127.0.0.1:3724` | Auth / realm-list address clients use |
| `E2E_AUTH_DSN` | `acore:acore@tcp(127.0.0.1:3306)/acore_auth` | Auth DB |
| `E2E_CHAR_DSN` | `acore:acore@tcp(127.0.0.1:3306)/acore_characters` | Characters DB |
| `E2E_WORLD_DSN` | `acore:acore@tcp(127.0.0.1:3306)/acore_world` | World DB (spawns, tele names, cleanup) |

Optional filters (`internal/meta`):

| Variable | Effect |
|----------|--------|
| `E2E_TAGS` | Comma list; test must include **all** listed tags (AND) |
| `E2E_SKIP_TAGS` | Skip if test has **any** listed tag |
| `E2E_ISSUE` | Run only tests with matching `TestMeta.Issue` |
| `E2E_RUNTIME` | Run only `short` / `med` / `long` |
| `E2E_ALLOW_SOFT_PASS` | **`1` only for local debug.** SoftPass is fail-closed by default |

Export vars in your shell (or `set -a; source .env; set +a`) before `go test`.

---

## How to run

**Recommended full suite** (packages parallel, tests serial within each package):

```bash
cd e2e
# export E2E_* from .env.example first
go test -tags=e2e ./... -count=1 -v -timeout 120m -parallel 1
```

`-parallel 1` is intentional: each suite package still runs **concurrently with other packages**, but tests **inside** a package run one at a time and share that package’s sticky isolation pad. Raising in-package parallelism increases pad thrash and flaky combat/loot.

### Make targets

```bash
make e2e-smoke                          # smoke/ + suites tagged smoke
make e2e-category C=quests              # one category tree
make e2e-sub C=spells/aura              # one leaf suite
make e2e-issue N=26549                  # TestAC_26549_* anywhere
make e2e-tags TAGS_FILTER=smoke,short
make e2e-full                           # ./... long timeout
make e2e-list                           # list tests
```

Override parallel / timeout:

```bash
make e2e-full PARALLEL=1 TIMEOUT=120m
```

### Single test / package

```bash
go test -tags=e2e ./suites/combat/pets -count=1 -v -timeout 30m -parallel 1
go test -tags=e2e ./suites/... -run TestPets_SummonWaitDismiss -count=1 -v -timeout 15m
```

---

## Layout

| Path | Role |
|------|------|
| `smoke/` | Fast login / tele / relog guards |
| `suites/<category>/…` | Hierarchical scenarios (directory = category) |
| `suites/issues/` | Tracked AC issue regressions (`TestAC_<n>_…`) |
| `internal/meta` | `TestMeta` + env tag filters + `Begin` (Parallel policy) |
| `internal/fixtures` | Re-exports pads / `PackagePad` for suites that prefer fixtures |

Every live test uses `//go:build e2e` and should call `meta.Begin(t, meta.TestMeta{…})` before expensive setup.

### Category map (current tree)

| Suite path | Typical focus |
|------------|---------------|
| `smoke` | Connectivity, pad tele, relog |
| `suites/combat/{charm,death,pets,threat,vehicles}` | Combat systems |
| `suites/spells/{aura,cast,effects}` | Cast / aura / spell effects |
| `suites/social/{group,loot,trade}` | Multi-bot social protocol |
| `suites/quests/{lifecycle,escort}` | Quest status and escorts |
| `suites/items/equip` | Equip / inventory |
| `suites/protocol/{session,teleport}` | Session and tele |
| `suites/guild/charter_bank` | Charter / bank (Session helpers) |
| `suites/instances/…` | Bind/reset, Ulduar slices |
| `suites/issues` | Named AC issue/PR guards |

---

## Parallelism and isolation

### Model

| Layer | Behaviour |
|-------|-----------|
| **Packages** | Go runs different packages in parallel when you pass `-parallel N` (and have enough packages). |
| **Tests in a package** | With `-parallel 1`, serial. Prefer this for live e2e. |
| **Pads** | `e2eharness.PackagePad(t)` is **sticky per suite folder** for the process lifetime. |

Use **`PackagePad`** for combat/social placement — not a shared Stormwind cell for every suite.

```go
pad := e2eharness.PackagePad(t)
bot.TeleportPad(t, pad)
// multi-bot:
e2eharness.FormPartyAtPad(t, pad, leader, mate)
e2eharness.TeleportAllPad(t, bots, pad)
```

`PadStormwindOutskirts` is a **legacy alias** of the AbandonHouse pad. Prefer `PackagePad(t)`.

### Isolation pads

Far-apart world locations (operator-captured). Combat-heavy packages have preferred 1:1 assignments; other packages take free pads or a stable hash share when the pool is exhausted.

| Pad name | Map | Notes |
|----------|-----|--------|
| `Tower1` | Eastern Kingdoms (0) | Preferred: `combat/threat` |
| `Tower2` | Eastern Kingdoms (0) | Preferred: `combat/death` |
| `AbandonHouse` | Eastern Kingdoms (0) | Preferred: `combat/pets`; legacy SW outskirts alias |
| `NagrandArena` | Outland (530) | Preferred: `combat/charm` |
| `FloatingIsland1` | Outland (530) | Preferred: `combat/vehicles` |
| `FloatingIsland2` | Outland (530) | Preferred: `social/loot` |
| `FloatingIsland3` | Outland (530) | Preferred: `social/group` |
| `InMountains1` | Kalimdor (1) | Preferred: `social/trade` |
| `InMountains2` | Kalimdor (1) | Preferred: `spells/cast` |
| `InMountains3` | Kalimdor (1) | Preferred: `spells/effects` |

Unlisted suites (`smoke`, `spells/aura`, protocol, quests, items, instances, guild, …) receive the first free pad, then hash-share if needed. Logs include `PackagePad suite=… pad=…`.

**Do not** hardcode one shared coordinate for every new combat test. Content that *must* use a fixed world location (tabard designer, instance entrance, named tele) still may — then return to the package pad when possible.

---

## Cleanup rules

Live e2e mutates a real realm. Cleanup is mandatory.

### Persistent spawns (`.npc add` / `.gobject add`)

These write **DB rows**. Bare add without cleanup litters pads (e.g. Crimson Templar 15209, Gift of the Observer GO 194821).

| Do | Do not |
|----|--------|
| `bot.Spawn` / `SpawnKillLootable` / `SpawnGameObject` (register cleanup) | Bare `.npc add` / `.gobject add` |
| `DespawnCreatureSpawn` / `DespawnGameObjectSpawn` by **DB spawn id** | Assume process exit cleans world DB |
| Rely on SQL DELETE + soft live despawn (harness does both) | Only live delete after socket already closed |

Despawn path: **SQL DELETE always** (survives session close) + optional soft `.npc delete` / `.gobject delete` while the socket is open.

**Loot:** do not use `.npc add temp` for loot tests (`TEMPSUMMON_CORPSE_DESPAWN` removes the corpse; use `Spawn` / `SpawnKillLootable`).

### Pets, ghouls, guardians, totems

`NewScenario` / `NewSolo` register `CleanupOwnedSummons` on `t.Cleanup` (dismiss pet + despawn units with SUMMONEDBY/CREATEDBY = player).

After Raise Dead / heavy summon use, also call while still InWorld:

```go
bot.CleanupOwnedSummons(t)
```

### SoftPass (fail-closed)

`SoftPass` / `SoftPassf` **fail the test by default** so unjudgeable fixtures cannot greenwash CI. Only local debug:

```bash
E2E_ALLOW_SOFT_PASS=1 go test -tags=e2e …
```

Prefer `Preconditionf` (setup blocked), `Assertf` / `ConfirmedBugf` (oracle), or `HarnessFailf` (infra).

---

## Writing a test (short)

```go
//go:build e2e

package pets_test

import (
	"testing"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
	"github.com/walkline/AzerothGhost/e2e/e2eharness"
)

func TestPets_Example(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"med", "combat", "pets"},
		Runtime:  "med",
		Category: "combat/pets",
	})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "PetEx",
		Class:  e2eharness.ClassWarlock,
		Level:  80,
		LearnAllClass: true,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))
	// setup (GM ok) → CombatReady before pulls → drive → assert
	t.Logf("PASS …")
}
```

Checklist:

1. `//go:build e2e` + MySQL blank import + `e2eharness`.
2. `meta.Begin` (handles tag filters and `t.Parallel` unless tagged `serial`).
3. Unique short `Prefix`; place with **`PackagePad`**.
4. Flow: fixture → place → setup → `CombatReady` if pull → drive → assert.
5. Waiters (**Arm → Send → Wait**), not fixed long sleeps.
6. Severity helpers for fatals; quest DB only after `Save`.
7. Spawn helpers with cleanup; summons cleaned via `CleanupOwnedSummons`.

Full API surface: harness `LLM_GUIDE.md` / `EXAMPLES.md`.

---

## Common flakes and fixes

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| NPC ignores bot / no aggro | GM mode still on | `CombatReady` / `CombatReadyFull` before pull |
| Boss resets mid-fight | `.gm on` for `.damage` | `Damage` / `DamageKill` (mode off) |
| Melee out of range after `.tele` | Named tele short of target | `GoCreatureID` after `TeleNamed` |
| Unit not in cache after tele | Cache clear on transfer | Re-`WaitUnit` after tele / `WaitInWorld` |
| Random combat on pad | Leftover spawns / pets / other package thrash | Cleanup helpers; `-parallel 1`; PackagePad |
| Cast fails “in combat” on empty pad | Contested pad / leftover temp | `CombatStop`; despawn litter; unique pad |
| Loot roll never starts | Wrong creature or threshold | `CreatureGroupLootFixture` (15209) + `LootThresholdUncommon` |
| Quest status wrong in DB | Asserted before save | `Save` / `QuestStatusAfterSave` |
| GM commands silently ignored | Wrong race language | Set `Race` on bot (harness uses racial language) |
| `SOFT-PASS disabled` fatal | SoftPass without opt-in | Use real severity helpers, or `E2E_ALLOW_SOFT_PASS=1` locally only |
| `precondition:` spam | Stack/DB/env mismatch | Check `E2E_*`, world up, DSN DB names |
| Intermittent pass without code change | Sleeps / races | Replace sleeps with waiters; fix Arm→Send→Wait |

A test that fails intermittently on a **correct** core is a test/harness bug until proven otherwise. Do not hide flakes with longer sleeps or SoftPass.

---

## Severity markers

| Helper | Meaning |
|--------|---------|
| `Preconditionf` | Setup never reached a judgeable state |
| `ConfirmedBugf(t, issue, …)` | Core wrong for tracked AC issue/PR |
| `HarnessFailf` | Infra: timeout, SQL, empty cache, send error |
| `Assertf` / `AssertBugf` | Post-drive product oracle |
| `SoftWarnf` | Non-fatal note |
| `SoftPass` | **Fail-closed** unless `E2E_ALLOW_SOFT_PASS=1` |

---

## Policy (when to add e2e)

Use `.agents/docs/e2e-policy.md` for decision trees (e2e vs unit, mandatory triggers, MVT). This README is **how to run and structure** the suite; the harness guides are **how to author** scenarios.

---

## On-demand e2e CI

Live e2e is **opt-in** (label / manual dispatch). Workflow:
[`.github/workflows/e2e-live.yml`](../.github/workflows/e2e-live.yml).

### How to trigger

| Trigger | What runs |
|---------|-----------|
| Label **`run-e2e`** on a non-draft PR | **Docker stack** + **smoke** e2e |
| Keep label + push | Re-run same |
| Actions → **e2e-live** → Run workflow | Choose `stack`, `scope`, packages, etc. |

### Stack modes (`stack` input)

| Mode | What CI starts | What tests connect to |
|------|----------------|------------------------|
| **`native` (default)** | Same *setup* as [dashboard-ci](../.github/workflows/dashboard-ci.yml): MySQL → **`./acore.sh init`** (compile + DB + **client-data download**) → **pm2** start auth/world (live, not `-dry-run`) | **`127.0.0.1:3724` / `:8085`**, DSN **`acore:acore@tcp(127.0.0.1:3306)/acore_*`** |
| **`docker`** | Root [`docker-compose.yml`](../docker-compose.yml) (pull/build + up) | **`127.0.0.1`**, MySQL **`root:password@…`** |
| **`external`** | Nothing | Secrets / self-hosted `E2E_*` |

#### Native path (default)

1. GitHub **MySQL 8.4** service (`MYSQL_ROOT_PASSWORD=root`).
2. **`./acore.sh init`** — deps, compile this tree, create/import DBs, and **`inst_download_client_data`** (`data.zip` from [wowgaming/client-data](https://github.com/wowgaming/client-data)).
3. **`acore.sh sm start`** auth + world (pm2), wait uptime — real listening servers for the harness.
4. Point realmlist at `127.0.0.1`, export `E2E_*`, run `go test -tags=e2e`.
5. Stop/delete sm services.

We do **not** run `authserver`/`worldserver -dry-run` for e2e (that only gates SQL and exits; no live ports). Setup is “like dashboard-ci’s install + start,” not the dry-run step.

Bot accounts: harness writes **auth DB** (SRP6). No worldserver console required.

#### Docker path (optional)

Pull `acore/ac-wotlk-*` (or `build_images=true`), `compose up`, realmlist localhost, same go test.

### Optional secrets (external stack only)

| Name | Purpose |
|------|---------|
| `E2E_AUTH_ADDR` / `E2E_*_DSN` | Pre-existing realm |
| `E2E_FORCE_RUN` / `E2E_RUNS_ON` | Self-hosted runner with stack already up |
| `E2E_HARNESS_REF` / `E2E_HARNESS_TOKEN` | Private / non-default AzerothGhost |

### Command shape

```bash
# smoke (label run-e2e)
go test -tags=e2e ./smoke/ -count=1 -timeout 60m -parallel 1 -v
E2E_TAGS=smoke go test -tags=e2e ./suites/... -count=1 -timeout 60m -parallel 1 -v
```

### Failure classes (greppable)

| Prefix | Meaning |
|--------|---------|
| `precondition:` | Setup never reached a judgeable state |
| `AC#N CONFIRMED BUG:` | Core wrong for tracked issue N |
| `harness:` | Infra / timeout / SQL / cache |
| `WARNING:` | Soft deviation |

### CI follow-ups

1. Pin `github.com/walkline/AzerothGhost` to a **pseudo-version or tag** in
   `e2e/go.mod` / `go.sum` so CI can eventually drop the path-replace once the
   harness is on the module proxy (the workflow already falls back to checkout).
2. Optional nightly schedule once a dedicated realm and runner exist (not
   enabled by default).
3. Create the **`run-e2e`** label in the GitHub UI (description e.g.
   “Run live-stack e2e workflow”).
