# E2E policy

Mandatory when writing or changing live-stack e2e (`e2e/`). **When** to write tests. **How:** AzerothGhost `LLM_GUIDE.md` / `EXAMPLES.md` (this file does not replace them). Inventory: `e2e/README.md`. Stack: AC 3.3.5a auth+world+MySQL; `E2E_*` may point at a gateway.

## Terms

| Term | Meaning |
|------|---------|
| Unit | Isolated C++/Go; no live stack. `src/test/`. |
| Integration | In-process multi-component; no client login. |
| E2E | `//go:build e2e` Go test: `e2eharness` bots on a running realm; assert protocol / object cache / DB. |
| Player-visible | A real client can observe it. |
| Tracked issue | AC issue/PR id for `ConfirmedBugf`. |

## When

First match wins:

| If | Then |
|----|------|
| Pure calc / parse / bit math / no world | UNIT. NEVER e2e. |
| Covered by existing unit/mocks (`SpellProc*`, …) without login/map/DBC fidelity | UNIT or in-process integration. E2E only if unit cannot reach the path. |
| SQL-only static (text, displayid, non-script loot) | No e2e. Manual optional. |
| SmartAI / conditions / waypoints; outcome only in-world | E2E SHOULD if player-visible and deterministic; else document manual repro. |
| Multi-system on a live session, or protocol/client-observed, or player-repro bugfix | E2E MUST (or update existing). Unit MAY still cover pure pieces. |
| Refactor, no behaviour intent | Update tests that break. Add e2e only if a critical system below lacks an oracle. |

Bias: player-visible and MVT fits → prefer e2e over unit-only. Not a MUST trigger and unsure → do not invent e2e; file a gap.

**MUST add or update e2e** when any of: player-visible bugfix (encode the repro); protocol change; multi-system (combat/aura/death/quest/loot/mount/pet/vehicle/instance/PvP/guild/relog/DB after `.save`); crash/hang/freeze on client action (`ProbeWorldAlive` / `AssertWorldAlive`); existing `TestAC_*` path touched (update, do not drop); critical system with no oracle; claimed blizzlike fix for a tracked issue (`ConfirmedBugf` until fixed).

**MUST NOT** treat “tested in-game” as a substitute when MVT is feasible.

Harness cannot express it: extend harness or file a harness gap; inventory the gap; still unit-test pure logic.

**NEVER / do instead**

| Situation | Do instead |
|-----------|------------|
| Pure math, flags, calendar | `src/test/` |
| Isolated spell-proc already unit-covered; no new player-visible interaction | extend unit |
| SQL-only static, no behavioural branch | SQL review |
| Rename / comments / refactor; no behaviour; not a critical system | existing tests |
| Human judgment, nondeterminism, hours-long lockouts | manual; optional one deterministic slice |
| Same oracle as an existing test | extend or share a helper |
| “World boots” with no behaviour oracle | not feature e2e |
| Invent harness APIs / test the harness | contribute to AzerothGhost |

SHOULD NOT e2e a GM command that is not on the player path (GM setup is fine; assert player-relevant state).

## Authoring (PR gate)

Consumer suite (`e2e/suites/` / `e2e/smoke/`), not only Ghost. `//go:build e2e`. Import `e2eharness` + blank MySQL driver.

Fixture: `NewSolo` / `NewScenario` (`BotSpec` / `ByRole` if roles differ). Prefer `ScenarioBot` over raw `Session` except guild charter/bank.

`meta.Begin` serial by default. Prefix ≤7 chars (auth name max 17 = Prefix+10). Tag `parallel` only when pad-safe.

Name: `TestArea_Behaviour` or `TestAC_<issue>_<Short>`. Comment the issue/PR URL.

Flow: fixture → place → setup (GM ok) → `CombatReady` if pull → drive → assert.

Place: `Teleport` / `TeleportPad` / `TeleNamed` / `GoCreatureID`. Melee: `GoCreatureID` after named tele. Tele clears object cache — re-`WaitUnit`.

