# Cataclysm conversion roadmap

Status: working roadmap. Revise it as each numbered plan produces better evidence.

## Goal

Convert current AzerothCore from World of Warcraft 3.3.5a to Cataclysm 4.3.4 build 15595 without
replacing AzerothCore's design with TrinityCore or a separate compatibility framework.

The rule for every change is simple:

1. Keep current AzerothCore ownership, interfaces, hooks, security checks, and file placement.
2. Take required 4.3.4 behavior from the pinned Cataclysm TrinityCore source.
3. Use `cata-js` as corroborating protocol notes and runtime evidence, never as an architecture to
   transplant.
4. Let the real build 15595 client decide whether a completed slice works.

## Reference order

| Priority | Source | Role |
| --- | --- | --- |
| 1 | Current `upstream/master` | Structure, framework, maintainability, and merge compatibility |
| 2 | TrinityCore commit `c699217775d90794158422387b07a917e161b582` | Canonical 4.3.4 behavior and wire format |
| 3 | `cata-js` commit `ab964a0e8dfe50a44fa92716ed05438f4a14dfd3` | Prior discoveries and client-visible failure notes |
| 4 | Full `Wow-64.exe` build 15595 | Runtime acceptance judge |

The TrinityCore working tree is dirty. Read the pinned commit, not uncommitted files. The `cata-js`
runtime log proves a useful vertical slice only through commit `3a697ce`; later aura work is
unverified and the log must not be committed because it contains account and packet data.

## Current state

Reviewed on 2026-09-09 against merged `master` at `22f8540e1`, after PR #51. Numbered
plans 1-21 are closed; Plans 22-26 are now queued below. Completion applies to the bounded contracts
in each issue, not to whole gameplay systems.

Proven so far:

- Authentication, character enumeration, selection of a database-seeded character, and stable
  Northshire world entry through the existing AzerothCore session and player-loading flows.
- Direction-safe opcode dispatch and the shared build-15595 opcode values. Payload conversion
  remains a separate check for each request and response.
- Object, Unit, Player, Item, Container, GameObject, DynamicObject, and Corpse field contracts and
  the object-create movement block.
- Idle movement heartbeat processing and one server-initiated run-speed change with its matching
  client acknowledgement. These do not establish keyboard movement or the other speed types.
- Representative rendered objects in Plan 18: an equipped bag containing a sword and jerky,
  a chest, a player corpse, and ground flames. The inventory API reported six slots, jerky x2,
  and sword durability 13/20; the user manually confirmed the bag contents. The second fixture
  attempt logged 97 ordinary periodic ground-spell triggers during a stable 30-second session.
  Its generic verifier had already recorded INCONCLUSIVE without screen confirmation; the later
  human confirmation is supplemental evidence, not a rewritten automated verdict. See #37.

Known gaps that determine the next work:

- Every accepted world-entry fixture so far used a database-seeded character. Normal character
  creation, deletion, and starting-state persistence have not been accepted. The creation request
  header already matches the pinned reference, so begin with verification rather than rewriting it.
- `Player::Create` still derives starting inventory from `CharStartOutfit` plus `playercreateinfo_item`,
  and skills, spells, actions, and spawn data from the existing creation stores. The sword and jerky
  in Plan 18 were synthetic fixture contents, not proof of the correct Cata starting inventory.
- The login `PhaseShiftChange` serializer writes empty phase/map lists and the Unphased flag.
  Server visibility still uses the existing phase-mask model. This proves only the default phase,
  not Cata phase IDs, quest-driven visibility, terrain swaps, or phased starting zones.
- `WorldSession::ReadMovementInfo` selects the Cata decoder only for `MSG_MOVE_HEARTBEAT`.
  Directional movement and jump/land requests still enter the WotLK reader and broadcast path.
- `HandleCastSpellOpcode` omits the reference request's `Misc` word. `SendSpellStart` and
  `SendSpellGo` omit `CastFlagsEx` before the time field. Server-triggered flames do not prove
  that pressing a spell button works.
- Seeing bag contents does not establish moving, equipping, splitting, or using items. Several
  basic inventory request layouts already match the reference; verify them before changing code.
- `LootView` writes gold and an item count without the Cata currency-count byte. Single-player
  looting and inventory delivery have not been accepted with the real client.
