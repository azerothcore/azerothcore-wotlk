# mod-branding — Architecture & Specification

Status: **DRAFT v0.1** · Target: AzerothCore (WotLK 3.3.5a) · Build: C++20, CMake, GoogleTest

This is the authoritative spec. Per the project workflow: **spec → tests → code**. No
implementation lands before its spec section and its failing test exist. When requirements
change, this document is updated first, then tests, then code.

---

## 1. Purpose & Scope

`mod-branding` implements the interconnected progression systems described in the design doc:
Branding (player + item identity), Brand Proficiency/Knowledge, Mastery, Invasions/Events,
Contribution-based personal loot, Zone/Event scaling, Allegiance, Account Vault, and the
Economy loop.

It is delivered as a **single AzerothCore module** containing **multiple federated pure-core
static libraries** plus a thin adapter layer that wires those libraries into the server.

### Non-negotiable design rules (from the design doc)

- Scaling is **downward only** in the world; **events override zone rules**.
- Rewards are **individualized** (personal loot), never tag/corpse dependent.
- Brands change **proc frequency / behavior / triggers**, never flat ±% damage as a primary lever.
- **Brand Knowledge** is account-wide (access); **Brand Proficiency** is per-character (strength).
- Branded items modify **XP sources/efficiency and proc behavior**, never grant proficiency directly.
- Catalyst effects in a raid follow **diminishing returns** (1st full, 2nd reduced, 3rd+ heavy).
- Nothing becomes obsolete: scaling + economy keep all content relevant.
- **No pay-to-win (foundational).** Power is **dual-keyed**: account-layer *access* (Brand Knowledge
  §6, Mastery unlocks §14) × character-layer *earned proficiency* (§7). Both are required for an
  effect to fire, and expression is gated by the **current account's** access at *use* time. So
  trading/boosting/gold transfers a leveled *body* + gear, but never the account-side access or the
  per-account-earned progression — a purchased max-proficiency character is **inert** on an account
  that hasn't earned the Knowledge/Mastery itself. There is no zero-to-hero boost and no way to pay
  to become a god. (Character trading, Warmane-style, is therefore *safe* to allow if desired.)

---

## 2. The Core Architectural Principle: Pure-Core / Adapter Split

AzerothCore gameplay code is normally untestable because it is welded to live `Player*`,
`Creature*`, `Unit*`, `Spell`, and DB objects that exist only inside a running worldserver.

**We invert this.** All decision logic lives in dependency-free C++20 libraries (`core/`) that
know nothing about AzerothCore. They operate on plain structs (POD-ish value types) and return
plain results. The server-facing `src/` layer is a set of **thin adapters** that:

1. read live game state → build a core input struct,
2. call a pure core function,
3. apply the core's output back to game state / DB.

```
        ┌──────────────────────────────────────────────┐
        │  AzerothCore worldserver (Player*, Spell, DB)  │
        └───────────────┬───────────────▲────────────────┘
            read state   │               │  apply result
                         ▼               │
        ┌──────────────────────────────────────────────┐
        │  src/  ADAPTERS  (PlayerScript, hooks, DB IO)  │  ← integration-tested (few)
        └───────────────┬───────────────▲────────────────┘
              input DTO  │               │  result DTO
                         ▼               │
        ┌──────────────────────────────────────────────┐
        │  core/  PURE LOGIC  (no AC includes, POD I/O)  │  ← unit-tested (most), instant
        └──────────────────────────────────────────────┘
```

**Consequence:** ~80% of the design is pure functions over plain structs and is fully
TDD-able with GoogleTest, with zero worldserver build and sub-second test runs. The adapter
layer is deliberately dumb and covered by a small number of integration tests.

**Dependency injection:** adapters depend on core via interfaces, and core depends on
*nothing* from the host. Where core needs an external capability (e.g. "current server time",
"config value", "RNG"), it receives it as an injected interface/parameter — never a global.
This keeps tests deterministic (inject a fixed clock / seeded RNG / fake config).

---

## 2.1 Stat Resolution Pipeline (ordering contract)

**Scaling is always applied first; branding multiplies on top of the scaled baseline.** This is a
hard composition order, asserted by tests, because the two systems must never be conflated.

```
raw player stats
      │  (1) SCALING  — downward zone scaling, OR event scaling if in an event (event overrides zone)
      ▼
scaled baseline      e.g. a level-80 tank entering Molten Core is scaled to the MC tank
      │              bracket → ~20k HP. This is the "fair fight" baseline for that content.
      │  (2) BRANDING — personal/raid multipliers (§7.9) apply ON TOP of the scaled baseline,
      ▼              gated by proc windows + EffectStrength.
final effective stats   e.g. Fire-Branded MC tank: 20k HP baseline × personal spike during a
                        fire-immunity window → the dramatic, visible survivability moment.
```

Formal contract (pure composition of two pure functions):

```cpp
ScaledStats  base  = ApplyScaling(rawStats, context);          // Slice 2
EffectiveStats out = ApplyBranding(base, brandState, role, ...); // Slice 7, multiplies `base`
```

**Invariants (tested):**

- Branding **consumes the scaled value**, never the raw value: `ApplyBranding` takes
  `ScaledStats`, not raw stats. (A test feeds different raw stats that scale to the same baseline
  and asserts identical branded output.)
- **Event scaling overrides zone scaling** when both apply (design §2): in event context,
  `ApplyScaling` uses the event bracket and ignores the zone bracket.
- The 20k-HP example is a fixture test: `ApplyScaling(level80Tank, MoltenCoreCtx).hp ≈ cfg bracket
  target`, then `ApplyBranding(...).hp == base.hp × personalMul` during a window, `== base.hp` outside.
- Order is fixed: scaling never sees branded stats; branding never sees raw stats.

---

## 2.2 Group-Size (Raid) Scaling

A third scaling axis, orthogonal to per-player downscaling (§2.1). Instanced content (MC, dungeons,
raids) is **doable at any group size** — a 5-man *can* clear Molten Core — but a smaller group
faces a scaled-down encounter and earns **less and lower-quality** reward than a full raid. This is
what keeps both small-group and full-raid play viable without making either pointless.

Two pure outputs, both functions of group size relative to content's intended size:

```cpp
struct GroupContext { uint8_t groupSize; uint8_t contentSize; }; // e.g. {5, 40} = 5-man in MC

// (1) Encounter side — scale boss/trash stats to the group.
double EncounterHealthMul(GroupContext const&, IBrandingConfig const&);
double EncounterDamageMul(GroupContext const&, IBrandingConfig const&);

// (2) Reward side — "won't drop as good or as many" for a smaller group.
struct RewardScale {
    uint32_t materialQuantity;  // how MANY drops
    uint8_t  maxTier;           // how GOOD (caps reward tier)
    double   rareChanceMul;     // rare/epic catalyst chance
};
RewardScale RewardScaleForGroup(GroupContext const&, IBrandingConfig const&);
```

**Composition with the pipeline:** group scaling is the *encounter+reward* scalar; §2.1 is the
*per-player stat* pipeline. They are independent: player stats downscale to the bracket (§2.1),
the encounter scales to the group (§2.2), and branding (§7.9) applies per player on top.

**Invariants (tested):**

- **Completability**: at `groupSize == 1` (or any size below `contentSize`), `EncounterHealthMul`
  and `EncounterDamageMul` are bounded so the content remains beatable — never an impossible wall.
- **Monotonic difficulty**: encounter multipliers are non-decreasing in `groupSize`, clamped at
  `contentSize` (a 41st body in a 40-man adds nothing).
- **Monotonic reward**: `materialQuantity` and `maxTier` are non-decreasing in `groupSize` — a full
  raid drops *at least* as much and as good as a smaller group (the core "full raid is worth it").
- **Per-capita policy** *(open question — see §11)*: whether per-player reward is flat, favors
  larger groups, or favors smaller groups is a tunable encoded in `IScalingConfig` and pinned by a
  test once chosen. This decides whether players zerg for efficiency or split for pace.
  *(Slice 2 default: total reward ∝ group fraction ⇒ ≈flat per-capita; only the monotonic-total
  invariant is asserted, not a per-capita policy, pending the §11 decision.)*
- Reward scaling reuses the §9.4/§4 personal-loot delivery path (per-player, no tagging).

---

## 2.3 Reference implementations (study, do NOT import or depend on)

Existing AzerothCore modules solve adjacent problems. Use them to mine hook points and known
exploits — but none is downward-only-then-branding-on-top, so we study and reimplement, not link.

| Reference module | Relevant to | What to borrow | Why not import |
|---|---|---|---|
| **mod-zone-difficulty** | §2.1 zone brackets | The `zone_difficulty_info` **table shape** — the official per-zone nerf/debuff support pattern. Our v1 reads `AreaTableEntry::area_level`; evolve to a configurable per-zone bracket table like this. | It's nerf/debuff-per-zone, not a downward stat-scaling pipeline feeding branding. |
| **mod-autobalance** | §2.2 / §15 group encounter scaling | Encounter-side hook points (scale creature HP/dmg to player count) **and its count-snapshot timing exploit** — exactly our Risk #4 (`GroupSize_SnapshotAtGrant_NotPull`): sample group size at grant/continuously, never at pull. | Its scaling isn't downward-only and doesn't layer branding on top. |
| **mod-solocraft** | §2.2 small-group-clears-big-content (player side) | Group-size detection + stat-application plumbing. | It scales players **up**; we downscale (§2.1) — opposite direction, same plumbing. |

