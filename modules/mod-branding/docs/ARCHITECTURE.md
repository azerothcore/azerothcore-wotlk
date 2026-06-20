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
4. **Slice 4 — Catalyst stacking DR.** Small, sharp; consumes proficiency from Slice 1.
5. **Slice 5 — Exploration/Discovery + Allegiance + Economy** (§8): discovery XP + tier
   classification + economy resolution (pure), allegiance efficiency, and the XP-balance regression
   sim. World-spawned content (§8.4) is data, authored against the tier rules afterward.
6. **Slice 6 — Account vault + Mastery wiring** (mostly persistence + adapters).
7. **Slice 7 — Combat effect application + Item branding + Prestige cosmetics** (adapter-heavy).

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

Adapter (`ProficiencyPlayerScript`): load on `OnLogin` (async query → cache by `ObjectGuid`),
mutate the cached `ProficiencyState` when activity hooks fire (calling `ApplyActivity`), flush
on `OnLogout` / periodic save. **No raw `Player*` stored past the tick** — cache keyed by
`ObjectGuid`, resolved via `ObjectAccessor::FindPlayer`.

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

## 13. Definition of Done (per slice)

- [ ] Spec section updated in this doc (and `docs/slices/` if detailed).
- [ ] Failing GoogleTests committed first (red), then green.
- [ ] `branding_core_tests` passes; core has no AzerothCore includes (CI guard).
- [ ] Adapter integration test (if applicable) passes.
- [ ] SQL idempotent + InnoDB; persistence round-trips.
- [ ] Linters clean (cpp + sql). cppcheck clean.
- [ ] No raw entity pointers stored across ticks.
