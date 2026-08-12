# A2 — E2E Policy (AzerothCore + AzerothGhost harness)

**Status:** phase-0 policy (authoritative for e2e-army work; promote into permanent agent docs when ready — see §10).  
**Audience:** humans and LLMs changing AC core/scripts/SQL and/or writing live-stack tests.  
**Harness:** [AzerothGhost `e2e/e2eharness`](https://github.com/walkline/AzerothGhost) — import from consumer tests; authoring rules in harness `LLM_GUIDE.md` / `EXAMPLES.md`.  
**Stack under test:** AzerothCore 3.3.5a (auth + world + MySQL). Optional gateway in front is fine if `E2E_*` points at the client entrypoint.

This policy tells **when** to write e2e, **what quality bar** is mandatory, and **how coverage must grow** without dumping unmaintainable duplicates. Wording uses **MUST / SHOULD / NEVER** so LLMs can treat rules as hard gates.

---

## 0. Vocabulary

| Term | Meaning |
|------|---------|
| **Unit test** | C++ (or pure Go) test of isolated logic; no live auth/world/MySQL. Lives primarily under `src/test/`. |
| **Integration test** | Multi-component test **inside process** (mocks/stubs, partial fixtures, in-process DB hooks) without a full client login. Still not a live realm. |
| **E2E / live-stack test** | Go test with `//go:build e2e` that logs protocol bots into a **running** AC stack via `e2eharness`, drives WotLK 3.3.5a packets, asserts on protocol / object cache / DB. |
| **Player-visible path** | Behaviour a real client can observe: combat, auras, quests, death, loot, mounts, guild, teleport, flags, crashes, wrong packet results. |
| **Tracked issue** | AC GitHub issue/PR number used with `ConfirmedBugf(t, N, …)`. |

Harness severity markers (MUST use these, not bare `t.Fatalf` for classified outcomes):

| Helper | Prefix / meaning |
|--------|------------------|
| `Preconditionf` | `precondition:` — setup never reached a judgeable state |
| `ConfirmedBugf(t, N, …)` | `AC#N CONFIRMED BUG:` — core behaviour wrong for tracked issue |
| `HarnessFailf` | `harness:` — infra/timeout/SQL/cache/send failure |
| `SoftWarnf` | `WARNING:` — non-fatal soft deviation |

---

## 1. Decision tree — e2e vs unit vs integration

Walk top-down. Stop at the first matching leaf.

```
Change or bug under consideration
│
├─ Pure calculation / pure data transform / no game world needed?
│    (formulas, bit math, parsers, string/time helpers, RBAC table math, …)
│    → UNIT test. NEVER e2e.
│
├─ Logic expressible with existing AC unit/mocks (SpellProc*, CombatManager*, …)
│    without requiring login, map, or real DBC/world spawn fidelity?
│    → UNIT (prefer) or INTEGRATION (in-process fixtures).
│    → E2E only if unit cannot reach the real code path (see mandatory triggers).
│
├─ SQL-only static content with no C++/script behaviour change?
│    (template numbers, gossip text, loot rows with no script interaction)
│    → NO automated e2e required. Manual smoke optional. Unit N/A.
│
├─ SmartAI / conditions / waypoint data where outcome is only visible in-world
│    and cannot be asserted by SQL shape alone?
│    → E2E SHOULD if player-visible and deterministic; else document manual repro.
│
├─ Multi-system interaction on a live session?
│    (spell + aura + combat + death; quest + save + DB; relog + flag; guild protocol;
│     boss script + threat + evade; client cast vs GM path; crash on cast)
│    → E2E MUST when player-visible (see §2). Unit MAY still cover pure sub-pieces.
│
├─ Protocol-level / client-observed behaviour?
│    (SMSG_SPELL_GO, aura apply/remove, quest status, item push, teleport, PvP flag)
│    → E2E MUST (or update existing e2e that already asserts this).
│
├─ Bugfix with a clear repro a player can perform?
│    → E2E MUST as regression guard (prefer ConfirmedBugf until fixed, then keep green).
│
└─ Refactor with no intended behaviour change?
     → Update existing tests that would break; add e2e only if the refactor touches
       a critical system listed in §5.1 and coverage is missing.
```

**Default bias (coverage growth):** when uncertain between “unit only” and “unit + e2e”, and the path is player-visible, **prefer adding e2e** *if* a minimum viable test (§7) fits in one focused scenario. When uncertain between “e2e” and “nothing”, and the change is not in §2, **do not invent e2e** — file a backlog gap instead (§5.3).

---

## 2. Mandatory e2e triggers (MUST)

An LLM or author **MUST** add a new e2e test, or **update an existing** e2e that already covers the same behaviour, when **any** of the following is true:

| # | Trigger | Notes |
|---|---------|--------|
| M1 | **Bugfix with a player-visible path** | Issue has (or PR adds) repro steps a client can perform. Test encodes those steps. |
| M2 | **Protocol-level behaviour change** | Opcode handling, spell go/fail, aura update, quest status, item push, movement/teleport ack, guild charter/bank packets. |
| M3 | **Multi-system interaction** | Two or more of: combat, auras, death, quests, loot, mounts, pets, vehicles, instances, PvP, guild, relog, DB persistence after `.save`. |
| M4 | **Crash / hang / world freeze on a client action** | Cast, engage, relog, zone-in — use `ProbeWorldAlive` / `AssertWorldAlive` where relevant. |
| M5 | **Regression of a previously e2e-covered behaviour** | Touching code paths already under `TestAC_*` or consumer suite — update assertions, do not delete coverage. |
| M6 | **Critical-system change with missing e2e** | Paths listed in §5.1 (aura strip/consume, STAY_ALIVE quests, GM visibility/relog, boss evade from GM misuse class of bugs, charge/position, spell-summon ranks, totem absorption, etc.) when no test asserts the behaviour. |
| M7 | **Fix claimed “blizzlike” for a tracked AC issue/PR** | Test name / comment links the issue; failure mode uses `ConfirmedBugf` on unfixed cores. |

**MUST NOT** claim “tested in-game only” as a substitute for M1–M7 when a minimum viable e2e (§7) is feasible with current harness APIs.

If the harness **cannot** express the scenario yet (missing opcode waiter, no API):

1. Prefer extending harness (or file a harness gap) over skipping forever.  
2. Until possible: document **gap** in the category inventory (§5.3) with issue id + blocked reason.  
3. Still add unit/integration coverage for any pure sub-logic.

---

## 3. When NOT to write e2e (NEVER / SHOULD NOT)

| # | Situation | Do instead |
|---|-----------|------------|
| N1 | Pure math, formulas, sorting, bitflags, calendar math | `src/test/` unit |
| N2 | Isolated spell-proc pipeline pieces already well covered by `SpellProc*` unit tests, with no new player-visible interaction | extend unit tests |
| N3 | SQL-only static data with no behavioural branch (text, displayid, non-script loot odds alone) | SQL review + optional manual spot check |
| N4 | Codestyle, renames, comment-only, pure refactors with no behaviour intent **and** no critical-system touch | existing tests green; no new e2e |
| N5 | Scenario requires human judgment / non-determinism / hours-long raid lockouts | manual checklist; optional narrow e2e of one deterministic slice |
| N6 | Duplicate of an existing e2e that already asserts the same oracle (same spell/quest/flag outcome) | extend the existing test or share a helper; see §5.2 |
| N7 | “Smoke that world boots” without a behaviour oracle | out of scope for feature e2e (infra health checks are separate) |
| N8 | Testing harness itself or inventing APIs not in `e2eharness` | contribute to harness repo; consumer tests MUST NOT invent fake helpers |

**SHOULD NOT** write e2e solely to exercise a GM command that is not part of the player-visible bug path (setup GM is fine; the assertion must be on player-relevant state).

---

## 4. Authoring checklist for LLMs (must-pass gates before PR)

Treat this as a **PR gate**. Every box is MUST unless marked SHOULD.

### 4.1 Policy gates

- [ ] Decision tree (§1) applied; e2e is justified by a mandatory trigger (§2) or an explicit coverage-growth rule (§5).  
- [ ] Not a forbidden case (§3 / N1–N8).  
- [ ] Existing suite searched for the same issue id / spell / quest / creature / mechanic — no redundant twin (§5.2).  
- [ ] If change touches a critical system (§5.1), matching e2e added or updated, **or** a tracked gap entry written with owner/issue.

### 4.2 Structure gates

- [ ] Test lives in the **consumer** module (AC e2e suite / project tests), not only inside AzerothGhost unless contributing to that repo.  
- [ ] `//go:build e2e` on live tests so offline `go test` stays clean.  
- [ ] Imports: `e2e/e2eharness` + blank-import MySQL driver.  
- [ ] Fixture: `NewSolo` / `NewScenario` (+ `BotSpec` / `ByRole` when roles differ). Prefer `ScenarioBot` methods over raw `Session` except guild charter/bank.  
- [ ] Unique short `Prefix`; `t.Parallel()` when isolation allows.  
- [ ] Name: `TestArea_Behaviour` or `TestAC_<issue>_<ShortName>` for tracked issues.  
- [ ] Comment links AC issue/PR URL when applicable.

### 4.3 Scenario flow gates

- [ ] Order: **fixture → place → setup (GM ok) → CombatReady if pull → drive → assert**.  
- [ ] Place via `Teleport` / `TeleportPad` / `TeleNamed` / `GoCreatureID` as appropriate; melee paths use `GoCreatureID` after named tele.  
- [ ] Combat: `CombatReady` / `CombatReadyFull` before pulls; **NEVER** leave `.gm on` during aggro.  
- [ ] Damage: `Damage` / `DamageKill` only — **NEVER** `.gm on` mid-fight for `.damage`.  
- [ ] Casts: `Cast` / `CastMust` / `CastOrGM` / `CastAtPosition`; report fail with `SpellFailReasonName`.  
- [ ] Waiters: **Arm → Send → Wait**; never re-arm during Wait; never replace waiters with long fixed sleeps.  
- [ ] Quest DB: assert only after `Save` / `QuestStatusAfterSave`.  
- [ ] Spell-summon bugs: **NEVER** `.npc add` as a substitute for the summon spell path.  
- [ ] Race set correctly so GM lines use the character’s native language (Horde ≠ Common).

### 4.4 Assertion gates

- [ ] Oracle is **behaviour**, not “no error returned”. Prefer protocol / object cache; DB when state is persisted.  
- [ ] Severity helpers used correctly (§6).  
- [ ] Tracked wrong-core outcome → `ConfirmedBugf(t, issue, …)`; setup blocked → `Preconditionf`; infra → `HarnessFailf`.  
- [ ] Final `t.Logf("PASS …")` or equivalent success log SHOULD be present for greppable CI.

### 4.5 Run gates (when stack available)

- [ ] `go test -tags=e2e … -run TestName -count=1 -v` passes on fixed core (or fails only with expected `CONFIRMED BUG` on intentionally unfixed core).  
- [ ] Re-run once (`-count=2` or second invocation) SHOULD be stable — no flake from sleeps/races.  
- [ ] Does not require exclusive realm if `t.Parallel`-safe; document if isolation needed.

### 4.6 Anti-patterns (NEVER)

- Invent harness APIs or wrap away GM/map state without logs.  
- Fixed multi-second sleeps as primary sync.  
- Bare `t.Fatalf("CONFIRMED BUG…")` instead of `ConfirmedBugf`.  
- `.gm on` mid-fight; bare `.tele` when melee range matters.  
- Asserting quest status before `.save`.  
- Copy-pasting entire example files without narrowing the oracle.  
- One giant test that covers five unrelated issues (split; share setup helpers if needed).

Full API surface and templates: harness `LLM_GUIDE.md` + `EXAMPLES.md`. This policy **does not** replace those docs; it decides **when** and **how strictly** to use them.

---

## 5. Coverage growth enforcement (scales without rot)

### 5.1 Critical systems — change forces e2e

If a PR **touches** (implements, fixes, or refactors behaviour in) any row below, the author **MUST** add or update e2e covering that row’s **oracle**, unless an existing test already asserts the same oracle and remains valid.

| Critical system | Example oracles (player-visible) | Example paths in AC |
|-----------------|----------------------------------|---------------------|
| Aura apply / strip / consume | aura remains after mount; totem effect not consumed by hostile AoE; proc aura consumed by finisher | `src/server/game/Spells`, aura scripts, `spell_*.cpp` |
| Spell cast results / charge / pathing | charge stays on bridge; cast fail reasons; ground AoE landing | Movement + spell cast |
| Death / repop / corpse interactions | STAY_ALIVE quest fails; Raise Dead near corpse no crash | Player/Unit death, pet spells |
| Quest status + persistence | status after death/save; objective progress | Quest system + CharDB |
| Relog / extra_flags / GM visibility | `.gm vis off` survives relog | Login, `extra_flags` |
| Combat threat / evade / engage | boss stays in combat after engage; no evade from bad GM mode | Combat/Threat managers, scripts |
| Spell summon vs `.npc add` | engineering dummy rank levels from **spell** summon | Spell summon effects |
| Instance boss scripts (player-facing) | wave timers not accelerated; adds target correctly | `src/server/scripts/...` boss AI |
| Guild charter / bank protocol | charter buy/sign; bank deposit visibility | Guild handlers |
| Account/realm GM scope | `.account set gmlevel` only target realm | Auth/account access |
| Crash-prone cast combinations | world still accepts login/probe after cast | Various |

**LLM instruction (machine-checkable wording):**

> If you change code under a critical system in §5.1, you MUST add or update an e2e test that asserts the player-visible oracle for that change. If harness cannot express it, you MUST open/update a gap entry in the inventory (§5.3) and still add unit tests for pure logic.

### 5.2 Prevent redundant tests

Before adding a file/test:

1. **Search** consumer suite + harness `examples/` + known `TestAC_*` for: issue number, spell id, quest id, creature entry, unique mechanic keywords.  
2. **Same oracle → same test.** Prefer extending assertions or table-driving cases over a second login/scenario.  
3. **Same setup, different oracle →** shared helper or subtest (`t.Run`), not a full duplicate login when avoidable.  
4. **NEVER** duplicate published `examples/` into consumer suite without changing the oracle (examples are patterns, not ownership of AC regression).  
5. **One tracked issue → one primary e2e** (`TestAC_<id>_…`). Related edge cases SHOULD be `t.Run` under that test or clearly named siblings only if isolation requires it.

Redundancy veto: if a new test would pass/fail for the **same root cause and same assertion surface** as an existing one, **merge** rather than add.

### 5.3 Track gaps (inventory + backlog)

Maintain a living inventory (path TBD at promotion time; during e2e-army use `e2e-army` plan artifacts or the consumer suite README):

| Field | Purpose |
|-------|---------|
| **Category** | e.g. Auras, Quests, Death, BossScripts, Guild, PvP, Relog, Movement, Pets, Vehicles, Instances |
| **Behaviour / oracle** | One sentence: what “correct” looks like |
| **Priority** | P0–P3 from §8 |
| **Coverage** | `covered` (test name) / `gap` / `blocked-harness` / `manual-only` |
| **Issue links** | AC issue/PR numbers |
| **Owner / note** | Why blocked; suggested harness API |

**Rules:**

- Closing a **P0/P1 gap** is preferred work when touching that subsystem.  
- LLMs **MUST** update inventory status when they add coverage or discover a gap.  
- **Blocked-harness** gaps MUST name the missing capability (opcode, waiter, multi-realm, etc.).

### 5.4 LLM “if you change X you must add/update Y” map

| If you change… | You MUST add/update… |
|----------------|----------------------|
| Aura duration/dispel/consume/proc strip logic | E2E: apply → action → `AssertAuraRemains` / `AssertAuraConsumed` / unit aura waiters |
| Quest fail/complete/objective C++ or script | E2E: `AddQuest` → action → `Save` → `AssertQuestStatus` |
| Death/repop/corpse use | E2E: `DieAndRepop` (or staged die/wait/release) + surviving system assert |
| Boss AI timers, spawns, evade, targeting | E2E: place → `CombatReady` → `Engage` → spawn tracker / target observe / interval assert |
| Spell effect that summons creatures | E2E: cast summon spell (not `.npc add`) + assert summoned unit properties |
| Client cast fail/success semantics | E2E: `Cast`/`CastMust` + fail reason / `SMSG_SPELL_GO` path |
| Relog-persisted flags / GM visibility | E2E: set → `Save` → `Relog` → DB or protocol assert |
| Guild charter/bank handlers | E2E via Session guild helpers (charter/bank patterns) |
| Account access / realm-scoped GM | E2E multi-realm or DB assert scoped to realm (see existing #27088 style) |
| Crash fix on cast/use | E2E: repro cast + `ProbeWorldAlive` / `AssertWorldAlive` |
| Unit-test-only pure helper extracted from above | Unit test for helper **and** keep/adjust e2e for the player path |

### 5.5 Growth rate (practical, not metric theater)

- Prefer **one solid test per merged player-visible bugfix** over bulk speculative scenarios.  
- Prefer **deepening** critical categories (better oracles, edge `t.Run`s) over new categories with weak sleeps.  
- Suite size is healthy when every test has a unique oracle and a named owner (issue or feature). Delete or merge tests that no longer map to a behaviour.

---

## 6. Test quality bar

Aligned with harness `LLM_GUIDE.md` / `EXAMPLES.md` / `README.md`.

### 6.1 Assertions

- **MUST** assert an observable oracle: packet success/fail, aura presence, unit combat/HP/death, quest status, DB flag, world alive.  
- **MUST** prefer protocol + object cache; use DB after `Save` for persistence.  
- **MUST** distinguish severities:

| Situation | Helper |
|-----------|--------|
| Setup cannot reach judgeable state (missing NPC, cast setup fail, wrong preconditions) | `Preconditionf` |
| Core behaviour wrong for tracked issue/PR | `ConfirmedBugf(t, issue, …)` |
| Timeout, SQL error, empty cache, send failure, waiter infra | `HarnessFailf` |
| Soft deviation; test may still pass | `SoftWarnf` |

- **NEVER** use bare `t.Fatalf` for those four classes when helpers apply.  
- **SHOULD** log enough GUIDs/spell ids/statuses to debug without a re-run guess.

### 6.2 Scenario discipline

| Rule | MUST / NEVER |
|------|----------------|
| `CombatReady` before real pulls | MUST |
| `.gm on` mid-fight for `.damage` | NEVER — use `Damage` / `DamageKill` |
| Pull with GM mode still on | NEVER |
| Fixed long sleeps as primary sync | NEVER — waiters / cache polls |
| Re-arm waiter during Wait | NEVER |
| Bare `.tele` when melee required | NEVER — `GoCreatureID` |
| `.npc add` when bug is spell-summon | NEVER |
| Invent harness APIs | NEVER |
| `ScenarioBot` for combat/quest/aura/death/relog | SHOULD (default) |
| Session helpers for guild charter/bank | SHOULD when testing guild protocol |
| `t.Parallel` when safe | SHOULD |

### 6.3 Determinism & isolation

- Prefer unique account `Prefix`; cleanup via harness `t.Cleanup`.  
- Avoid depending on other tests’ characters, guilds, or instance saves.  
- Time-based oracles use bounded windows with documented thresholds (see `AssertIntervalNotAccelerated`), not “sleep 60s and hope”.  
- Map/teleport clears object cache — re-`WaitUnit` after tele.

### 6.4 Comments & traceability

- Tracked issues: link in comment + issue number in `ConfirmedBugf`.  
- State whether the test expects **green on fixed core** / **CONFIRMED BUG on unfixed**.  
- Do not claim blizzlike without citing issue, PR, or wowhead/web evidence reviewed by the author.

---

## 7. Minimum viable test (MVT)

An e2e is **mergeable** only if it meets **all** of:

1. **Single primary oracle** — one behaviour under test (extra soft checks allowed, not five unrelated bugs).  
2. **Real path** — drives the same class of action a player/client would (cast, die, relog, engage, quest, etc.), not only SQL edits.  
3. **Reachability** — setup uses harness fixtures; failures in setup are `Preconditionf`, not silent skips.  
4. **Correct severity** on the oracle failure (`ConfirmedBugf` / hard assert).  
5. **No footguns** from §6.2.  
6. **≤ ~one focused scenario runtime** in the common case (aim minutes, not hours); long boss waves only when the oracle requires them.  
7. **Runnable** with documented `E2E_*` env against stock AC.  
8. **Name + comment** sufficient to find the test from the issue or mechanic.

**Skeleton (illustrative):**

```go
//go:build e2e

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/NNNNN
func TestAC_NNNNN_ShortOracle(t *testing.T) {
	t.Parallel()
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "Short", Race: e2eharness.RaceHuman,
		Class: e2eharness.ClassWarrior, Level: 80, LearnAllClass: true,
	})
	// place → setup → (CombatReady) → drive → assert with severity helpers
}
```

Anything less than MVT is a draft, a gap note, or a harness spike — not coverage.

---

## 8. Regression priority ranking (what to cover first)

When choosing the next e2e (human or LLM backlog work), pick the highest priority with a feasible MVT:

| Priority | Category | Why first |
|----------|----------|-----------|
| **P0** | Crashes / world hangs / data corruption on client actions | Stability |
| **P0** | Already-regressed player bugs with clear repro + issue id | Closes loops; ConfirmedBugf → green documents fix |
| **P1** | Auras (strip/consume/persist), death+quest, relog flags | High footgun density; harness-strong |
| **P1** | Combat evade/engage mistakes, charge/position, totem/grounding class bugs | Protocol-visible; frequent regressions |
| **P1** | Spell-summon correctness (not GM spawn) | Easy to “fix” wrongly with `.npc add` |
| **P2** | Boss script timers/waves/targeting (single-boss slices) | Valuable but longer/flakier if poorly written |
| **P2** | Guild charter/bank, multi-bot PvP interactions | Harness support exists; narrower audience |
| **P2** | Account/realm GM scope, visibility, commands with persisted state | Security/ops adjacent |
| **P3** | Convenience QoL, pure display, non-deterministic farm content | Manual or backlog |
| **P3** | Full raid clear simulations | Out of scope for default growth |

**Selection rule for LLMs:** given a PR, implement e2e for the highest-priority trigger the PR activates; do not expand into P3 scenarios in the same change unless asked.

---

## 9. Maintenance policy

### 9.1 Flaky tests

| Action | Rule |
|--------|------|
| Diagnose | Classify: harness/infra (`HarnessFailf` patterns), timing, parallel collision, world state dirt, true race in core |
| Fix first | Replace sleeps with waiters; fix Arm/Send/Wait; ensure `CombatReady`; unique prefixes; re-wait after tele |
| Quarantine | Only if flake is environmental and not a core bug; mark clearly (`t.Skip` with reason **SHOULD** be rare and ticketed) |
| NEVER | Silent retry loops that hide core nondeterminism; raising timeouts endlessly without a waiter |

A test that fails intermittently on a correct core is a **harness/test bug** until proven otherwise.

### 9.2 `ConfirmedBugf` vs fix vs quarantine

| Core state | Test expectation |
|------------|------------------|
| Bug open / unfixed | Test **MUST** fail with `ConfirmedBugf` (documents issue). Do not skip “to go green”. |
| Bug fixed | Test **MUST** go green and remain as regression guard. Keep issue id in name/comment. |
| Bug invalid / cannot reproduce / wrong issue | Fix or delete test; do not leave lying `ConfirmedBugf`. |
| Environment cannot run scenario | `Preconditionf` or inventory `blocked-*`; not `ConfirmedBugf`. |

**NEVER** convert a real core bug failure into `t.Skip` to clean CI.  
**NEVER** delete a green regression test because the issue is closed — closed issues are why the test stays.

### 9.3 Ownership & churn

- Prefer updating tests in the same PR as the behaviour change.  
- API renames in harness: update consumer tests in the same landing window.  
- Examples under AzerothGhost `e2e/examples/` are **patterns**; AC regressions live in the consumer suite (or agreed AC-side e2e module).  
- Periodic prune: merge redundant tests; refresh inventory (§5.3).

### 9.4 Local debug vs committed suite

- **Scratch / agent exploratory tests** MUST go under **`e2e/local/`** (gitignored except `local/README.md`). NEVER commit throwaways.  
- When a scratch scenario becomes a real regression, **move** it into `e2e/suites/` (or `suites/issues/`) in the same PR as the fix.  
- Day-to-day debugging SHOULD prefer live e2e over ad-hoc GM spam when the stack is up (`e2e/README.md`).  
- CI is opt-in (`-tags=e2e` + workflow); see `.github/workflows/e2e-live.yml` only when changing CI — not required reading for authoring tests.

---

## 10. Suggested long-term placement (AGENTS.md / `.agents/docs`)

This file is a **phase-0 plan artifact**. When e2e-army graduates from plan to standing practice, split as follows (per `.agents/docs/README.md` taxonomy):

| Content | Promote to | Routing |
|---------|------------|---------|
| Decision tree, mandatory triggers, when-not, coverage growth, MVT, priorities, maintenance | **`.agents/docs/e2e-policy.md`** (new root task doc) | Add bullet under AGENTS.md **Mandatory reading per task**: “Writing or modifying live-stack e2e → `.agents/docs/e2e-policy.md`” |
| LLM authoring checklist + harness MUST/NEVER (thin pointer) | **`.agents/docs/e2e-policy.md`** § checklist; deep API stays in harness `LLM_GUIDE.md` | Link out; do not fork API reference into AC |
| Review expectations (“PR missing e2e for M1–M7”) | **`.agents/docs/code-review.md`** + **`self-review-rules.md`** | Short bullets + link to e2e-policy |
| Subsystem-specific oracles (e.g. battlegrounds later) | **`.agents/docs/systems/<name>.md`** | Only when subsystem doc exists/needed |
| Category inventory / backlog | Consumer suite `README` or `.agents/docs/e2e-coverage.md` (optional living data) | Not AGENTS.md body |
| Build/run how-to for stack | **`.agents/docs/build.md`** (short pointer) or suite README | Avoid bloating policy |

**AGENTS.md** should only gain:

1. One mandatory-reading bullet for e2e-policy.  
2. Optional one-liner under layout if an `e2e/` consumer tree is added in-repo.

**Do not** paste harness API tables into AGENTS.md.  
**Do not** leave this plan file as the only copy after promotion — replace with a pointer: “Superseded by `.agents/docs/e2e-policy.md`”.

---

## 11. Quick reference card (LLM)

```
MUST e2e:  player-visible bugfix | protocol change | multi-system | crash path |
           critical system touch without oracle | tracked AC issue fix

NEVER e2e: pure math | SQL-only static | duplicate oracle | invent harness APIs

MVT:       one oracle + real client path + severity helpers + no GM mid-fight +
           waiters not sleeps + runnable -tags=e2e

On change of aura|quest|death|relog|boss AI|spell-summon|guild|crash:
           add/update matching e2e OR record gap

Fail:      Preconditionf | ConfirmedBugf(issue) | HarnessFailf
Docs:      this policy (when) + harness LLM_GUIDE/EXAMPLES (how)
```

---

## 12. Document control

| Field | Value |
|-------|-------|
| ID | A2_E2E_POLICY |
| Phase | e2e-army / phase0 |
| Depends on | Harness `LLM_GUIDE.md`, `EXAMPLES.md`, `README.md` |
| Supersedes | — |
| Next | Promote §10 into `.agents/docs/e2e-policy.md` + AGENTS.md routing when suite lands |