**Current scaling adapter status:** player downscaling is wired (`src/Scaling*` — `UnitScript::Modify*Damage`
scales an over-leveled player's *outgoing* damage by the §2.1 core factor). The bracket now comes from
the admin-tunable `branding_zone_bracket` (zone_id → target_level) table, loaded into the pure
`ZoneBracketTable` (`src/core/scaling/ZoneBracket.h`) at startup/`.reload config`; a configured zone
overrides the built-in `AreaTableEntry::area_level`, and unconfigured zones keep the `area_level`
fallback (v1 behaviour). Event-phase bracket override is a noted future extension layered on this
resolution. Group-size encounter/reward scaling (§2.2) and incoming-damage/healing scaling are not yet wired.

---

## 3. Module Layout

One module. The pure core lives **under `src/`** (`src/core/`) because the AzerothCore module
build collects compiled sources and include dirs from `src/` only. `tests/` is a *sibling* of
`src/`, so it is naturally excluded from the server build while remaining available to the
standalone fast-loop target. (✓ = implemented in Slice 1.)

```
modules/mod-branding/
├── docs/ARCHITECTURE.md             # this file
├── conf/mod_branding.conf.dist      # tunables (collected by the module build)            ✓
├── src/                             # COMPILED INTO THE SERVER (AzerothCore collects src/ only)
│   ├── core/                        # PURE C++20. No AzerothCore includes anywhere here.
│   │   ├── common/                  # DI interfaces injected by adapters
│   │   │   ├── Brand.h              # BrandId / ActivitySource / RoleContribution enums       ✓
│   │   │   ├── Clock.h              # IClock interface (inject time)                           ✓
│   │   │   └── Config.h             # IBrandingConfig interface (inject tunables)             ✓
│   │   ├── proficiency/             # ◀ SLICE 1
│   │   │   ├── Types.h              # XpActivity, ProficiencyState, XpResult, KnowledgeState   ✓
│   │   │   ├── BrandXp.{h,cpp}      # XP gain + modifiers + diminishing returns                ✓
│   │   │   ├── Proficiency.{h,cpp}  # level curve, XP→level, effect strength                   ✓
│   │   │   └── Knowledge.{h,cpp}    # account access gates (earn + express, anti-P2W)          ✓
│   │   ├── scaling/ (Slice 2)  contribution/ (Slice 3)  catalyst/ (Slice 4)  economy/ (Slice 5)
│   ├── ServerClock.h                # IClock over GameTime (adapter)                          ✓
│   ├── BrandingConfig.{h,cpp}       # IBrandingConfig over sConfigMgr (adapter)               ✓
│   ├── ProficiencyMgr.{h,cpp}       # ObjectGuid-keyed cache, load/save, ApplyActivity         ✓
│   └── ProficiencyScripts.cpp       # World/Player hooks + Addmod_brandingScripts()            ✓
└── tests/                           # GoogleTest. NOT compiled into the server (sibling of src/)
    ├── standalone/CMakeLists.txt    # builds branding_core_tests (FetchContent gtest 1.12.1)   ✓
    ├── fakes/                       # FakeClock, FakeConfig (DI test doubles)                  ✓
    └── proficiency/                 # BrandXpTest, ProficiencyTest, KnowledgeTest (20 tests)   ✓
```

### CMake strategy (the key to fast TDD)

There are **two build paths**, by design:

1. **Standalone fast loop (primary TDD).** `tests/standalone/CMakeLists.txt` is a self-contained
   project: it FetchContent-pulls googletest 1.12.1 (the version AzerothCore pins) and compiles
   `src/core/*.cpp` + `tests/**` into `branding_core_tests`, linking **only** gtest — no `game`,
   no worldserver, no DB. Configure + build + run in seconds:

   ```bash
   cmake -S modules/mod-branding/tests/standalone -B <build> && cmake --build <build>
   <build>/branding_core_tests        # or: ctest --test-dir <build> --output-on-failure
   ```

2. **Server build.** The AzerothCore module system auto-collects all sources and include dirs
   under `src/` (so `src/core` headers resolve with no extra CMake), links `game`, and wires
   `Addmod_brandingScripts()` into the module loader. `tests/` is untouched by this path.

> **Rule:** anything under `src/core/` that `#include`s an AzerothCore header is a spec violation.
> Verified by grepping `src/core/` for forbidden includes (currently only `<cstdint>`,
> `<algorithm>`, `<cmath>` and own headers).

---

## 4. Test Strategy

| Layer | Target | Links | Speed | Coverage goal |
|---|---|---|---|---|
| `core/` pure logic | `branding_core_tests` | core + gtest only | sub-second | ~all branches; this is where TDD happens |
| `src/` adapters | `unit_tests` (via module reg) | game + mocks | slow (game build) | thin: state→DTO mapping, DTO→state apply |
| DB persistence | manual / integration | live MySQL | slow | round-trip load/save, idempotent SQL |

**TDD discipline per slice:** for each core function, write the failing GoogleTest first
(red) using injected `FakeClock`/`FakeRng`/`FakeConfig`, implement minimally (green), refactor.
Determinism is mandatory — no `std::rand`, no wall-clock, no global config reads inside `core/`.

---

## 5. System Classification (all 18 design sections)

| # | System | core/ (TDD) | adapter (integration) | data (SQL) |
|---|---|---|---|---|
| 2 | Zone scaling (downward) | **formula** | apply scaled stats | bracket tables |
| 2 | Event scaling (override) | **normalize fn** | phase hook applies | event defs |
| 3 | Event = public raid | enrollment ruleset | **auto-enroll on phase** | event roster |
| 3 | Participation tracking | **score accumulator** | capture dmg/heal/etc | — |
| 4 | Personal loot | **tier→reward roll** | chest/inv/mail delivery | loot tables |
| 5 | Branding (player/item) | brand state model | apply item brand to procs | item/player brand cols |
| 6 | Brand Knowledge (acct) | **unlock queries** | account load/save | account_branding |
| 6 | Brand Proficiency (char) | **xp/level/strength** | char load/save | char_branding |
| 7 | Brand XP rules | **modifiers + DR** | feed activity events | — |
| 8 | Branding combat effects | effect-strength calc | **modify proc freq/behavior** | spell mappings |
| 9 | Catalyst (raid) | **stacking DR curve** | apply aura/mechanic | — |
| 10 | Item branding + **proc loadout** | **loadout validation + archetype resolve** | apply chosen proc to weapon | item_brand, char_loadout |
| 11 | Prestige (max prof) | **threshold detection** | grant title/aura | title/aura defs |
| 12 | Allegiance | **efficiency modifiers** | reward/efficiency apply | char_allegiance |
| 13 | Account vault | transfer-cost calc | **storage IO** | account_vault |
| 14 | Mastery (acct unlock + char prof) | **knowledge/prof split** | unlock IO | mastery tables |
| 15 | Dungeon/raid scaling access | reuse zone/event scaling + **group-size scaling (§2.2)** | scale encounter+reward on enter | — |
| 16 | Economy loop | **recipe/material resolve** | grant/consume items | recipes, fragments |
| 17 | TDD model | — | — | — |
| 18 | Philosophy | — | — | — |

Bold = the testable pure-logic heart of each system.

---

## 6. Build Order (sequencing)

Each slice = spec section + failing tests + green core + thin adapter + persistence.

1. **Slice 1 — Brand XP + Proficiency** (the spine; see §7). Everything downstream reads proficiency.
2. **Slice 2 — Scaling formulas** ✓ (§2.1 zone + event override; §2.2 group-size encounter & reward
   scaling). Pure math; gates dungeon/raid/invasion access and yield. *Implemented: `src/core/scaling/`
   (Scaling, GroupScaling, IScalingConfig); 12 tests green.*
3. **Slice 3 — Dynamic events + Contribution → reward tiers** ✓ (§9): action scoring engine, the
   guardrails (hourly cap, daily DR, anti-leech, reward diversity, account economy ceiling), reward
   tiers, and region containment. Subscription/spawns/overlay are adapter/data (not yet built).
   *Implemented: `src/core/contribution/` (Contribution, RewardTier, Containment, RewardDiversity,
   AccountCeiling) + `common/Rng.h`; 23 tests green incl. the §10 adversarial named cases.*
4. **Slice 4 — Catalyst stacking DR.** ✓ Small, sharp; consumes proficiency from Slice 1.
   *Implemented: `src/core/catalyst/` (CatalystStacking, ICatalystConfig); 6 tests green.
   RaidCatalystMultiplier ∈ [1.0, MaxRaidMul], non-increasing in rank (1st full, 3rd+ heavy).*
5. **Slice 5 — Exploration/Discovery + Allegiance + Economy** ✓ (§8/§12): discovery XP + tier
   classification + economy resolution (pure), allegiance efficiency. *Implemented:
   `src/core/allegiance/`, `src/core/economy/` (Discovery, Economy); 9 tests green.*
   *Allegiance adapter (§12) wired:* `character_allegiance` persistence, `AllegianceMgr` (load/save +
   `Efficiency`), `.branding allegiance set <id>` (validates via the pure `ParseAllegiance`), and one
   application point — the event XP reward is multiplied by the player's efficiency for the event's
   alignment (`EventAlignment`); a mismatch / no allegiance / disabled system stays exactly 1.0.
   **Deferred:** the §8.5 XP-balance regression sim (needs the representative play-session profile
   you sanity-check) and §8.4 world-spawned content (data, authored against the tier rules).
6. **Slice 6 — Account vault + Mastery wiring** ✓ pure parts (mostly persistence + adapters).
   *Implemented: `src/core/vault/` (transfer friction + capacity) and `src/core/mastery/`
   (dual-key effectiveness: account-unlock × character-skill, anti-P2W; plus `MasteryBonus` =
   bounded efficiency value and the `MasterySystem` list Gathering/Crafting); 9 mastery+vault tests
   green. **Mastery adapter wired (#07):** `MasteryMgr` (account-unlock cache + per-char level cache,
   keyed by ObjectGuid) calls the core dual-key; tables `account_mastery` + `character_mastery`;
   consumer = small crafting/gathering efficiency bonus (`OnPlayerCreateItem`/`OnPlayerLootItem`),
   surfaced in `.branding info`. Vault adapter still deferred.*
7. **Slice 7 — Combat effect application + Item branding + Prestige cosmetics** ✓ pure parts
   (application is adapter-heavy, deferred). *Implemented: `src/core/effects/` (EffectModel:
   Personal/Raid multipliers with caps + catalyst-weighted stacking + role asymmetry + windowed
   uptime + prestige; ItemBrand: step/level intensity, upgrade, difficulty ordering, anti-P2W,
   loadout validation); 12 tests green. Spell/aura/proc application to AzerothCore deferred.*

Rationale: build pure-logic, high-leverage cores first; defer adapter-heavy/cosmetic systems.

---

## 7. SLICE 1 SPEC — Brand XP + Proficiency

### 7.1 Concepts

- **BrandId** — enum of brands: `Fire, Frost, Nature, Shadow, Arcane, Holy, Physical` (extensible).
- **Brand Knowledge** *(account)* — set of `BrandId` the account has unlocked. Gates whether a
  character may earn proficiency in that brand. Pure queries; persistence is account-scoped.
- **Brand Proficiency** *(character)* — per `(character, BrandId)`: an XP total and a derived
  level. Level → **effect strength** (a normalized multiplier consumed by later slices; it is NOT
  flat player damage — it scales proc frequency / effect behavior magnitude).

### 7.2 Pure types (core/common + core/proficiency)

```cpp
enum class BrandId : uint8_t { Fire, Frost, Nature, Shadow, Arcane, Holy, Physical, COUNT };

enum class ActivitySource : uint8_t { Invasion, Raid, Dungeon, Gathering, Crafting, Pvp };

enum class RoleContribution : uint8_t { None, Tank, Healer, Damage, Control, Support };

struct XpActivity {              // built by adapter from a gameplay event
    ActivitySource source;
    BrandId         activeBrand;     // the player's active brand at the time
    BrandId         contentBrand;    // the content/event's aligned brand (for match bonus)
    RoleContribution role;
    uint32_t        baseUnits;       // raw activity magnitude (e.g. objective points)
};

struct ProficiencyState {        // loaded from DB, mutated by core, saved by adapter
    uint64_t totalXp = 0;
    uint32_t recentXpWindow = 0; // for diminishing returns (decays over time)
    uint64_t windowStartUnix = 0;
};

struct XpResult {
    uint32_t xpGained;           // after all modifiers + DR
    uint8_t  levelBefore;
    uint8_t  levelAfter;
    bool     reachedPrestige;    // hit max level this gain
};
```

### 7.3 Pure functions (the spec contract — tests assert these)

```cpp
// XP modifiers (design §7): content relevance, brand-match bonus, role bonus, then DR.
uint32_t ComputeXpGain(XpActivity const& a, ProficiencyState const& s,
                       IBrandingConfig const& cfg, IClock const& clock);

// Level curve (design §6): monotonic, saturating at MaxLevel.
uint8_t  LevelForXp(uint64_t totalXp, IBrandingConfig const& cfg);
uint64_t XpForLevel(uint8_t level, IBrandingConfig const& cfg);

// Effect strength (design §8): level → normalized [0.0 .. 1.0+] multiplier for proc behavior.
double   EffectStrength(uint8_t level, IBrandingConfig const& cfg);

// Apply an activity: mutates state, returns result (pure given injected clock/config).
XpResult ApplyActivity(ProficiencyState& s, XpActivity const& a,
                       IBrandingConfig const& cfg, IClock const& clock);

// Knowledge gate: may this account earn proficiency in this brand?
bool     CanEarnProficiency(BrandId b, KnowledgeState const& k);

// Anti-P2W use-time gate: may THIS account EXPRESS this brand right now? Evaluated at effect
// time against the CURRENT account's access — not at earn time. A traded/boosted character whose
// proficiency was earned elsewhere is inert until the current account has the Knowledge itself.
// EffectStrength is forced to 0 when this is false, regardless of stored proficiency.
bool     CanExpressBrand(BrandId b, KnowledgeState const& currentAccount);
```

### 7.4 Formula spec (tunable via injected config; defaults here for tests)

Let `base = a.baseUnits * cfg.SourceWeight(a.source)`.

- **Content relevance:** `× cfg.RelevanceMul(a.source)` (e.g. invasion 1.0, gathering 0.5).
- **Brand match bonus:** `× (a.activeBrand == a.contentBrand ? cfg.MatchBonus : 1.0)` (default 1.25).
- **Role contribution bonus:** `× cfg.RoleMul(a.role)` (default 1.0; control/support nudged up).
- **Diminishing returns:** if `s.recentXpWindow` exceeds `cfg.DrSoftCap`, apply
  `× cfg.DrFactor(recentXpWindow)` decaying toward `cfg.DrFloor` (default floor 0.1). Window
  decays to 0 after `cfg.DrWindowSeconds` (injected clock drives decay) to "encourage varied
  gameplay" and "prevent farming loops" (design §7).
- **Branded items:** do **not** add XP directly. They alter `SourceWeight`/`RelevanceMul` inputs
  (passed in via the activity/config), per design §6 ("modify XP sources and efficiency instead").

Level curve: `XpForLevel(n) = round(cfg.BaseXp * n^cfg.Exponent)`, clamped at `cfg.MaxLevel`.
`EffectStrength(level) = min(1.0, level / cfg.MaxLevel)` baseline (config may reshape the curve).

> All constants live behind `IBrandingConfig`. Production reads `sConfigMgr`; tests inject a
> `FakeConfig` so formulas are pinned and deterministic.

### 7.5 Invariants (property-style assertions)

- `ApplyActivity` is **monotonic**: `totalXp` never decreases; `levelAfter >= levelBefore`.
- Level is **saturating**: never exceeds `cfg.MaxLevel`; `reachedPrestige` true only on the
  gain that first reaches max.
- **DR is bounded**: effective multiplier ∈ `[cfg.DrFloor, 1.0 + bonuses]`; never negative.
- **Determinism**: same inputs + same injected clock/config ⇒ identical `XpResult`.
- **Knowledge gate**: `ApplyActivity` yields 0 XP if `!CanEarnProficiency(brand, knowledge)`.
- **Anti-P2W use-time gate**: `EffectStrength` resolves to 0 if `!CanExpressBrand(brand,
  currentAccount)`, *regardless of stored proficiency* — a high-proficiency character is inert on an
  account lacking the Knowledge. Tests: `Expression_RequiresCurrentAccountKnowledge`,
  `TradedCharacter_InertWithoutAccountAccess` (proficiency=max + account Knowledge=none ⇒ strength 0).
- **Idempotent persistence**: load(save(state)) == state.

### 7.6 Test matrix (`tests/proficiency/`) — written FIRST (red)

`BrandXpTest.cpp`
- base gain with neutral config equals `baseUnits × weight`.
- brand-match bonus applied iff `activeBrand == contentBrand`.
- role multiplier applied per role.
- source relevance scales gain (invasion > gathering).
- DR kicks in past soft cap; multiplier decays toward floor; never below floor.
- DR window decays with injected clock advance → full XP restored after window.
- branded-item efficiency changes alter gain via config, not as additive XP.
- knowledge gate: locked brand ⇒ 0 XP.

`ProficiencyTest.cpp`
- `XpForLevel` monotonic increasing; `LevelForXp` is its inverse (round-trip within a level band).
- level saturates at `MaxLevel`; `reachedPrestige` fires exactly once at the boundary.
- `EffectStrength` monotonic, bounded in `[0, 1]` at defaults.
- `ApplyActivity` monotonicity + determinism (same seed/clock ⇒ identical result).

### 7.7 Persistence (adapter, integration-tested — written after core is green)

Character DB (`acore_characters`), via `pending_db_characters` SQL update + PreparedStatement:

```sql
-- character_branding: per (guid, brand)
guid BIGINT UNSIGNED, brand TINYINT UNSIGNED,
total_xp BIGINT UNSIGNED, recent_window INT UNSIGNED, window_start INT UNSIGNED,
PRIMARY KEY (guid, brand)  -- InnoDB
```

Account DB (`acore_auth`) for Knowledge (account-wide):

```sql
-- account_brand_knowledge: per (account, brand)
account BIGINT UNSIGNED, brand TINYINT UNSIGNED, unlocked_at INT UNSIGNED,
PRIMARY KEY (account, brand)  -- InnoDB
```

SQL goes in `data/sql/updates/pending_db_characters/` and `pending_db_auth/` via
`create_sql.sh`, every `INSERT` preceded by a matching `DELETE` (codestyle-sql rule).

Adapter (`ProficiencyPlayerScript` + `ProficiencyMgr`): load on `OnLogin` → cache by `ObjectGuid`,
mutate the cached `ProficiencyState` when activity hooks fire (calling `ApplyActivity`), flush
on `OnLogout`. **No raw `Player*` stored past the tick** — cache keyed by `ObjectGuid`.

> **Implemented (Slice 1) — status:** the adapter layer is **compile-verified** — CMake configure
> detects the module (it appears in the static-modules list with `mod_branding.conf`), and all three
> adapter TUs (`BrandingConfig`, `ProficiencyMgr`, `ProficiencyScripts`) pass `g++ -fsyntax-only`
> with the build's exact flags against the real game headers. (The verification caught a real bug:
> `BrandingConfig.cpp` used the `uint32` typedef without pulling in `Define.h` — fixed to `uint32_t`.)
> Only full linking is unverified (the multi-hour worldserver link was not run). Known
> simplification: login loads are **blocking** `Query`s (tiny PK lookups); moving to the async
> `WithCallback` path is a TODO.

