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

The Plan 1 execution baseline at `6906fe6d` was zero commits behind upstream `5fa7cb00f` and eleven
ahead. Its pre-audit delta was 24 files, 181 changed blocks, 1,434 insertions, and 317 deletions. It is
a partial authentication and character-list experiment plus fork-specific planning context.

What fits the goal:

- It retains AzerothCore's database, session, security, hook, and player-loading flows.
- The initializer, part of world authentication, character enumeration, and packed player-login GUID
  behavior contain useful Cata work.
- The branch stays small enough to audit against upstream.

What does not yet fit the goal:

- One shared opcode table cannot represent Cata's client/server numeric collisions.
- Most opcode values, packet payloads, update fields, DBC layouts, build identity, and expansion
  settings remain WotLK.
- GUID and bit-buffer foundations are incomplete, auth serializers disagree, and compression owns a
  leaking raw zlib stream.
- Character packet serialization bypasses AzerothCore's packet layer.
- Temporary hot-path logging, dead code, empty handlers, and commented implementations increase the
  upstream merge cost without adding Cata behavior.

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
Open a numbered GitHub issue only when its predecessor is green and its inputs are known.

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
- [Plan 16: build 15595 movement acknowledgement and speed contract](https://github.com/trolloks/azerothcore-cata/issues/34)

Plans 8-10 deliberately stop at three separate boundaries: typed empty enumeration, one populated
enumeration, and real-client selection through the session legitimacy gate to the database-load callback.
They do not prove character creation, successful player loading, initial packet correctness, map entry, or
world control. Plan 10 proved `Player::LoadFromDB` returned true as a diagnostic; Plan 11 proved the
pre-map packet contract; Plan 12 proved map insertion and object bootstrap, moving `SMSG_LOGIN_VERIFY_WORLD`
to fire after map insertion per the pinned Cataclysm reference. On 2026-09-08, the real client entered
Northshire and completed 10 matched time-sync exchanges after correcting aura flags and two guild
requests in a diagnostic relay. Plans 14 and 21 reached their world-entry stopping point.
[Earlier evidence and limits](client-automation.md#resolved-loading-screen-hang-aura-flags-2026-09-08).
Plan 13 subsequently passed with rebuilt binaries in fresh generations 80 and 81, each with four matched
time-sync exchanges, one first-response marker, a 30-second stable hold, and a clean owned reset.
The comparison checks the required response and acceptance evidence while retaining variable background
packet sequences for diagnosis. [Completion evidence](https://github.com/trolloks/azerothcore-cata/issues/27).
Plans 15-16 cover movement and remain separate from this passive world-entry proof.