Combat: `CombatReady` / `CombatReadyFull` before pulls. NEVER `.gm on` during aggro. Damage: `Damage` / `DamageKill` only — NEVER `.gm on` mid-fight for `.damage`.

Casts: `Cast` / `CastMust` / `CastOrGM` / `CastAtPosition`; fail reason via `SpellFailReasonName`.

Waiters: Arm → Send → Wait. NEVER re-arm during Wait. NEVER replace waiters with long fixed sleeps.
After fire-and-forget GM that later casts depend on (`.pvp on`, `.gm off`), `FlushWorld` on that bot (world-thread ack) or a state waiter (`WaitUnitPvP`).

Quest DB: only after `Save` / `QuestStatusAfterSave`. Spell-summon: NEVER `.npc add` instead of the spell. Set race so GM text uses the character’s language (Horde ≠ Common).

Oracle = behaviour (protocol / cache; DB after `Save`), not “no error”. SHOULD `t.Logf("PASS …")`. SHOULD log GUIDs/spell ids/statuses.

**MVT** (all required or it is not coverage): one primary oracle; real client path; setup failures are `Preconditionf`; correct severity; no footguns above; minutes not hours (long boss waves only if the oracle needs them); runnable with `E2E_*` on stock AC; name+comment findable from issue or mechanic.

```go
//go:build e2e
// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/N
func TestAC_N_ShortOracle(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "issue"}, Runtime: "short", Issue: N})
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Short", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	// place → setup → (CombatReady) → drive → assert
}
```

Run: `go test -tags=e2e -run TestName -count=1 -v` green on fixed core (or only `CONFIRMED BUG` on unfixed). SHOULD `-count=2` stable. Document if exclusive realm needed.

NEVER: invent harness APIs; wrap GM/map without logs; bare `t.Fatalf("CONFIRMED BUG")`; copy whole examples; one test for five issues.

## Fail helpers

Use these, not bare `t.Fatalf`, for classified outcomes:

| Helper | Prefix | When |
|--------|--------|------|
| `Preconditionf` | `precondition:` | Setup never reached a judgeable state |
| `ConfirmedBugf(t, N, …)` | `AC#N CONFIRMED BUG:` | Tracked issue; core wrong (fails CI) |
| `HarnessFailf` / `Assertf` | `harness:` / `assert:` | Infra or fixed-core regression (fails CI) |
| `SoftWarnf` | `WARNING:` | Non-fatal soft deviation |
| Open / unfixed issue | — | Comment out the **entire** test: `TODO(e2e): re-enable when AC#N is fixed` + issue URL. Re-enable body MUST hard-fail. NEVER log+return soft-pass. |

## Critical systems

A PR that implements, fixes, or refactors a row MUST add or update e2e for that oracle, or keep an existing test that still asserts it. If harness cannot: gap in `e2e/README.md` + unit for pure logic.