### 7.8 Adapter activity sources (where XpActivity comes from)

- Invasion/raid/dungeon contribution → from Slice 3's contribution tracker (until then, a temporary
  hook on creature kill / objective for end-to-end proof).
- Gathering/crafting → profession success hooks.
- PvP (optional, config-gated) → honorable kill / objective hooks.

### 7.9 Branding Effect Model (Combat) — the legendary-vs-mandatory line

This is the contract that **Slice 7** implements and that constrains how `EffectStrength`
(§7.3) is consumed. Captured here because it defines the whole feel of the system.

**Core principle: conditional throughput, never always-on.** Branding does not add passive
`+X%`. It creates **windows** and **mechanic transforms** that reward coordination and skill.

Canonical example — **Fire Brand → "Heat Weakness":** periodically the brand exposes enemies
(an *exposure window*); during the window the raid gains a **bounded** burst (e.g. +25% for 6s).
This produces burst windows, coordination, and skill expression instead of a flat passive.

**Role-asymmetric profiles** (the same brand expresses differently per role):

| Role | Branding philosophy | Example (Fire) |
|---|---|---|
| **Tank** | **Dramatic & visible** survivability spikes — the "face" of Branding | huge HP, lava-walking, fire-immunity windows, heat aggro amplification |
| **DPS** | **Restrained** — consistency, utility, proc synergies; *not* explosive flat damage (meta protection) | proc-cadence synergies, conditional triggers |
| **Healer** | **Behavior transforms** of healing, not raw HPS | overheal → shields; (Nature) HoTs spread; (Shadow) damage → smart heals |

**The three-magnitude balancing rule (formal invariants — testable):**

1. **Large personal multipliers → fantasy.** `PersonalEffect` may be big (esp. tanks).
   Bounded by `cfg.MaxPersonalMul` (**default 3.0–4.0**). Felt by the player, not imposed on others.
2. **Bounded raid multipliers → desirability, not mandate.** `RaidEffect` is **always bounded by
   `cfg.MaxRaidMul`** (**default 2.0**) **and** further reduced by the catalyst stacking DR
   (Slice 4). Bounded + DR'd is what keeps a brand desirable without becoming mandatory.
3. **Mechanic manipulation → mastery.** The highest skill expression is structural transforms
   (HoT spread, overheal→shield, damage→heal, exposure windows), gated/scaled by `EffectStrength`,
   not bigger numbers.

**Pure model (core/effects/, Slice 7):**

```cpp
enum class EffectKind : uint8_t { PersonalSpike, RaidWindow, MechanicTransform };

struct EffectProfile {                 // looked up by (BrandId, RoleContribution)
    EffectKind kind;
    uint32_t   windowDurationMs;       // RaidWindow / PersonalSpike duration
    uint32_t   cooldownMs;             // cadence between exposures/windows
};

// Magnitude of an effect given proficiency. Personal vs raid governed by DIFFERENT caps.
double PersonalMultiplier(uint8_t level, EffectProfile const&, IBrandingConfig const&);
double RaidMultiplier(uint8_t level, EffectProfile const&, IBrandingConfig const&,
                      uint8_t brandedAlliesOfSameRole /* catalyst DR input */);
```

**Effect-model invariants (tests, written first):**

- `RaidMultiplier(...) <= cfg.MaxRaidMul` for **all** levels and inputs (mandatory cap).
- `RaidMultiplier` is **monotonically non-increasing** in `brandedAlliesOfSameRole` (catalyst DR:
  1st full, 2nd reduced, 3rd+ heavily reduced) and never below `1.0` (a brand never *hurts* raid).