- The current server still reads the flattened 234-field `Spell.dbc`, and distributed defaults
  remain expansion 2 and level 80. Cata client-data stores, reproducible extraction, database
  conversion, level-85 progression, and retail combat rules remain unfinished. Current fixtures
  deliberately use verified records from the existing server data.
- Character creation/deletion, new races, teleports, swimming/flying, transport movement, combat,
  quests, social systems, and content remain unproven beyond the specific earlier issue contracts.

The original Plan 1 baseline and audit measurements remain historical evidence in
[#11](https://github.com/trolloks/azerothcore-cata/issues/11); they no longer describe current master.

## Next five plans

The five canonical issues are open in delivery order. Creating the queue does not authorize builds
or mean every prerequisite is already satisfied. Start each implementation from merged master after
its predecessor is complete. Split missing data or gameplay prerequisites into explicit blocking work.
GitHub holds each full contract; the functionality/data trackers retain the broader parity scope.

| Order | Proposed plan | Completion boundary |
| --- | --- | --- |
| [22][plan-22] | Character creation and starting state | Create through UI; verify items, spells, spawn, and saves |
| [23][plan-23] | On-foot movement | Walk, turn, strafe, jump, land, and stop at the accepted position |
| [24][plan-24] | Initial phasing and visibility | Enter/leave a phase and restore correct visibility on login |
| [25][plan-25] | Basic spell casting | Cast from the action bar and handle success, failure, and cancellation |
| [26][plan-26] | First complete quest loop | Accept, progress, turn in, and save correct rewards and phase effects |

[plan-22]: https://github.com/trolloks/azerothcore-cata/issues/52
[plan-23]: https://github.com/trolloks/azerothcore-cata/issues/53
[plan-24]: https://github.com/trolloks/azerothcore-cata/issues/54
[plan-25]: https://github.com/trolloks/azerothcore-cata/issues/55
[plan-26]: https://github.com/trolloks/azerothcore-cata/issues/56

Plan 22's starter-data prerequisite is [#57](https://github.com/trolloks/azerothcore-cata/issues/57),
a native sub-issue blocking #52. Its audit found the older Human Warrior outfit and missing Cata
action spells in the current server inputs. Coordinate data and protocol work before final acceptance.

### Follow-on work and dependency gates

The next-five list does not replace the full plan-family table below. Keep these dependencies
visible when choosing the following tranche:

- Inventory movement, splitting, equipping, item use, persistence, and failure cases. Reuse the
  field proof from Plan 18 and the shared casting work; verify existing readers before changing them.
- Single-player loot: correct the currency-count field, open/take/release behavior, item/money
  delivery, full bags, ownership, and duplicate-award prevention. Use a controlled loot source
  before claiming that combat, death, and loot all work together.
- Combat, death, resurrection, and corpse recovery; then a repeatable kill/loot/quest-reward loop.
- Cata extraction, client-data stores, and database migrations beyond the initial character data.
  These gate broader progression, creature/item definitions, spells, and terrain-dependent behavior.
- Remaining race/class combinations, Goblin/Worgen support, phased starting campaigns, quest
  conditions/rewards, terrain swaps, and later-zone content. Track each as explicit unproven scope.
- Teleports, swimming/flying, transports, instances, and the social/economy/PvP systems in the
  family table. None is implied complete by a successful on-foot starting-zone session.

### Validation budget

Run focused deterministic checks before real-client acceptance. When a build is authorized, use
the existing ccache/PCH build tree and build the required targets once. Reuse those binaries and
cached prepare inputs. Default to one isolated client acceptance session per plan, combining that
plan's scenarios. A repeat needs a concrete failure or relevant change and a stated purpose;
there is no blanket two-build or two-run requirement. Keep protected inputs immutable and use
only the owned disposable database and cleanup procedure.

A data-dependent plan must define its source/provenance, tables, output formats, out-of-repository
artifacts, and disposable migration checks before extraction or broad imports. Pull that prerequisite
forward when needed; do not invent retail values or add a second compatibility framework to bypass
an unavailable store.

## Functional and data parity tracking

Use these records together; none replaces the others:

- [Canonical plan issues](github-issues.tsv): implementation ownership, dependencies, decisions,
  and completion evidence for each bounded issue.
- [Functionality matrix](parity-functionality.tsv): capability scope, pinned TC reference, status,
  issue links, acceptance predicate, evidence, and remaining gaps. The initial 80 rows are coverage
  categories; inventory their individual handlers, variants, and scenarios before marking them done.
- [Data inventory](parity-data.tsv): one row per SQL table and named client store referenced by the
  pinned TC sources, plus explicit content-source, record-coverage, and map-artifact gates.
- [Existing conversion ledger](conversion-status.tsv): packet/file/block contracts and upstream
  delta auditing. A mapped opcode is not a verified payload or a completed capability.

The initial reference inventory contains 330 SQL tables and 171 named DBC/DB2 inputs from the active
store source. It also tracks six content/artifact gates. This accounts for reference table/store
names, not actual record parity. Maps, locales, script registrations, per-quest chains, spawns, and
encounters need their own expanded inventories. Uninventoried work remains unassessed, never complete.

### Source and comparison contract

Keep AC's ownership, security checks, hooks, and architecture. The pinned TC commit defines the
functional/data comparison target; cata-js corroborates protocol findings. A difference in code
structure is acceptable when behavior is equivalent and the proof is recorded. Any intended
behavioral deviation needs a named issue, rationale, and explicit approval; it remains visible and
must not be silently counted as parity. TC parity is not a guarantee of bug-free retail behavior.

The TC code pin is not a complete content snapshot. Its world and hotfix base SQL contain schemas
but no content rows. Before data parity can pass, pin the compatible world/hotfix release, applied
update sequence, locale coverage, source hashes, and required build-15595 client data. Store assets,
dumps, credentials, and raw captures outside Git. Track their sanitized manifests and reproducible
comparison commands. A populated local database or an unchanged row count is not source verification.

Every data row needs proof of:

1. Source identity: build/version, release and updates, locale, hashes, and documented provenance.
2. Schema/layout: types, signedness, widths, keys, defaults, indexes, DBC/DB2 columns, and loader joins.
3. Values: compare required records and fields by stable domain keys, including missing/extra IDs,
   defaults, enum/bit meanings, strings/locales, and any explicit AC-to-TC representation mapping.
4. Relations: detect dangling IDs and invalid cross-table references, including quest chains,
   conditions, phase membership, spawns, scripts, loot, spells/effects, outfits, and item templates.
5. Runtime use: the actual AC loader and consumer use the converted values correctly; fresh install,
   supported upgrade, restart, and relevant player-visible behavior agree.

Runtime-owned character/account tables need schema and behavior comparisons, not copied TC player
records. Use synthetic records to prove migration, ownership, constraints, round trips, and recovery.
Never require rewriting AC tables to match TC naming when an explicit semantic mapping suffices.

### Functionality proof and coverage

Before starting an issue, expand the relevant capability into a concrete inventory: opcode/callers,
state transitions, data dependencies, supported variants, and negative cases. For content, generate
per-zone, per-quest/chain, per-spawn/template, and per-map/encounter entries from the pinned data and
script registrations. Every discovered entry must be mapped, intentionally deferred, or blocked
with a reason. Parent categories cannot be verified while required children remain unproven.

For each scoped behavior, record independently derived TC expectations and prove them through the
normal AC path. Compare meaningful results: state, packet fields, eligibility, resource/item deltas,
visibility, and persistence. Include invalid/unauthorized requests and the failure paths that could
lose or duplicate data. Do not weaken security, invent retail values, or force database state to
make an acceptance scenario pass.

Use codec/unit/data comparisons for deterministic coverage, an owned live stack for integration,
and the real build-15595 client for visible behavior. Multiple-account scenarios are required where
ownership, recipient routing, grouping, trade, or visibility is part of the contract. A single login,
a screenshot, or one successful spell is evidence for that scenario only. An automated INCONCLUSIVE
record stays inconclusive; later human evidence is recorded separately with its exact scope.

### Status and evidence rules

- `unassessed`: scope is listed but comparison and proof are missing.
- `partial`: some bounded cases pass; list the remaining variants and dependencies.
- `blocked`: name the unavailable source or prerequisite and the issue needed to resolve it.
- `deferred`: deliberately unscheduled scope, still required for full conversion unless explicitly excluded.
- `verified`: every declared case and required child/data dependency has current, reviewable proof.

No empty evidence field is allowed on a verified row. Evidence records must identify the AC commit,
TC pin, input manifests/hashes, exact command/scenario, expected/actual result, and artifact location.
Client evidence also identifies the run, visual observation, ownership/isolation checks, and cleanup.
When a layer is inapplicable, use a reasoned `n/a: ...` entry instead of an empty cell or a claimed pass.
The checker enforces structure and required fields; a reviewer must assess the evidence itself.

Update the relevant rows in the same PR as the implementation, linking its canonical issue. Keep
prior failures and limitations. A later code/data change that invalidates an expectation makes the
related row partial again until reverified. On upstream/reference updates, compare inventories,
identify affected capability/data consumers, and rerun their checks. Do not carry green status across
changed inputs without review.

Report functional and data status separately, with blocked/unassessed counts and missing inventory
denominators. Do not publish one completion percentage by averaging unrelated packets, tables,
quests, and encounters. A closed plan issue is a completed slice, not a blanket subsystem verdict.

### Runnable tracking check

`python3 apps/cata/check_parity.py` checks columns, identities, statuses, pinned references, and
required evidence fields. Add `--reference-tree /path/to/TrinityCore` to check that every named SQL
base table and active-store DBC/DB2 input at the pinned commit has a data row. The command reads the
commit, so a dirty TC checkout does not affect the comparison.

Use `--add-missing-data` with the reference tree to add newly missing rows as unassessed while keeping
existing evidence. This updates only the tracker. It does not import game data or verify parity.
`--self-test` exercises the tracker's rejection cases. Keep the existing conversion checker for its
separate packet and upstream-delta audit; do not replace it with this inventory check.

The final release gate requires complete scope inventories, verified functionality and data rows,
reviewed exceptions, no required blocked/deferred work, reproducible installation/upgrades, supported
builds, representative full client journeys, and recovery/security checks. Until those conditions
hold, describe this fork as a partial conversion, even if all currently opened issues are closed.

## Completion predicate

The conversion is complete only when all of these statements are true:

- The fork is based on a current upstream commit and every fork-only path is classified and checked
  after each upstream update.
- Supported authserver, worldserver, tools, and tests configure and build using the repository's
  supported toolchains.
- No active build, expansion, opcode, packet, update-field, client-data, or level-cap contract still
  targets 3.3.5a unless it is documented historical data.
- Fresh Cataclysm databases can be created and upgraded through a documented, repeatable process.
- The build 15595 client can complete automated smoke paths for authentication, character lifecycle,
  world entry, movement, combat, persistence, grouping, instances, and representative content.
- Each converted subsystem has deterministic local checks and a real-client acceptance trace.
- Upstream updates can be merged without replacing whole subsystems or reapplying hand-maintained
  patches.

## Plan families

These are areas, not promised plan numbers. Each area will split into as many small plans as needed.
Issues may be queued in advance at the user's request. Start implementation only when the
predecessor is green and the required inputs are known.

| Area | Exit condition before moving on |
| --- | --- |
| Protocol foundation | Direction-safe opcodes, wire primitives, auth, enumeration, and selection admission are proven |
| Client data extraction | Build 15595 DBC, DB2, map, VMAP, and MMAP inputs are reproducible |
| Client data stores | Cata layouts and loaders replace active WotLK contracts |
| Database strategy | Auth, character, and world schemas have a legal, repeatable Cata migration path |
| Object model | GUIDs, type IDs, update fields, visibility masks, and object updates agree |
| World entry | Phasing and the complete loading sequence reach the world reliably |
| Movement | Movement packets, acknowledgements, speed, spline, and teleport behavior agree |
| Maps and visibility | Grids, transports, maps, collision, phasing, and nearby-object updates agree |
| Character lifecycle | Creation, deletion, customization, races, classes, login, logout, and saves agree |
| Player progression | Level 85 stats, resources, regeneration, experience, and skills agree |
| Items and currencies | Equipment, inventory, bags, bank, currencies, and item persistence agree |
| Talents and customization | Specs, talents, glyphs, reforging, transmog, and professions agree |
| Spells and auras | Casting, auras, procs, cooldowns, dispels, and power costs agree |
| Combat | Damage, healing, threat, death, resurrection, and combat state agree |
| Creatures and AI | Spawning, respawn, AI, evade, pathfinding, and difficulty behavior agree |
| Pets and vehicles | Pets, guardians, summons, possession, and vehicles agree |
| Quests and phasing | Objectives, conditions, quest phases, rewards, and persistence agree |
| World interaction | Loot, vendors, trainers, gossip, reputation, factions, and events agree |
| Social | Chat, friends, ignores, groups, guilds, and calendar agree |
| Economy | Trade, mail, auction house, and economy rules agree |
| Instances and matching | LFG, instances, lockouts, and raid-finder behavior where applicable agree |
| PvP | Battlegrounds, arenas, honor, rated PvP, and rewards agree |
| Secondary systems | Achievements, archaeology, collections, and Cata-specific systems agree |
| World content | Eastern Kingdoms, Kalimdor, expansion zones, and outdoor content agree |
| Instance content | Dungeon and raid scripts, encounters, conditions, and rewards agree |
| Operations | Config, migrations, observability, deployment, and admin commands agree |
| Hardening | Long sessions, restart recovery, performance, security, and upstream rebase checks pass |

## Real-client integration strategy

Later vertical plans use the full build 15595 client as an acceptance judge. Client launch is allowed
only after the relevant plan has explicit build/test authorization and all of these isolation gates
are met:

- Create a fully run-owned Bottles prefix. Never launch through the personal `Battle.NET` Bottle.
- Use a fully run-owned client copy or a run-owned symlink/copy-on-write overlay whose isolation has
  been proven first. An overlay may link only read-only source files; its writable directories and
  locale `realmlist.wtf` must be local. Never launch the source client tree directly.
- Capture pre-run and post-run manifests for the source client and personal Bottle, and require no
  changes.
- Store logs, screenshots, manifests, and packet evidence outside the Git worktree. Sanitize them
  before deliberately copying any summary into the repository.
- Seed disposable server, database, account, and character state. Record exact owned resources and
  process IDs so reset can touch only those resources.
- Run databases in run-owned Docker containers and volumes bound to `127.0.0.1` on confirmed unused
  host ports. Never reuse or modify an existing database, container, or volume.

The eventual harness should expose five idempotent operations: `prepare`, `start`, `observe`,
`collect`, and `reset`. Automate hashes, server readiness, ports, protocol milestones, disconnects,
sanitization, and cleanup. Keep credential entry and visual confirmation manual until the isolated
flow is stable; an addon cannot observe authentication or character selection.

### Packet capture and replay

Use real-client sessions to create deterministic fixtures, then run most protocol checks without the
client. Capture logical `WorldPacket` data at the server boundary:

- Incoming: after TCP framing and header decryption, before opcode dispatch.
- Outgoing: after packet serialization, before compression, header creation, and encryption.
- Record only build, sequence, direction, connection type, opcode, and payload.
- Exclude wall-clock time, addresses, ports, credentials, session keys, and personal identifiers.

Raw PCAP remains optional forensic evidence. It is a poor primary fixture because authenticated
world headers use session-specific crypto, TCP segmentation varies, and outbound compression keeps
stream state across packets.

Never redact sensitive bytes in place. Synthesize a new transcript using dummy accounts, fixed test
keys and challenges, remapped GUIDs, fixed clocks and counters, and recomputed proofs. Keep three
small test layers:

1. Typed codec fixtures compare parsed fields or serialized opcode and payload.
2. Session-flow replay feeds logical client packets through dispatch against fixed server state and
   captures logical responses.
3. Wire vectors test initializer framing, normal and large headers, crypto, and full ordered zlib
   streams separately.

This replaces repeated client runs for parser, serializer, dispatch, and login-sequence regressions.
It does not replace real-client acceptance checks for crypto activation, connection redirects,
packet ordering, streaming compression, world loading, movement, UI behavior, crashes, or silent
disconnects.

## Planning rules

- One numbered GitHub issue owns one verifiable slice. Split it again when the real dependency graph
  is wider than expected.
- Give each numbered issue its own `plan/NN-short-name` branch. Create it from the latest `master`
  after the previous plan is merged; never stack plan branches.
- Start each plan from updated upstream and end it with a repeatable check.
- Port semantic differences into existing AzerothCore layers. Do not bulk-copy TrinityCore files.
- An opcode number is not implemented until its parser or serializer and client behavior are proven.
- Add SQL only under the permitted pending-update directories unless the user explicitly authorizes a
  broader database migration.
- Do not start client-data extraction until the user confirms the source data's provenance and
  intended use, and the plan defines an out-of-repository storage and ignore boundary.
- Keep experimental tracing behind existing logging facilities and remove it before a plan closes.
- Record negative results. `INCONCLUSIVE` is not a pass.
- Do not commit raw packet captures. Commit only reviewed synthetic fixtures with dummy identities
  and reproducible generation inputs.
- Treat existing database data as immutable. A plan that needs a database must define its disposable
  Docker container, volume, unused-port check, ownership manifest, and bounded cleanup first.

## Plan issues

GitHub issues hold the complete plans and progress. `github-issues.tsv` is the repository index; the
numbered Markdown files are stable-path stubs for historical ledger references.

- [Plan 1: conversion baseline and protocol contracts](https://github.com/trolloks/azerothcore-cata/issues/11)
- [Plan 2: deterministic bit-buffer contract](https://github.com/trolloks/azerothcore-cata/issues/12)
- [Plan 3: world compression stream lifetime](https://github.com/trolloks/azerothcore-cata/issues/13)
- [Plan 4: direction-safe opcode model](https://github.com/trolloks/azerothcore-cata/issues/14)
- [Plan 5: world authentication packet contract](https://github.com/trolloks/azerothcore-cata/issues/15)
- [Plan 6: build 15595 authentication handoff](https://github.com/trolloks/azerothcore-cata/issues/16)
- [Plan 7: isolated build 15595 client authentication](https://github.com/trolloks/azerothcore-cata/issues/17)
- [Plan 8: typed empty character enumeration](https://github.com/trolloks/azerothcore-cata/issues/18)
- [Plan 9: one database-backed character](https://github.com/trolloks/azerothcore-cata/issues/19)
- [Plan 10: select the enumerated character](https://github.com/trolloks/azerothcore-cata/issues/20)
- [Plan 11: build 15595 pre-map initial-packet contract](https://github.com/trolloks/azerothcore-cata/issues/25)
- [Plan 12: build 15595 map insertion and object bootstrap](https://github.com/trolloks/azerothcore-cata/issues/26)
- [Plan 13: build 15595 in-world control bootstrap](https://github.com/trolloks/azerothcore-cata/issues/27)
- [Plan 14: build 15595 post-map-insertion client survival](https://github.com/trolloks/azerothcore-cata/issues/32)
- [Plan 15: build 15595 basic movement packet contract](https://github.com/trolloks/azerothcore-cata/issues/33)
- [Plan 16: run-speed acknowledgement contract](https://github.com/trolloks/azerothcore-cata/issues/34)
- [Plan 17: Object/Unit/Player update fields](https://github.com/trolloks/azerothcore-cata/issues/36)
- [Plan 18: remaining object update fields](https://github.com/trolloks/azerothcore-cata/issues/37)
- [Plan 19: bit-packed movement/create block](https://github.com/trolloks/azerothcore-cata/issues/40)
- [Plan 20: opcode-table realignment](https://github.com/trolloks/azerothcore-cata/issues/41)
- [Plan 21: login packet sequence parity](https://github.com/trolloks/azerothcore-cata/issues/43)
- [Plan 22: character creation and starting state](https://github.com/trolloks/azerothcore-cata/issues/52)
- [Plan 23: on-foot movement](https://github.com/trolloks/azerothcore-cata/issues/53)
- [Plan 24: initial phasing and visibility](https://github.com/trolloks/azerothcore-cata/issues/54)
- [Plan 25: basic spell casting](https://github.com/trolloks/azerothcore-cata/issues/55)
- [Plan 26: first complete quest loop](https://github.com/trolloks/azerothcore-cata/issues/56)

Plans 8-10 established enumeration and selection admission. Plans 11-14 and 21 completed the
bounded world-entry sequence; Plans 17-20 supplied the field, create-block, and opcode contracts.
Plans 15-16 established idle heartbeat and run-speed acknowledgement acceptance. See each canonical
issue for its exact proof and exclusions. The next five plans above begin where those proofs stop.