| System | Oracle / drive |
|--------|----------------|
| Aura apply/strip/consume | apply → action → `AssertAuraRemains` / `AssertAuraConsumed` / aura waiters. Paths: `Spells`, aura scripts, `spell_*.cpp` |
| Cast / charge / pathing | `Cast`/`CastMust` + fail reason / `SMSG_SPELL_GO`; charge stays on bridge; ground AoE landing |
| Death / repop / corpse | `DieAndRepop` (or staged) + surviving system (STAY_ALIVE, Raise Dead) |
| Quest + persistence | `AddQuest` → action → `Save` → `AssertQuestStatus` |
| Relog / extra_flags / GM vis | set → `Save` → `Relog` → DB or protocol |
| Threat / evade / engage | `CombatReady` → `Engage` → still in combat; no evade from bad GM |
| Spell summon | cast the summon spell (not `.npc add`) + summoned unit properties |
| Instance boss AI | place → `CombatReady` → `Engage` → spawn/target/interval (`AssertIntervalNotAccelerated`) |
| Guild charter / bank | Session guild helpers |
| Account / realm GM | `.account set gmlevel` scoped to target realm (#27088 style) |
| Crash-prone cast | repro + `ProbeWorldAlive` / `AssertWorldAlive` |
| Pure helper extracted from the above | unit the helper **and** keep e2e on the player path |

## Coverage

Search consumer suite + Ghost `examples/` + `TestAC_*` for issue, spell, quest, creature, mechanic **before** adding.

Same oracle → same test (extend / table-drive). Same setup, different oracle → helper or `t.Run`, not a second login. NEVER copy Ghost `examples/` without changing the oracle. One tracked issue → one primary `TestAC_<id>_…`; extra edges as `t.Run` or siblings only if isolation requires. Same root cause + same assertion surface → merge.

Inventory (`e2e/README.md` + suite comments): category, one-sentence oracle, P0–P3, `covered` (test name) / `gap` / `blocked-harness` / `manual-only`, issue links, note. MUST update when adding coverage or finding a gap. `blocked-harness` MUST name the missing API (opcode, waiter, multi-realm, …). Closing a P0/P1 gap is preferred when touching that subsystem. When pruning, merge redundant tests and refresh the inventory.

Prefer one solid test per merged player-visible bugfix. Deepen critical categories over new weak ones. Every test: unique oracle + owner (issue or feature). Delete or merge tests that no longer map to a behaviour.

## Priority (next test)

Highest feasible MVT:

| Pri | Cover |
|-----|-------|
| **P0** | Crash / hang / corruption on client action; already-regressed player bug with issue id |
| **P1** | Aura strip/consume/persist; death+quest; relog flags; evade/engage; charge/position; totem/grounding; spell-summon (not GM spawn) |
| **P2** | Single-boss timers/waves/targeting; guild charter/bank; multi-bot PvP; realm-scoped GM / persisted visibility |
| **P3** | QoL, display, nondeterministic farm; full raid clears (out of default growth) |

On a PR: implement e2e for the highest-priority trigger the PR activates. Do not add P3 in the same change unless asked.

## Isolation, comments, flakes

Unique `Prefix`; cleanup via `t.Cleanup`. Do not depend on other tests’ characters/guilds/instance saves. Time oracles: bounded windows with documented thresholds, not “sleep 60s”.

Tracked issues: URL in comment + id in `ConfirmedBugf`. State expected green-on-fixed vs CONFIRMED-BUG-on-unfixed. Do not claim blizzlike without issue, PR, or reviewed wowhead/web evidence.

Flake: classify (infra, timing, pad collision, dirty world, core race). Fix waiters / Arm-Send-Wait / `CombatReady` / unique prefixes / re-wait after tele. Intermittent fail on a correct core is a harness/test bug until proven otherwise. Quarantine (`t.Skip` + reason) only for environmental flake, rare and ticketed. NEVER silent retries or endless timeout bumps.

## Open issues

| Core | Test |
|------|------|
| Unfixed | Comment out the whole test + TODO + URL. Re-enable MUST hard-fail. |
| Fixed | Uncomment; MUST go green. Keep `TestAC_<n>_` and comment. |
| Invalid / cannot repro | Delete the disabled block; no lying TODOs. |
| Env cannot run | `Preconditionf` or inventory `blocked-*`; not a soft PASS. |

NEVER let a test PASS while the product oracle is wrong. NEVER multi-retry + soft-exit to hide flakes or open bugs. NEVER delete a green regression because the issue closed.

Update tests in the same PR as the behaviour change. Harness renames: update consumers in the same landing window. Ghost `e2e/examples/` are patterns; AC regressions live in the consumer suite.

Scratch MUST be `e2e/local/` (gitignored except `local/README.md`). NEVER commit throwaways. Promote into `e2e/suites/` next to related tests in the same PR as the fix. Prefer live e2e over ad-hoc GM when the stack is up.

Local (from `e2e/`): `go test -tags=e2e ./...`. Official-repo PR and master CI: full suite after nopch clang-18 (reuses those binaries). Dispatch `-f scope=smoke` for a smaller run. Touch `.github/workflows/e2e-live.yml` only when changing CI.