- `PersonalMultiplier` may exceed `MaxRaidMul` but is bounded by `cfg.MaxPersonalMul`.
- For a fixed role, **tank** profiles produce strictly larger personal magnitudes than **dps**
  at equal level (encodes "tank branding is dramatic, dps is restrained").
- Windowed effects are **off** outside `[exposure, exposure+windowDuration)` — no passive uptime;
  uptime fraction `= windowDuration / (windowDuration + cooldown)` is asserted < 1.0.
- Healer `MechanicTransform` profiles return `kind == MechanicTransform` (transform, not multiplier)
  — the adapter applies the structural change; core only decides *whether/how strongly*.

**Player-selected proc loadout (player agency layer).** A character does not get a fixed effect —
they **choose** which proc/effect archetype their branding expresses (e.g. *which* weapon proc is
branded, and which expression of the active brand fires). This is the expression-customization knob.

```cpp
struct BrandLoadout {                 // per character, persisted
    BrandId  activeBrand;
    uint8_t  selectedProcArchetype;   // index into the brand+role's available archetypes
    // (future) per-slot item-brand proc selections
};

// Pure validation: is this selection legal for the character right now?
bool IsLoadoutValid(BrandLoadout const&, KnowledgeState const&, uint8_t proficiencyLevel,
                    IBrandingConfig const&);
```

Validation invariants (tested): selected brand must be account-unlocked (`CanEarnProficiency`);
`selectedProcArchetype` must be within the set the (brand, role) exposes *and* unlocked at the
character's proficiency level (higher archetypes gate behind proficiency). The **core only
validates and resolves** the chosen archetype to an `EffectProfile`; the **adapter** applies the
chosen proc to the actual weapon/spell. Loadout changes are subject to friction/cost per design
(no free instant re-spec abuse) — friction cost computed in core, charged by adapter.

**Item brand upgrade progression (Slice 7, pure).** A branded item progresses through a few major
**Steps** (I/II/III…), each filled by **5–10 internal upgrade levels**. Internal levels scale a
**percentage of effect/proc intensity** — proc frequency, exposure-window length, HoT-spread radius,
etc. — **never raw character stats** (per §1, §10: behavior, not bigger numbers). A Step is a
milestone that may unlock a new proc archetype (§7.9 loadout); internal levels tune intensity toward
the next Step.

```cpp
struct ItemBrandState {
    BrandId  brand;
    uint8_t  step;          // major milestone within the brand
    uint8_t  levelInStep;   // 0..cfg.LevelsPerStep (5–10, configurable)
    uint32_t upgradeProgress;
};

// Effect/proc INTENSITY multiplier from item branding (behavior, not stats). Combines with the
// player's EffectStrength (§7.3) and the §7.9 caps; subject to CanExpressBrand (anti-P2W).
double ItemEffectIntensity(ItemBrandState const&, IBrandingConfig const&);

// Consumes economy resources (§16); fills internal levels, then advances the Step.
ItemUpgradeResult ApplyItemUpgrade(ItemBrandState&, uint32_t resources, IBrandingConfig const&);
```

**Invariants (tested):**
- `ItemEffectIntensity` is monotonic non-decreasing in `(step, levelInStep)`, bounded by a cap — and
  scales **behavior/proc intensity only**, asserted to contribute *no* flat character-stat delta.
- Filling `levelInStep == cfg.LevelsPerStep` advances `step` (resets level), up to `cfg.MaxStep`.
- **Difficulty ordering**: cumulative upgrade cost to max an item's brand `<` cumulative cost to
  unlock account-side Knowledge for that brand (item branding is *hard but easier than account*).
- **Anti-P2W**: item intensity contributes to the effect only when `CanExpressBrand(currentAccount)`
  — a traded/maxed branded item is inert on an account lacking the Knowledge (`ItemBrand_TradedMaxed_InertWithoutAccess`).

The adapter layer (Slice 7) maps these decisions onto AzerothCore: exposure windows → debuff auras
+ proc-frequency modification; personal spikes → tank survivability auras; mechanic transforms →
spell-script behavior changes. Core stays pure; only the adapter touches `Spell`/`Aura`/`Unit`.

---

## 8. Exploration, Discovery & Economy Model

This system makes the **world itself content** and ties exploration into the closed economy loop.
Most of it is pure, structured rules — ideal for both TDD and bulk LLM content generation.

### 8.1 The closed loop (replaces kill→loot→vendor→gold)

```
   ┌──────────────────────────────────────────────────────────┐
   │  explore → discover → craft → specialize → influence → … →  │  (loops back to explore/invade)
   └──────────────────────────────────────────────────────────┘
   explore        → area discovery XP
   discover        → hidden world objects → profession XP / recipes / reputation / hidden quests
   craft           → character XP, consumes materials + fragments
   specialize      → brand proficiency (§7), allegiance influence (§12)
   influence/invade→ fragments + catalysts → feed crafting/branding → repeat
```

Self-regulating: invasions generate fragments, dungeons materials, raids high-tier catalysts;
crafting + branding consume them. Goal (design): no content obsolescence; no inflation collapse.

### 8.2 Area Discovery XP (pure)

