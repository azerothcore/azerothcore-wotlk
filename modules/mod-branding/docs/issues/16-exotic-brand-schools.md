# #16 — Exotic brand schools (§7.1, §7.9, §7.10)

**Status:** groundwork done · full expression open (needs #03) · **Deps:** #02 (loadout), #03 (effect-application) for full expression · **Parallel-safe:** the enum/config groundwork is independent · **Size:** M (groundwork) → L (full per-school expression)

## Progress

**Groundwork shipped** (pure + spec; independent of #03):
- v1 schools **Wind, Lightning, Blood, Void** added to `BrandId` (before `COUNT`); spec §7.10 added
  with the per-role expression table; §7.1 `BrandId` list updated.
- `BrandName` (`.branding`) returns/parses the new names; `ParseBrand` already accepted them by id.
- Audited every `BrandId`/`COUNT` coupling: all `switch`es have `default:` (compile-safe), all
  `COUNT`-sized arrays auto-grow, mask is `uint32_t` (11/32 used). Repaired the one `COUNT`-coupled
  test (`MasteryActive.SetAddRejectsDuplicateCellAndFullCapacity`) to fill capacity programmatically
  so it tracks `BrandId::COUNT` instead of hardcoding the classic seven.
- TDD: `tests/effects/ExoticSchoolTest.cpp` (6 tests) sweeps **all** `BrandId` in `[0, COUNT)` to pin
  the §7.9 effect-model + §7 knowledge/loadout invariants uniformly. **224/224 standalone tests green.**

**Remaining (needs #03 effect-application):** brand-specific flavour from the §7.10 table (Windfury
proc cadence, chain-arc, leech/execute, phase/gravity) realised as auras/proc-freq mods/heal-hook
transforms; §14.4 mastery-lattice + addon-UI authoring for the exotic schools; the next batch (Stone,
Venom, Chrono, Spirit). Open design qs (own-id vs hybrid; unlock-cost gating) still apply to that work.

## Context
`BrandId` was the seven classic schools — `Fire, Frost, Nature, Shadow, Arcane, Holy, Physical`
([Brand.h](../../src/core/branding/common/Brand.h)). The effect model (§7.9, `core/effects/`) already
supports everything an *exotic* school needs: the three `EffectKind`s (`PersonalSpike` /
`RaidWindow` / `MechanicTransform`) and per-`(brand, role)` `EffectProfile`s. So a new school is
**not** new core machinery — it is a new enum value plus a set of role-asymmetric effect profiles and
the adapter behaviours that realise them (#03).

The seed example: **Wind** — Windfury-style extra-attack procs (offensive), a group haste window
(support), and a dodge/evasion spike (defensive). The schools below extend that pattern. Each obeys
the non-negotiable rules (§1, §7.9): **behaviour/proc transforms, never flat ±% damage**;
**role-asymmetric** (Tank = dramatic visible spike, DPS = restrained proc synergy, Healer = mechanic
transform, Support/Control = bounded group window); raid effects **bounded + catalyst-DR'd**.

## Proposed schools

Each row maps the school onto the existing `EffectKind` triad. "Offensive/DPS" and "Support/Control"
are `RaidWindow` (bounded, DR'd); "Defensive/Tank" is `PersonalSpike`; "Healer" is `MechanicTransform`.

| School | Theme | Tank — PersonalSpike (dramatic) | DPS — RaidWindow (restrained proc) | Support/Control — RaidWindow (bounded) | Healer — MechanicTransform |
|---|---|---|---|---|---|
| **Wind** *(seed, v1)* | tempest / motion | evasion/dodge spike window | Windfury — extra-attack proc cadence | group haste window | gusts push HoTs to spread to a 2nd ally |
| **Lightning / Spark** *(v1)* | chain arc | static shield: brief reflect/absorb | procs arc to a nearby enemy (single-target → cleave during window) | "overload": group's next casts gain a bonus chain target | overheal jumps as a small heal to the lowest nearby ally |
| **Blood / Sanguine** *(v1)* | lifedrain, execute | leech window: % of damage dealt returns as HP | execute cadence — proc rate ramps as target HP drops (conditional, not flat) | blood pact: bounded group leech window | converts a fraction of allied overkill into raid healing (damage → heal) |
| **Void / Astral** *(v1)* | phase, gravity | blink/displacement: brief damage-avoidance phase | phase procs: periodic armor-ignore burst window | gravity well: pull/cluster adds (control) or short CDR window | dispel-on-heal: heals also remove a magic effect |
| **Stone / Geomancy** | earth, immovability | stoneform: large armor/HP spike, knock-immune | tremor procs (brief target slow / interrupt cadence) | earthen totem: group damage-taken reduction window | overheal → earthen barrier (absorb shield) |
| **Venom / Plague** | contagion, DoT | contagion aura: attackers gain stacking weaken | DoT-spread proc: periodic damage jumps to nearby (single DoT → cleave) | brittle: group's periodic effects tick faster window | cleanse-on-heal: heals also purge a poison/disease |
| **Chrono / Temporal** | time, rewind | anachronism: periodically rewind own HP to a recent snapshot | echo procs: a fraction of a hit repeats a short beat later | bounded time-warp: group haste + minor CDR window (heavy DR) | heals leave a short "rewind" HoT echo |
| **Spirit / Spectral** | soul, ghostform | ghost-walk: brief damage-immunity blink | soul-harvest cadence: procs build on kills/low-HP enemies | spectral veil: group threat-drop / stealth-assist window | overheal spawns a roaming wisp that heals the lowest ally |

These are deliberately hybrid/conceptual (cross the classic schools) so they feel *exotic*. **v1 ships
Wind / Lightning / Blood / Void** (one clear identity per role archetype). The rest land incrementally;
nothing here changes core machinery.

## Scope

**Groundwork (done — see Progress):**
- Add the chosen schools to `BrandId` **before `COUNT`**, preserving order (the enum is a bitmask
  index into `KnowledgeState::unlockedMask`, `uint32_t` → up to 32 brands). Audit `BrandId::` switches
  and `COUNT`-sized arrays.
- `ProfileFor`/`IEffectConfig` already resolve a sensible default `EffectProfile` per role for any
  brand (role-driven), so the new schools work uniformly out of the box; brand-specific flavour is
  full-expression work.
- Knowledge/loadout treat the new ids uniformly (they key off the mask) — pinned by tests.

**Full expression (depends on #03 effect-application):**
- Realise each role behaviour in the adapter — most are existing `EffectKind`s with new flavour
  (auras/proc-frequency mods/heal-hook transforms). A few want genuinely new transform hooks (DoT
  spread, heal-jump, damage→heal, HP-rewind snapshot); implement one transform first, then fan out.
- Spell-school flavour mapping: reuse existing 3.3.5a spell visuals where possible (Windfury, Chain
  Lightning, Earthbind, Death Coil) rather than authoring new ones.

## Open questions (decide before full expression)
- **Dual-school / hybrid brands?** WotLK has combined spell schools (Frostfire, Spellstorm…). Own-ids
  (this issue's v1 assumption) is simpler and mask-cheap; composition is more systemic but needs new
  resolution logic. Recommend **own ids** for v1.
- **Knowledge-unlock cost / gating (#01):** are exotic schools harder to unlock than the classic
  seven? Encode in the unlock cost table, not in effect strength (anti-P2W §1).
- **Which subset ships next** (Stone/Venom/Chrono/Spirit batch order).

## Acceptance
- Standard DoD (INDEX.md). Spec first: §7.10 lists the shipped exotic schools + per-role profiles.
- New/extended behaviour covered by `tests/` — `ExoticSchoolTest` parametrises over all `BrandId`
  values up to `COUNT` (kind per role, §7.9 magnitude bounds, knowledge/loadout uniformity).
- Manual verify (after #03): a Wind-branded player shows Windfury-style extra-attack procs (DPS), a
  bounded group haste window (support), and a windowed dodge spike (tank) — each bounded and *not*
  always-on, inspectable via `.branding info`.

## Touch points
[Brand.h](../../src/core/branding/common/Brand.h) (enum), `BrandingCommandScript.cpp` (`BrandName`),
`core/effects/EffectModel.cpp` (`ProfileFor`), `core/effects/EffectConfig.h` +
`conf/mod_branding.conf.dist` (profile tables), `tests/` (`ExoticSchoolTest`), and — for full
expression — the #03 `Effect*` adapter (new transform hooks). No DB schema change (mask-keyed;
`unlockedMask` already `uint32_t`).