Discovery XP is a **major pillar** (much larger than retail's token amounts), expressed as a
**percentage of the player's current level**, so it never trivializes or becomes obsolete.

```cpp
enum class DiscoveryType : uint8_t { Subzone, Landmark, Hidden };

// XP as a fraction of the player's level-to-next, per design bands:
//   level-appropriate subzone : 4–8%
//   dangerous higher-level zone (zoneLevel > playerLevel + cfg.DangerThreshold) : 10–15%
//   hidden landmark : flat bonus on top
uint32_t DiscoveryXp(uint8_t playerLevel, uint8_t zoneLevel, DiscoveryType,
                     IBrandingConfig const& cfg);
```

**Invariants (tested):**

- **Idempotent**: an already-discovered location yields 0 (dedupe set keyed by location id).
- **Danger pays more**: `zoneLevel > playerLevel + threshold` yields strictly more than a
  level-appropriate discovery (encourages risky entry).
- **Scales with level**: output tracks the player's XP-to-next curve (a % of level), never flat —
  so a low-level Elwynn subzone and a max-level subzone are both meaningful in relative terms.
- **Hidden > Landmark > Subzone** for an equal zone at equal player level.

### 8.3 Discovery Tier system (pure) — the LLM content ruleset

```cpp
enum class DiscoveryTier : uint8_t { Common, Uncommon, Rare, Epic };
DiscoveryTier TierForZoneLevel(uint8_t zoneLevel, IBrandingConfig const& cfg);
```

| Zone level | Tier | Reward type |
|---|---|---|
| 1–20 | Common | XP, basic recipes |
| 20–40 | Uncommon | profession unlocks |
| 40–60 | Rare | advanced recipes |
| 60+ | Epic | legendary chains |

`TierForZoneLevel` is **monotonic non-decreasing** in zone level (tested). This structured ruleset
is the contract bulk content is generated against: *"generate N blacksmith discoveries for zones
20–30 following Tier 2 rules."* Content (gameobjects, recipes, quest hooks) is **data** — placed
via SQL, LLM-authored against the tier rules — not core logic. Core only classifies and scores.

### 8.4 World-spawned profession items

The world spawns profession-flavored discoverables (e.g. *rusted dwarven hammerhead* for BS in
20–30, *abandoned herbal journals* for Alchemy in 35–45, *arcane residue nodes* for Enchanting
50+). On interact they unlock recipes / grant profession XP / reputation / hidden quests.

- **Data (SQL):** gameobject spawns + a discovery→reward mapping table, tier-tagged.
- **Adapter:** interact hook → resolves reward via core, grants it, marks discovered (idempotent).
- **Core (pure):** reward resolution given (discovery id, tier, player state); dedupe.

**Implemented (scaffold).** Core: `economy/Discoverable.{h,cpp}` — `ResolveDiscoverable(def,
alreadyDiscovered)` (idempotent; malformed defs are a no-op) and `RewardFitsTier(tier, type)` (the
§8.3 tier↔reward contract: Common→Recipe/ProfessionXp, Uncommon→ProfessionXp/Reputation,
Rare→Recipe/Reputation, Epic→HiddenQuest). Adapter: `DiscoverableMgr` loads the
`branding_discovery_object` map (off-contract rows rejected) and a per-character dedupe set
(`character_branding_discovery`); `DiscoverableScripts.cpp` registers a `GameObjectScript`
interact hook (`OnGossipHello`) that grants the tier-appropriate reward once and records the
discovery. Reward delivery: Recipe via `RewardDelivery::DeliverItem`; ProfessionXp via `SetSkill`;
Reputation via `ReputationMgr::ModifyReputation`; HiddenQuest via `Player::AddQuest`. SQL ships a
representative set (two discoverables per tier, entries/guids 5000000+); **bulk content authoring
(the full per-profession/zone set) remains** — it extends the three data tables, no code change.

### 8.5 XP-source balance (the anti-obsolescence invariant)

Target XP mix so no single source optimizes the fun out: **Questing 45% · Professions 25% ·
Exploration 20% · World discoveries 10%.** This is enforced as a **balance regression test** — a
deterministic economy simulation (design §17) runs a representative play session through the XP
sources and asserts each aggregate share falls within tolerance of its target, with
`share(Questing)` the largest. If profession/discovery tuning drifts and starts dwarfing questing,
the test fails. This turns "don't make questing obsolete" from a hope into a CI gate.

### 8.6 Economy resolution (extends §16, pure)

Recipe/crafting resolution is a pure function over inputs (materials + fragments + discovered
recipes) → output (craftable? consumed inputs, produced item, char XP). Branding consumes economy
resources here. Tested for: insufficient-inputs rejection, exact consumption, deterministic output.

> **Placement:** §8.2/§8.3/§8.5/§8.6 are pure core (TDD). §8.4 spawns + content are data (SQL,
> LLM-generated). Discovery hooks (`OnAreaExplored`/zone-update, interact) are thin adapters.

---

## 9. Dynamic Event & Participation Model (Slice 3)

A continuous, ambient living-world layer (GW2-style public events + Rift-style invasions) over
Azeroth. The scoring engine and all balance guardrails are **pure, deterministic logic** — the
heart of Slice 3. Subscription, spawning, delivery, and the overlay are thin adapters/data.

### 9.1 Region event triggers (adapter + data)

Each zone hosts event types: `Invasion`, `ResourceSurge`, `EliteHunt`, `ProfessionAnomaly`.
Entering a zone **auto-subscribes** the player to event tracking — no UI friction, no turn-ins,
no NPC bottlenecks. Subscription is an adapter (`OnUpdateZone`); event scheduling/spawns are data.

### 9.2 Participation scoring (pure — the real engine)

Track **actions, not quest objectives** — everyone contributes differently (the GW2 psychology).

| Action | Points |
|---|---|
| Kill invading mob | +1 |
| Elite kill | +5 |
| Mini-boss | +15 |
| Heal players | +1–3 (by magnitude) |
| Gather event resource | +2 |
| Craft invasion item | +10 |
| Discover objective | +8 |

```cpp
enum class EventType   : uint8_t { Invasion, ResourceSurge, EliteHunt, ProfessionAnomaly };
enum class EventAction : uint8_t { InvadingKill, EliteKill, MiniBoss, Heal, GatherResource,
                                   CraftItem, DiscoverObjective };
enum class RewardTier  : uint8_t { None, Bronze, Silver, Gold };

uint32_t ScoreAction(EventAction a, uint32_t magnitude, IBrandingConfig const& cfg); // table lookup
```

### 9.3 Contribution accumulation + guardrails (pure — economy-critical)

The scorer is *not* a naive sum. It applies four guardrails, all deterministic and tested:

```cpp
struct ActivitySignal { uint32_t damageDealt; uint32_t actions; uint32_t movement; }; // anti-leech
struct ParticipationState {
    uint32_t pointsThisHour; uint64_t hourWindowStart;   // hourly cap window
    /* per-EventType daily participation counters for DR */
};

uint32_t ApplyEventAction(ParticipationState& s, EventType t, EventAction a, uint32_t magnitude,
                          ActivitySignal const& sig, IBrandingConfig const& cfg, IClock const& clk);
```

1. **Hourly contribution cap** — `pointsThisHour` never exceeds `cfg.HourlyCap` (stops AFK farming
   in big groups). Window resets via injected clock.
2. **Daily diminishing returns per event type** — Nth participation in the same event type yields
   strictly less than the (N-1)th, decaying toward `cfg.EventDrFloor` (stops endless single-invasion
   farming). Resets on the daily boundary (injected clock).
3. **Anti-leech gate** — if `ActivitySignal` falls below floors (`damageDealt`/`actions`/`movement`),
   the action scores **0** (simple, deterministic heuristics; no ML).
4. **(Feeds §8.5 balance)** — event XP counts toward the global XP-source mix; events must not let
   players skip questing (see the warning in §9.7).
5. **Account-wide economy-output ceiling** *(Hybrid decision, §10.3)* — guardrails 1–3 are
   per-character and pace *activity*; this fifth guardrail caps only *economy outputs* (crafting
   mats, currency) **per account** per period, so an alt-army can't multiply mat throughput. It
   gates the reward grant, not the points: a character may still earn points/XP/cosmetics past the
   account economy ceiling, but mat/currency yield is throttled once the account ceiling is hit.

```cpp
// Account-scoped, separate from per-character ParticipationState (persisted in account DB):
struct AccountEconomyState { uint32_t matsThisPeriod; uint32_t currencyThisPeriod; uint64_t periodStart; };
// Reward grant checks BOTH the per-character tier (§9.4) AND this account ceiling.
RewardGrant ClampToAccountCeiling(RewardGrant proposed, AccountEconomyState&, IBrandingConfig const&, IClock const&);
```

**Invariants (tested):** per-character points/XP are never reduced by the account ceiling
(`EventCap_PerChar_PacesActivity`); account mat/currency output never exceeds the account ceiling
across N alts in one period (`EconomyOutput_AccountCeiling_Bounded`); the ceiling resets on the
period boundary (injected clock).

**Persistence (adapter, §9.3#5 — implemented).** Both states are persisted so pacing and especially
the account economy ceiling survive a relog (an alt-army cannot reset the ceiling by relogging):

```sql
-- character_event_participation (acore_characters): per guid
guid INT UNSIGNED, total_points INT UNSIGNED,
points_this_hour INT UNSIGNED, hour_window_start BIGINT UNSIGNED, day_start BIGINT UNSIGNED,
daily_invasion INT UNSIGNED, daily_resource_surge INT UNSIGNED,        -- one column per EventType
daily_elite_hunt INT UNSIGNED, daily_profession_anomaly INT UNSIGNED,  -- (the DR counters)
PRIMARY KEY (guid)  -- InnoDB

-- account_economy_ledger (acore_auth): per account
account INT UNSIGNED, materials_this_period INT UNSIGNED,
currency_this_period INT UNSIGNED, period_start BIGINT UNSIGNED,
PRIMARY KEY (account)  -- InnoDB
```

A pure `PersistenceRow` projection (`src/core/contribution/PersistenceRow.*`) maps each struct field
1:1 to a column so the round-trip (`load(save(state)) == state`) is unit-tested without any DB.
Adapter (`EventMgr` + `BrandingEventPlayerScript`): load character participation on `OnLogin` and the
shared account ledger once per account (ref-counted across concurrent alts); flush both on `OnLogout`
and on a periodic timer (`BrandingEventWorldScript::OnUpdate`, default 5 min). Cache keyed by
`ObjectGuid`/account; **no raw `Player*` stored past the tick**. Login loads are blocking PK `Query`s
(tiny rows), mirroring `ProficiencyMgr`; moving to the async `WithCallback` path is a TODO. Adapter TU
link is **compile-verify deferred to CI** (no local worldserver build).

### 9.4 Reward tiers + auto-distribution (pure tier; adapter delivery)

```cpp
RewardTier TierForContribution(uint32_t totalPoints, IBrandingConfig const& cfg); // bronze<silver<gold
```

Reaching a threshold triggers **automatic** reward distribution — no turn-ins. Delivery reuses the
§4 personal-loot path: phase chest → auto-loot to inventory → **mailbox fallback if full**.

### 9.5 Reward diversity (pure, anti-monoculture)

No single event type drops everything. Rewards split across categories — `CraftingMats`, `Xp`,
`Currency`, `Cosmetic`, `Reputation` — and each `EventType` is restricted (by config) to a subset.
Selection uses injected RNG (deterministic under seed).

**Invariant (tested):** no single `EventType`'s reward pool spans *all* categories; given a fixed
seed the selection is reproducible.

### 9.6 Region containment aggregation (pure)

Per-region progress, **not** per-quest: *"Fel Incursion: 62% contained"* instead of
*"Kill 10 Defilers (7/10)"*. The percentage is a pure aggregation of contributed progress vs the
event goal. The client overlay/addon renders it; the server computes and broadcasts the number.

**Invariants (tested):** containment ∈ `[0,1]`, monotonic non-decreasing as actions apply,
saturates at `1.0` (completion).

### 9.7 Guardrail against an over-ambient world (design warning)

**Do not remove structured content.** Story arcs, profession chains, and dungeon unlocks remain —
otherwise the world loses direction. This reinforces §8.5: questing stays the largest XP share.
The dynamic-event layer makes players *always* feel useful (even just exploring/gathering/passing
through), but it sits *on top of* structured quests, not in place of them.

### 9.8 Invariants summary (tests, written first)

- `ScoreAction` matches the table; `Heal` scales with magnitude within its band.
- Hourly cap is never exceeded; resets on window roll (injected clock).
- Daily DR strictly decreasing per repeat, bounded by floor; resets on day roll.
- Anti-leech: sub-floor `ActivitySignal` ⇒ 0 points.
- Account economy ceiling (§9.3#5): mat/currency output bounded per account across alts; per-char
  points/XP unaffected; resets on period roll.
- Tier monotonic in points; thresholds strictly ordered.
- Reward diversity invariant (§9.5); deterministic under seed.
- Containment bounded, monotonic, saturating (§9.6).

> **Placement:** §9.2–§9.6 pure core (TDD). §9.1 subscription + spawns are adapter/data. Reward
> delivery (§9.4) reuses §4 adapter. Overlay (§9.6) is client-side; server computes the number.

---

## 10. Rates & Exploit Surface (balancing charter + adversarial test targets)

This section is the **adversarial test charter**: each risk below ships with named test cases that
encode the *attack*, not just the happy path. These are the highest-leverage balancing decisions.

### 10.1 Rate model — per-source, not one global multiplier

Rates are **per-source multipliers**, not a single global XP rate, because a flat multiplier breaks
the percentage-based and contribution-based systems (see Risk #1, #2):

```cpp
// IBrandingConfig — chosen rates (e.g. mirror Warmane "7x/3x" = baseline track only):
double QuestRate     = 5.0;   // or 7.0 — absolute quest XP
double KillRate      = 5.0;   // or 7.0 — absolute kill XP
double SkillRate     = 3.0;   // profession skill points
double DiscoveryRate = 1.0;   // %-of-level (§8.2) — KEPT LOW/INDEPENDENT (see Risk #1)
double EventRate     = 1.0;   // contribution XP (§9) — KEPT LOW/INDEPENDENT
```

**Rule:** the global "5x/7x" applies to the **absolute kill+quest baseline only**. Percentage-based
(discovery) and contribution-based (event) XP are rate-independent or use their own small
multiplier. The §8.5 balance sim is run **at the production rates** and is the arbiter of the final
per-source weights — rates and the 45/25/20/10 target are tuned *together*, never separately.

### 10.2 Ranked exploit surface (each → a guard + a named test)

| # | Risk | Where | Guard / decision | Adversarial test |
|---|---|---|---|---|
| 1 | **%-XP × rate compounding** — discovery (% of level) × global multiplier ⇒ level-per-discovery | §8.2 × §10.1 | discovery/event XP rate-independent; global rate = baseline only | `Discovery_RateMultiplier_DoesNotCompound`: high rate + dangerous discovery ⇒ bounded XP |
| 2 | **Balance ratio drifts with rate** — share targets only hold at one rate config | §8.5 × §10.1 | balance sim runs at production rates; per-source weights re-derived | `BalanceSim_HoldsAtProductionRates`: shares within tolerance at 5x/7x, not just 1x |
| 3 | **Faucet/sink collapse** — rates amplify mat faucets but not sinks ⇒ inflation | §8.1, §13, §7.9 | every faucet has a sink scaled to the same rate; faucet/sink ledger test | `Economy_FaucetSink_NetNonInflationary`: simulated loop net mat flow bounded |
| 4 | **Group-size snapshot gaming** — stack 40, set ceiling, leave, kill with 5 | §2.2 | sample group size at reward-grant / averaged over fight, **not** at pull | `GroupSize_SnapshotAtGrant_NotPull`: late-leavers don't inflate ceiling |
| 5 | **Per-character caps, account-unit farming** — alt-army funnels via shared vault | §9.3, §13 | **HYBRID (decided)**: per-character caps for pacing + account-wide soft ceiling on economy outputs (mats/currency) only | `EventCap_PerChar_PacesActivity` + `EconomyOutput_AccountCeiling_Bounded` |
| 6 | **Catalyst DR evasion** — rotate brands so "branded ally" count never trips DR | §7.9, Slice 4 | DR counts branded *allies present*, not active-effect instants; crisp rule | `CatalystDR_CountsPresence_NotActiveWindow`: rotation can't dodge DR |
| 7 | **Anti-leech bypass** — AFK-in-zerg, tag-and-leave, bot cadence | §9.3 | activity floors (damage/actions/movement); per-action gate | `Leech_AfkInZerg_ScoresZero`, `Leech_TagAndLeave_ScoresZero` |
| 8 | **Profession trivialization** — 3x skill + discovery skill ⇒ instant cap | §8.4, §10.1 | gate progression on recipes/discoveries, not just skill points | `Profession_RecipeGated_NotSkillRushable` |
| 9 | **Brand-XP feedback loop** — efficiency → more brand XP → more efficiency | §7.4 | per-source daily DR caps the loop; no multiplicative compounding | `BrandXp_FeedbackLoop_Dr_Bounded` |

### 10.3 Decisions (resolved)

- **Rates (decided):** baseline **5x XP / 3x skill** for quest/kill; discovery & event XP kept
  **rate-independent (1x)**. The global rate is the absolute kill/quest track only.
- **Cap/economy unit (decided): HYBRID.** Per-character caps drive *pacing* (hourly point cap,
  daily per-event DR, anti-leech — all in `ParticipationState`, §9.3). A separate **account-wide
  soft ceiling** bounds only *economy-relevant outputs* (crafting mats, currency) per period, so an
  alt-army can't multiply mat throughput while normal alt play (XP, gear, cosmetics) stays
  unpunished. This targets the inflation risk (Risk #3) precisely. Requires an account-scoped
  economy counter (account DB) alongside per-character participation state.

---

## 14. Mastery Trees — Combat Expression (design §14, issue #24)

> Heading kept at **§14** to match every existing `§14`/mastery cross-reference (§5 row 14,
> §6 Slice 6, `core/mastery/`, issue `07-mastery-adapter.md`). This section is the combat-expression
> layer of Mastery; the §6/Slice-6 dual-key (`MasteryEffectiveness`) and the gathering/craft consumer
> already shipped — this extends Mastery with a **combat** consumer built on the §7.9 effect model.

### 14.1 Shape

Mastery is a lattice of **5 damage schools × 3 trees**. Each (school, tree) cell is one or more
**procs**. The schools (issue #24): `Fire, Nature, Shadow, Frost, Physical` (a subset of `BrandId`;
`Arcane`/`Holy` are extension slots, no trees yet).

| Tree | Expression | Mastery tunes | Governing cap (§7.9) |
|---|---|---|---|
| **Def** | windowed proc | ppm / duration / magnitude (+reach if AoE) | `MaxPersonalMul` (personal) / `MaxRaidMul` (raid-wide) |
| **Off** | windowed proc | ppm / duration / magnitude (+reach if area/cleave) | `MaxRaidMul` + catalyst DR (Slice 4) |
| **Support** | **sustained aura** | **magnitude + reach** (constant uptime) | `MaxRaidMul` (utility) / `MaxMitigation`+DR (resist) |

### 14.2 Core principle — windowed procs vs sustained auras

The thing the design forbids is a **flat passive `+damage%`**. Two expression modes deliver power
without one:

- **Def / Off = proc-windows.** Each is a proc that opens a bounded window (buff, debuff, mitigation,
  §7.9 transform). **Mastery raises *upkeep*** — how reliably you keep the windows up, **never a flat
  magnitude** — under the windowed-uptime contract (§14.3): `uptime = Σ window / elapsed`, asserted
  strictly `< 1.0` at all mastery levels. A maintain-through-active-play loop, not a buff-bar slot.
- **Support = sustained auras.** Support buffs (resistances, raid utility, school-exposures) are the
  **aura pattern** — bounded team buffs that are *meant to be up* (like paladin auras / totems).
  Constant uptime is intended, so the §14.3 uptime asymptote does **not** apply to Support; instead
  **mastery scales magnitude (stronger buff) and reach (more allies / bigger radius)** — Support cells
  expose only those two §14.10 axes (no ppm/duration). This is still not a flat `+damage%`: magnitude
  stays bounded by `MaxProcMagnitude` (≤ the §7.9 cap) + catalyst DR, and the situational (SM/SE)
  ones stay school-gated, so a permanent Support buff is desirable, never mandatory.

> **Magnitude ceiling for sustained raid buffs:** because a Support aura is *permanent*, even a
> bounded raid-wide magnitude is strong — sustained raid cells should carry a conservative magnitude
> ceiling (per-cell magnitude ceilings are a noted config refinement; today `MaxProcMagnitude` is
> global).

### 14.3 Two new balance rails (added by this section)

1. **Uptime-asymptote cap.** Upkeep gain from mastery has **diminishing returns toward a ceiling
   `< 1.0`** — max mastery can *approach* but never *reach* permanent uptime. Without this rail a
   high-upkeep proc degenerates back into the flat passive §1/§7.9 forbids. This is the load-bearing
   invariant of the whole layer.
2. **PPM normalization.** Proc rate is **procs-per-minute** (real-time; weapon-speed-normalized for
   melee), **not** flat per-action chance. Otherwise a fast-auto-attacking melee gets vastly more
   proc opportunities than a slow caster at equal mastery — pure class imbalance. PPM decouples
   upkeep from action density (the standard WotLK fix).

### 14.4 The lattice (issue #24 content, tagged by mechanic type)

Mechanic tags: **PW** = proc-window (buff/debuff), **MT** = §7.9 mechanic-transform, **SM** =
situational mitigation (school-matched, DR'd), **SE** = situational exposure (active only vs the
matching invasion school — replaces flat counter-school "+dmg %").

| School | Def | Off | Support |
|---|---|---|---|
| **Fire** | fire AoE proc `PW` | fire damage proc `PW` | flame aura `PW` · fire resistance `SM` |
| **Nature** | HoT proc `PW`/`MT` | poison cloud proc `PW` | raid-heal proc `PW` · nature resistance `SM` |
| **Shadow** | life-steal proc `PW` | shadow volley proc `PW` | shadow-exposure vs Nature `SE` · shadow resistance `SM` |
| **Frost** | damage-reduction proc `PW` | Frost Nova proc `PW` | frost-exposure vs Fire `SE` · frost resistance `SM` |
| **Physical** | evasion proc `PW` | cleave proc `PW` | physical mitigation `SM` (armor-like, DR'd) |

- **`SE` (was "+dmg % vs X")**: a *windowed exposure* you proc onto a target, not a standing aura,
  and full-value only inside content themed to the relevant school — so it's desirable, never the
  mandatory hard-counter that flat counter-school % would create in fixed-school PvE.
- **`SM` resistances + physical mitigation**: one coherent axis — a capped, DR'd, **school-matched**
  defensive window. Full value vs matching-school invasion content, reduced/inert otherwise.

### 14.5 Respec

Tree respec consumes an **expensive token** = the §7.9 loadout-change friction (no free instant
re-spec). Friction cost is computed in core; the adapter charges it.

### 14.6 Enemy-side mastery

Invasion **elites carry tree procs; bosses are at max mastery**. Their procs run through the **same
caps and the same §2.1 pipeline** (downward scaling first, mastery procs on top) — so an elite never
becomes unpredictably spiky beyond `MaxRaidMul`/`MaxMitigation`. *(Open: see §14.8.)*

### 14.7 Pure model & invariants (test contract — written first, red)

```cpp
enum class MasteryTree : uint8_t { Defensive, Offensive, Support };

struct ProcCell {                 // one (school, tree) entry, resolved from config
    EffectKind kind;              // PW / MT mapped onto §7.9 EffectKind (+ SM/SE flags)
    double     ppm;               // procs-per-minute at this mastery (PRE-normalization input)
    uint32_t   windowDurationMs;
    bool       schoolMatched;     // SM/SE: full value only vs matching invasion school
};

// Upkeep (expected uptime) from mastery — DR toward a ceiling < 1.0.
double MasteryUpkeep(uint8_t masteryLevel, ProcCell const&, IBrandingConfig const&);

// PPM → expected procs given real elapsed time + (melee) weapon speed; NOT per-action.
double ExpectedProcs(double ppm, uint32_t elapsedMs, double weaponSpeedS, IBrandingConfig const&);
```

**Invariants (tests):**
- **Uptime asymptote**: `MasteryUpkeep(level, ...) < cfg.MaxUptime` for *all* levels, and
  `MaxUptime < 1.0` (`Mastery_Upkeep_NeverReachesPermanent`).
- **Monotonic upkeep**: non-decreasing in `masteryLevel`, with diminishing increments
  (`Mastery_Upkeep_DiminishingReturns`).
- **PPM decouples density**: a fast and a slow attacker at equal `ppm` reach upkeep within tolerance
  over equal real time (`Mastery_PPM_DensityIndependent`).
- **Raid cap holds**: any raid-wide cell still obeys `RaidMultiplier ≤ MaxRaidMul` + catalyst DR
  (reuses §7.9 / Slice 4 invariants).
- **School-matched gating**: `SM`/`SE` cells yield full value only when `schoolMatched`, reduced/0
  otherwise (`Mastery_SchoolMatched_SituationalOnly`).
- **Dual-key (§14/§6)**: account-unlock-only and char-level-only both ⇒ 0 (existing
  `MasteryEffectiveness` tests); combined scales upkeep.

### 14.9 Catalyst DR bucketing — per (school × tree), not per school

The Slice-4 catalyst DR (§7.9 / §9: 1st full, 2nd reduced, 3rd+ heavy) originally bucketed by
**role**. With the lattice, the DR bucket key is **`(school, tree)`** — the catalyst identity of a
specialist is *which cell of the lattice they run*, which is more precise than role and captures the
same "redundant specialist" intent (Def≈survivability, Off≈damage, Support≈utility).

**Rule:** DR counts only specialists sharing the **same `(school, tree)`**. So a raid fielding **one
Fire-Def + one Fire-Off + one Fire-Support** has three *independent* rank-1 buckets — **all three
hit full effect, no DR** — because they are complementary, not redundant. DR bites only when the
*same* cell repeats (a second Fire-Off is rank 2, a third is rank 3+). This rewards spreading the
lattice across a raid and only penalises stacking the identical proc.

```cpp
struct CatalystKey { BrandId school; MasteryTree tree; };   // the DR bucket identity
bool    SameCatalystBucket(CatalystKey const& a, CatalystKey const& b);   // both must match
// 1-based rank of roster[index] among PRIOR entries sharing its bucket (adapter passes a
// deterministically ordered, e.g. GUID-sorted, roster). Feeds CatalystStackWeight / RaidCatalystMultiplier.
uint8_t CatalystRankInBucket(CatalystKey const* roster, size_t count, size_t index);
```

**Invariants (tests):**
- Distinct `(school, tree)` keys are independent: one Fire-Def + one Fire-Off + one Fire-Support ⇒
  every rank == 1 ⇒ every `RaidCatalystMultiplier` == full (`CatalystDR_PerTree_ComplementaryNoDr`).
- Same key repeats ⇒ rank increments (1, 2, 3…) ⇒ DR applies (`CatalystDR_PerTree_RedundantStacks`).
- Same tree, different school ⇒ independent buckets (rank 1 each). Same school, different tree ⇒
  independent buckets (rank 1 each).
- Risk #6 (DR evasion) holds: rank counts *presence in the bucket*, so brand/tree rotation can't dodge
  DR for a genuinely-redundant cell.

### 14.10 Per-cell player tuning — a budget across a per-cell axis set (point-buy)

Within each (school, tree) cell a character **redistributes** how their proc expresses across a menu
of axes: **ppm** (how often — the lever for instant attacks), **duration** (how long the window
lasts), **magnitude** (how strong each proc is), and **reach** (breadth). This is the per-cell
expression-customization knob (the §7.9 loadout idea, made granular).

**Reach is one axis with two tooltips.** "Bigger AoE radius" and "cleave hits more targets" are the
*same* underlying breadth axis — only the presentation differs (yards for an area proc, target count
for a cleave). Core treats `reach` as one normalized value within a configured envelope; the
adapter/lattice renders it per-cell. Adding "count" did not add an axis.

**Per-cell axis set — the complexity governor.** Not every cell exposes every axis: reach only
applies to *area/cleave* procs (Fire AoE, poison cloud, raid-heal, flame aura, Physical cleave); a
single-target lifesteal or a personal mitigation has none. Each cell declares an **applicable-axis
mask**, and the budget divides only among the axes that cell exposes. So adding an axis is a one-line
config change with **zero new balance risk** (the budget+caps framework bounds any allocation), and
players only ever see the axes their cell actually has — a single-target cell shows 3 knobs, an
area/cleave cell shows 4.

**Point-buy, not a continuous slider** *(decided)*. The player spends discrete points across the
applicable axes (talent-tree feel: legible builds, exhaustively testable, native to the 3.3.5a mental
model). The pure resolver is the continuous general case; the adapter only ever feeds it **quantized**
shares from integer point spends. Respec = refund points for the expensive token (§14.5 / §7.9).

**It is a fixed budget — favoring one axis costs the others.** A free "max everything" would defeat
the §7.9/§14 caps, so the allocations draw from one mastery budget `b = level / (level +
UpkeepHalfLevel)` (the saturating-below-1 shape of §14.2). With shares normalized over the applicable
axes, their "fill fractions" sum to exactly `b (< 1)` — so a player picks **burst** (high magnitude,
low uptime), **sustained** (high uptime), **wide** (more range), or a blend, never all maxed at once.

```cpp
enum class ProcAxis : uint8_t { Ppm = 0, Duration, Magnitude, Reach, COUNT };  // Reach = AoE radius OR cleave count
constexpr uint32_t AxisBit(ProcAxis a);   // applicable-axis mask is an OR of these

struct TreeAllocation { double share[ProcAxis::COUNT]; };  // relative weights (>= 0) per axis
struct ResolvedCell   { double ppm; uint32_t windowDurationMs; double magnitude; double reach; };

// Resolve a player's allocation at a mastery level into concrete proc params, dividing the budget b
// only among the axes in `applicableAxes`. Shares normalized over applicable axes (all-zero -> even
// split); each applicable axis = Min + (Max-Min) * (normalizedShare * b); NON-applicable axes resolve
// to their Min (inherent baseline; magnitude floor 1.0). Every axis stays within its config bound,
// applicable fills sum to b, magnitude bounded by MaxProcMagnitude (lattice sets <= MaxRaidMul /
// MaxPersonalMul so §7.9 subsumes it). Realized uptime (ppm x duration) still clamped by MaxUptime.
ResolvedCell ResolveTreeCell(TreeAllocation const& alloc, uint32_t applicableAxes,
    uint8_t masteryLevel, IMasteryTreeConfig const& cfg);
```

**The knob is module configuration.** The per-axis bounds (and the upkeep/enemy dials) live in
`mod_branding.conf` under `Branding.Mastery.Tree.*` (`MinPpm`/`MaxPpm`, `MinWindowMs`/`MaxWindowMs`,
`MaxProcMagnitude`, `MinReach`/`MaxReach`, `MaxUptime`, `UpkeepHalfLevel`, `OffSchoolFactor`,
`MaxEnemyMul`). Core stays pure; the production `MasteryConfig` adapter snapshots them via
`sConfigMgr` and is injected as `IMasteryTreeConfig`. Admins retune the envelopes without a recompile.

**Invariants (tests):**
- **Conservation / no free lunch**: applicable fill fractions sum to `b`; no two axes both reach
  their per-axis max (`TreeTuning_BudgetConserved_NoMaxAllAxes`).
- **Per-cell axis mask**: a non-applicable axis resolves to its Min and consumes no budget, so a
  3-axis cell concentrates the same `b` over 3 axes (`TreeTuning_NonApplicableAxisExcludedFromBudget`).
- **Trade-off direction**: all-into-one-axis raises it at the cost of the others (`TreeTuning_FavorsOneAxisAtCostOfOthers`).
- **Caps hold for every allocation/mask**: each axis within `[Min,Max]`, `magnitude ∈ [1, MaxProcMagnitude]`,
  realized uptime `< MaxUptime` (`TreeTuning_AllAllocationsRespectCaps`).
- **Normalization**: all-zero/negative shares → even split over applicable axes (`TreeTuning_DegenerateSharesNormalized`).
- **Monotone in mastery**: a fixed allocation at higher level resolves to `>=` on each applicable axis (`TreeTuning_EnvelopeGrowsWithMastery`).

### 14.11 Mastery × talents / dual-spec — earned vs allocated

A character's role (hence which tree expression fits) is **spec-dependent** for hybrids (Prot/Ret
paladin, Feral/Resto druid, …), and WotLK lets them swap specs freely via Dual Talent Specialization.
The system must never punish using that core feature. It cracks by splitting two layers *(decided)*:

- **Earned** — mastery level/XP per school + account Knowledge (§1 anti-P2W progression). **Shared
  across specs, never reset by a talent change.** You don't lose your Nature investment by respeccing.
- **Allocated** — the loadout: tree choice (Def/Off/Support) + the §14.10 point split. This is stored
  **per talent-spec slot**, exactly as WotLK already stores dual-spec talents/glyphs/action bars.

Resulting behaviour:
- **Dual-spec switch auto-swaps the mastery loadout — free, no token** (it's a saved set, not a
  respec). The Prot loadout (Defensive-heavy) and Ret loadout (Offensive-heavy) both just exist.
- **Role / expression resolves live** from the active spec, so §7.9 role-asymmetry (tank spike vs dps
  restraint vs healer transform) flips automatically — same earned level, different expression, no loss.
- **The expensive token applies only to re-allocating points within a loadout**, never to switching specs.
- **Talent retrain that changes a slot's detected role**: keep earned progression untouched, keep the
  loadout but flag it for review (optionally one free re-allocation on role change). Never auto-wipe.

> **Placement:** the earned layer is the §6/Slice-6 `MasteryMgr` progression (shared). The per-spec
> loadout (selection + persistence keyed by spec slot) is **adapter/persistence (deferred)** — it
> reads the active talent group from the player and swaps the cached loadout on spec change. The pure
> core only validates a loadout and resolves it (§14.10); it never reads spec.

> **Lattice content (pure core, first cut).** `LatticeCell(school, tree)` encodes the §14.4 table as
> the design ruleset: each authored cell's `EffectKind`, situational (SM/SE) flag, **sustained flag**
> (Support = sustained aura; Def/Off = windowed), and §14.10 applicable-axis mask (windowed cells get
> ppm/duration/magnitude +Reach for area/cleave; Support cells get **magnitude + reach only**). Off
> cells are `RaidWindow`, Support cells are situational + sustained, unauthored schools (Arcane/Holy)
> return a neutral default. Multi-archetype cells are
> represented by their primary archetype; secondary archetypes + concrete spell ids / per-cell
> envelopes are the next (data/config) expansion. 6 tests.

> **Implemented (pure core).** `core/mastery/MasteryTrees.{h,cpp}` — `MasteryUpkeep` (dual-key gate
> + saturating-hyperbola upkeep with the §14.3 #1 sub-1.0 asymptote + SM/SE context gating) and
> `ExpectedProcs` (§14.3 #2 PPM normalization, weapon-speed-cancelling). 6 tests green
> (`tests/mastery/MasteryTreesTest.cpp`), full core suite 149/149, codestyle + core-purity clean.
> **Deferred:** the lattice content (per-(school,tree) `ProcCell` values) as config/data, the
> account-unlock/char-level persistence + adapter consumer for the combat layer (extends the §6
> `MasteryMgr`). The §14.8 enemy-side composition is resolved + implemented (`EnemyMasteryMultiplier`).

### 14.8 Enemy-side cap composition (resolved)

**Decision: a separate NPC ceiling `MaxEnemyMul`, applied multiplicatively *after* §2.2 encounter
scaling, with a group-size-invariant multiplier.** Rationale:

- **Separate cap, not the player caps.** Enemy procs threaten *players* (incoming damage / enemy
  survivability) — a different risk axis than player raid buffs. Reusing `MaxRaidMul` (tuned for
  "desirable, not mandatory" *player* buffs) would conflate two unrelated tuning goals. Enemy spikes
  get their own dial.
- **Spikes are mechanics, not gear checks.** `MaxEnemyMul < MaxPersonalMul` (asserted) — an elite's
  proc is a *visible window to react to*, never a one-shot. "Boss at max mastery" means windows are
  frequent/sustained (high upkeep on the §14.2 curve), **not** bigger per-proc numbers.
- **Composition order (extends §2.1):** `EncounterScale (§2.2)` sets the fair baseline for the group,
  then the enemy mastery multiplier (`≤ MaxEnemyMul`) rides on top — same scaling-then-branding
  discipline as the player side.
- **Group-size invariance (protects §2.2 completability / Risk #4):** the multiplier is a function of
  mastery level only, **not** group size. A 5-man-scaled elite and a 40-man-scaled elite see the
  *same* proc multiplier; only the already-scaled baseline differs. So enemy mastery never reaches
  down and breaks small-group completability — it is a bounded *fraction*, never a flat addition.

```cpp
// Enemy-side magnitude: 1.0 (level 0) .. asymptote below MaxEnemyMul. Monotonic, never < 1.0
// (mastery never makes an enemy weaker -- mirror of "a brand never hurts the raid"), group-invariant.
double EnemyMasteryMultiplier(uint8_t masteryLevel, IMasteryTreeConfig const& cfg);
```

**Invariants (fixture tests):**
- `EnemyMasteryMultiplier(level, cfg) <= cfg.MaxEnemyMul` for all levels (`EnemyMastery_BoundedByCeiling`).
- `>= 1.0`, monotonic non-decreasing in level (`EnemyMastery_NeverWeakensMonotonic`).
- `cfg.MaxEnemyMul() < eff.MaxPersonalMul()` — spikes are mechanics, not one-shots (`EnemyMastery_BelowPlayerFantasy`).
- Group-invariant composition: same multiplier applied to a 5-man-scaled and 40-man-scaled baseline
  preserves the completability ordering (`EnemyMastery_GroupSizeInvariant_FractionNotFlat`).

---

## 11. Determinism & Project-Convention Compliance

- **No `std::rand` / `<random>`** in core; inject `IRng` (production impl wraps project
  `Random.h` helpers — `urand`, `rand_chance`, etc. — in the adapter, never in core).
- **No wall-clock** in core; inject `IClock` (production wraps server time).
- **No global config** in core; inject `IBrandingConfig` (production wraps `sConfigMgr`).
- Adapters use project conventions: `LOG_INFO("module.branding", ...)`, `Acore::StringFormat`,
  `PreparedStatement` + async query path, typed helpers (`IsPlayer()`, …), `EventMap`/`TaskScheduler`
  for timed work, `Acore::` namespace.
- Linters before "done": `apps/codestyle/codestyle-cpp.py`, `apps/codestyle/codestyle-sql.py`.

---

## 12. Open Questions (resolve before/while building each slice)

1. **Brand set** — final enum list? (doc names Fire/Frost/Nature/Shadow; Arcane/Holy/Physical assumed.)
2. **MaxLevel & curve shape** — what proficiency cap and curve feel right (linear vs steep)?
3. **DR window** — soft cap, floor, and decay window seconds (gameplay tuning).
4. **Active brand** — can a character switch active brand freely, or is it bound to allegiance (§12)?
5. **Knowledge unlock** — how is a brand first unlocked account-wide (quest, economy cost, drop)?
6. **Effect magnitude caps** *(resolved: `MaxPersonalMul` = 3.0–4.0, `MaxRaidMul` = 2.0; §7.9)* —
   remaining: per-(brand,role) `EffectProfile` window/cooldown values, and the proficiency levels at
   which higher proc archetypes unlock in the loadout (§7.9 player-selected proc loadout).
7. **Per-brand mechanic transforms** — concrete spell-level behaviors for each (brand, role) healer
   transform and tank spike (e.g. Fire overheal→shield conversion ratio, HoT-spread radius/targets).
8. **Group-size per-capita reward policy** (§2.2) — should per-player reward be flat across group
   sizes, favor larger raids, or favor smaller groups? Decides zerg-vs-split incentives. Also: the
   exact encounter-difficulty curve so a 5-man MC is *hard but beatable*, not trivial or impossible.
9. **Alt-reward mechanic** — some private servers boost kill/quest XP per max-level alt on the
   account. **Recommendation: do NOT** use that here — it accelerates the baseline track and makes
   alts skip the discovery/profession/event content that is this server's identity (and it fights
   the §8.5 balance gate, Risk #2). Prefer **catch-up + account-layer rewards**: a one-time level
   *floor* for subsequent alts (skip early tedium, then normal rates) plus account perks (faster
   Brand Knowledge §6, vault capacity §13, Mastery progress §14). Brand proficiency stays
   per-character/earned (§6/§14), so a rushed alt is a leveled shell, not power. If an XP bonus is
   still wanted: scope to `QuestRate`/`KillRate` only (never discovery/event, §10.1), cap it, and
   add a test that §8.5 holds at the max bonus.

---

## 19. SLICE 8 SPEC — Client Addon Protocol & UI

The server computes every player-facing number (§9.6: *"the client overlay/addon renders it; the
server computes and broadcasts the number"*). This slice adds the **transport** that carries those
numbers to a WotLK 3.3.5a client addon, and the addon itself. The build target is 3.3.5a, which has
**no Eluna and no AIO** in this server — so the transport is the **native addon message channel**.

### 19.1 Transport (no Eluna) — server-push driven

A single addon-message prefix, **`BRND`**, carries all server→client traffic. Payloads are short
tab-delimited ASCII (`CHAT_MSG_ADDON` bodies are capped at 255 bytes — see `ChatHandler.cpp` length
guard — so every message is a single small frame). The module builds a `CHAT_MSG_ADDON` /
`LANG_ADDON` packet with `Chat::BuildChatPacket(...)`, body prefixed `BRND\t...`, and sends it to a
player's session.

**Why push-only.** On 3.3.5a there is no reliable *client→server* addon hook for a solo player:
`CHAT_MSG_WHISPER` is delivered straight to the recipient (`ChatHandler.cpp` whisper case) and never
calls `OnPlayerCanUseChat`; the `OnPlayerCanUseChat` hook only fires for SAY/CHANNEL/PARTY/GUILD; and
the native `AddonChannelCommandHandler` relay runs the body as a real chat command, which is
RBAC-gated and so needs a player-seeded permission. Rather than depend on a group/guild/channel or an
`rbac_default_permissions` change, the addon is a **pure renderer** and the server **pushes** state on
every event that can change it. The periodic re-push *is* the live refresh — functionally the
"push + poll" the design wanted, with the poll replaced by a server-side cadence the client can't miss.

The server pushes:

- **on login** — HELLO (protocol version + enabled), CHAR snapshot, the current zone's EVT, SCHED;
- **on zone change** (`OnPlayerUpdateZone`) — the new zone's EVT + SCHED;
- **on event start/stop** (driven from `EventScheduler`) — EVT broadcast to everyone in that zone;
- **on a throttled tick** (`Branding.Addon.PushIntervalSeconds`, default 5) — EVT (live containment)
  to players whose current zone has an active event, and a slower CHAR+SCHED refresh.

No new chat commands and no un-gating of the GM `.branding` commands: the addon is the player
interface, the existing `.branding` debug commands stay GM-only.

### 19.2 Pure protocol core (`src/core/addon/`, TDD)

The testable heart is the **wire codec** — encoding snapshot POD structs to frames and parsing
request lines. It is dependency-free (no AzerothCore includes); the adapter fills the snapshot
structs from live Mgrs and performs the actual send/receive.

```cpp
// Snapshot POD inputs (adapter fills from Mgrs; no AC types). Floats cross as permille (x1000).
struct EventFrame    { uint32_t zoneId; uint8_t type; uint16_t containmentPermille; bool active; };
struct ScheduleEntry { uint32_t zoneId; uint8_t type; uint8_t state; uint32_t secondsRemaining; };
struct YouFrame      { uint32_t points; uint8_t tier; };
struct CharSnapshot  { /* brands, masteries, loadout, item, allegiance */ };

std::string EncodeEvent(EventFrame const&);                                  // BRND\tEVT\t...
std::string EncodeSchedule(std::vector<ScheduleEntry> const&, bool& trunc);  // BRND\tSCH\t...
std::string EncodeYou(YouFrame const&);                                      // BRND\tYOU\t...
std::string EncodeChar(CharSnapshot const&);                                 // BRND\tCHAR\t...
std::string EncodeHello(HelloFrame const&);                                  // BRND\tHELLO\t<ver>\t<en>
```

Permille keeps the round-trip exact (equality, not epsilon). HELLO carries a **protocol version**
so a mismatched client is told to update rather than mis-parsing.

**Invariants (tests — `tests/addon/ProtocolTest.cpp`):**

- Round-trip `Decode*(Encode*(x)) == x` for every frame type.
- Every frame begins `BRND\t<KIND>\t`, contains no newline, length ≤ 255.
- List frames pack/round-trip N records and **truncate deterministically with a marker** (never a
  silent split) when they would exceed 255 bytes.
- `ParseRequest` is case-sensitive, returns `Unknown` for anything malformed, never throws (a
  hostile oversized body included).
- Decode of an unknown KIND / malformed body is a clean `false`, not a crash (forward-compat).

### 19.3 Server adapter (`src/AddonProtocolMgr.*`, `src/AddonScripts.cpp`)

- `AddonProtocolMgr` — gathers snapshots from the existing Mgrs (`EventMgr`, `EventScheduler`,
  `ProficiencyMgr`, `MasteryMgr`, `LoadoutMgr`, `ItemBrandingMgr`, `AllegianceMgr`), calls the pure
  `Encode*`, and sends frames via `Chat::BuildChatPacket` to a player session. **No raw `Player*`
  stored past the tick** — sends resolve the player at call time.
- `AddonScripts.cpp`:
  - `PlayerScript::OnPlayerLogin` — push HELLO + CHAR + the current zone's EVT + SCHED.
  - `PlayerScript::OnPlayerUpdateZone` — push the new zone's EVT + SCHED.
  - `WorldScript::OnUpdate` — throttled (config `Branding.Addon.PushIntervalSeconds`, default 5) EVT
    push to players whose current zone has an active event, plus a slower CHAR+SCHED refresh.
  - `WorldScript::OnAfterConfigLoad` — `AddonProtocolMgr::LoadConfig()`.
- `EventScheduler` calls `AddonProtocolMgr::BroadcastZoneEvent(zoneId)` on every start/stop
  transition; `EventScheduler::SnapshotSchedule()` exposes the per-zone state/countdown for SCHED.
- Config: `Branding.Addon.Enable` (master switch, default 0), `Branding.Addon.PushIntervalSeconds`.
- `ParseRequest` (§19.2) is kept and tested but currently unused by the adapter — it reserves the
  request grammar for a future client→server channel (group/guild/channel or a seeded RBAC perm).
- **No SQL** — every value is already persisted by the owning Mgr; this slice only transports it.

### 19.4 The addon (`modules/mod-branding/client-addon/Branding/`)

A single addon, two surfaces, one shared comms layer (`Comms.lua` mirrors the §19.2 codec):

- **Invasion Tracker** — a movable HUD frame: current zone's event type + live containment bar +
  your points/tier; plus a schedule list (per-zone next/active/cooldown countdown). Backed by the
  EVT push (live) and a SCHED poll on open.
- **Character panel** — tabbed: Brand proficiency (levels + effect strength), Mastery
  (unlock/level/bonus), Loadout (active brand + proc archetype), Item brand (step/level/intensity),
  Allegiance. Backed by the CHAR poll, refreshed on open and on login push.

Ships with `Branding.toc`, the Lua/XML, and an install README (copy to `Interface/AddOns/`). The
addon needs a live 3.3.5a client to verify, so it is **manual-verify**; the codec it depends on is
unit-tested server-side (§19.2) and the Lua parser mirrors the same `permille`/`\t`/`;`/`:` grammar.

### 19.5 Placement / Definition of Done

- §19.2 pure codec is TDD'd in `branding_core_tests` (no AC includes — CI purity guard applies).
- §19.3 adapter is compile-verified against game headers (as prior slices); link deferred to CI.
- §19.4 Lua is manual-verify in-client; grammar parity with §19.2 is the contract.
- No SQL; no raw entity pointers stored across ticks; linters clean.

---

## 13. Definition of Done (per slice)

- [ ] Spec section updated in this doc (and `docs/slices/` if detailed).
- [ ] Failing GoogleTests committed first (red), then green.
- [ ] `branding_core_tests` passes; core has no AzerothCore includes (CI guard).
- [ ] Adapter integration test (if applicable) passes.
- [ ] SQL idempotent + InnoDB; persistence round-trips.
- [ ] Linters clean (cpp + sql). cppcheck clean.
- [ ] No raw entity pointers stored across ticks.
