# #31 — One-shot item Etch (low-friction Branded-system on-ramp) (§7.9, server-only)

**Status:** implemented on `feat/branding-item-etch` — pure core tested (296/296), multi-slot + self-stack DR
wired; adapter/command/SQL/conf written (worldserver build unverified) ·
**Deps:** #05 (`ItemBrand`/`ResolvedItemEffectIntensity`), #04 (`CatalystStacking`), #02 (active loadout),
#07 (`MasteryMgr`) — all shipped · **Parallel-safe:** yes · **Size:** M

> **Companion to #27/#29.** #27/#29 are the *crafted* Branded-item economy (recipe → modest-stat BoA
> item → multi-week upgrade grind). This issue is a **third, deliberately weaker entry surface**: brand
> an item you *already own*, once, like an enchant. **Server-only — no `Spell.dbc`/MPQ patch** (contrast
> #29). It is the documented "no client patch" stepping stone into the system.

## Vocabulary (canonical — §16.1)
The action is **Etch** (verb); the result is an **Etched item**. This is kept distinct from the crafted
**"Branded item"** (BoA, upgradeable, §16.1) on purpose — Etching is the one-shot, BoP, rank-locked mark.
Command `.branding etch`; config `Branding.Etch.*`; player strings "Etch" / "Etched <item>".
The Etch **cost resource is Essence** — a new premium, **BoP** item (the §16.2-reserved third resource
type, now realized; distinct from BoE Material / BoA Fragment).

## Context
The only ways into Branded gear today are profession-gated and planned: a BoP recipe drop (#29) plus a
Material/Fragment grind (#27). That is a high commitment for a first taste. This adds a low-friction
on-ramp: at max player level a character with at least one unlocked school can **Etch** any eligible
item with their **active mastery**, getting one bounded proc on gear they already use — then graduate to
the crafted economy for anything more. **Near-zero new pure core**: it reuses `ItemBrand` (rank-0
intensity), `CanExpressBrand` (anti-P2W), the active `MasteryPlan`, and `CatalystStacking` (self-stack DR).

## Decisions (locked with owner, 2026-06-22)
1. **Scope = once per item, unlimited items.** Each item can be Etched exactly once — a permanent,
   non-replaceable mark (like an enchant that can't be overwritten). A character may Etch as many
   different items as they like over time.
2. **Brand = the active mastery at Etch time.** The item carries the character's active school. Its
   proc **expresses only while that school is the active mastery** *and* `CanExpressBrand` holds (current
   account's Knowledge, §7.3) — switch active school and the item goes dormant. Strictly stronger gate
   than the §7.3 Knowledge-only gate.
3. **Character-bound (BoP) on Etch.** Etching **soulbinds** the item (a BoE loses its tradeability).
   This is the commitment friction that gives "once" its weight, and it makes the path **strictly safer
   than BoA** crafted items (it cannot even travel account-wide).
4. **Fixed at Brand Rank 1, NOT upgradeable. No §05 stat scaling.** This is the containment for the #27
   "modest base, power from procs" lock: an Etched item gives only the rank-0 bounded proc and keeps its
   *own* base stats unchanged — no `ApplyItemUpgrade`, no `+StatBonusAtMaxRank`. Crafted Branded items
   remain the *only* path to higher Brand Ranks + the stat bonus (the multi-week ceiling). So Etching is
   something you **outgrow**, never a replacement for the economy. (Etching a raid-BiS base is allowed —
   the proc is bounded identically either way by §7.9; the differentiator is the upgrade ceiling, not the base.)
5. **Multi-item self-stacking DR = the raid catalyst curve, reused verbatim.** Multiple Etched items
   sharing the active `(school, tree)` cell form a **self-roster**; the adapter ranks them with
   `CatalystRankInBucket` and applies `CatalystStackWeight`/`RaidCatalystMultiplier` (§14.9: 1st full, 2nd
   reduced, 3rd+ heavy, bounded by `MaxRaidMul`). Distinct cells are independent rank-1 buckets — but
   active-mastery gating (decision 2) means in practice only your current cell's items express, so
   "unlimited items" buys **wardrobe flexibility, not stacked power**.
6. **Gated behind enrollment.** Requires ≥1 unlocked school (Knowledge). Slots into the §14.13 spine:
   *enroll → Etch a starter item → study → craft real Branded items → graduate.*
7. **Cost = expensive Essence, no recipe gate.** Etching consumes a large quantity of **Essence** — a
   NEW premium, **BoP** resource (§16.1/§16.2), so the cost is a strictly personal grind matched to the
   BoP result. **No learnable recipe** — `.branding etch` is open to anyone enrolled, so *planning*
   friction stays low; the *expense* is the gate. All knobs behind `Branding.Etch.*`
   (`EssenceItemId`, `EssenceCost`).
8. **Cost ordering is the primary balance lever** (not the rank-lock — see Risks). Price Etch to the
   ordering **initial Branded craft `<` Etch `<` fully-maxed Branded item**: above initial craft (the
   BiS-base premium must be paid for, or the modest-base crafted entry product is dead on arrival), below
   the max-out (the endgame max-rank proc + stat bonus stays the bigger investment). "Creating a Branded
   item" = the *full* lifecycle (craft + multi-week upgrade), not the initial craft. Numbers are #05/#27
   upgrade-curve-relative and config-tunable.

> **Identity note.** Decisions 7–8 move Etch from a *fresh-level on-ramp* to an **endgame-convenience**
> path: friction is now *cost* (premium Essence), not *planning*. The original "low friction/planning"
> goal still holds on the **access** axis (no recipe-drop hunt, no profession leveling) — you just need
> the mats. A stepping stone in *commitment/complexity*, not in *gold*.

## Pacing target (tuning contract, mirrors §14.13.6)
- **One Etch ≈ 2 weeks** of premium-source (raid/invasion/heroic) grinding for a single character — set
  `Branding.Etch.EssenceCost` against the Essence drop rate to hit this; pin via the #14 sim. Same ballpark
  as the §14.13.6 ~1-month school unlock, and **below** the multi-week guild max-out of a Branded item (#27),
  preserving decision 8's ordering.
- **Full proc-surface set ≈ ~6 months** — flat per-item cost × proc-surface slots (first cut: weapons +
  trinkets ≈ 3 items ≈ 6 weeks; the ~half-year figure is the eventual all-slots vision, ≈ #slots × 2 weeks).
- **A full set is a long-tail, not a treadmill:** the §14.9 combat self-stack DR (decision 5) means the
  2nd+ same-cell Etched item adds little combat value — so etching every slot is a **wardrobe-flexibility /
  completionist** goal (any gear setup keeps your proc), never a power requirement. Per-Etch cost stays
  **flat** (no escalating cost-DR) — the combat DR alone does the "why not stack everything" work.

## Scope (adapter + data; no new pure core)
1. **Essence resource** (`pending_db_world`, `item_template`) — new premium, **BoP** (`bonding = 1`)
   material in the §16.4 reserved band (`190002`, next after Material `190000` / Fragment `190001`),
   high `stackable`, reuse a fitting `displayid`. Premium-sourced (raid/invasion/heroic) — placement
   coordinates with #13/#25/#26. Map to `Branding.Etch.EssenceItemId`.
2. **Command** — `.branding etch` acting on the equipped/targeted item. Validate: max player level,
   ≥1 Knowledge, active mastery set, item slot eligible (carries a proc surface — weapon/trinket first
   cut), item not already Etched, **`EssenceCost` Essence held**. Refuse without consuming on any failure;
   on success consume the Essence and soulbind.
3. **Persistence** — reuse `item_branding` (#05, keyed by item GUID) with `step` pinned to 0 and a
   `non_upgradeable`/`source = etch` marker so the #05 upgrade flow refuses it. SQL in
   `pending_db_characters` (DELETE-before-INSERT, InnoDB, 4-space, trailing newline). Set BoP on Etch.
4. **Application** — `ItemEffectIntensity(step=0,…)` → the item's proc, gated by
   `ResolvedItemEffectIntensity` **and** active-mastery match (decision 2); aggregate same-cell items via
   the `CatalystRankInBucket` self-roster (decision 5). All through the existing effect layer (#03/#05).
5. **Bind** — soulbind on Etch; verify a previously-BoE item is non-tradeable afterward.

## Risks / notes
- **Cost ordering is the *primary* balance lever, not the rank-lock.** The rank-lock bounds the proc, but
  Etch can carry it on a **raid-BiS base** (crafted Branded items can't) — a strong package. Containment
  is the §-decision-8 Essence price (initial craft `<` Etch `<` max-out). Get this wrong and Etched BiS
  gear either trivialises the economy (too cheap) or is dead content (too dear). Pin it against the #05/#27
  curve and the #14 sim.
- **Self-stack DR** "unlimited items" introduces is covered by reusing the shipped catalyst curve; no
  unbounded path past `MaxRaidMul`.
- **New resource type (Essence)** — first realization of the §16.2-reserved third resource; it's an item
  entry consumed by the Etch adapter, **not** a `Resources { materials, fragments }` field (Etch bypasses
  `ResolveCraft`), so the pure economy core is untouched.
- **Slot eligibility** — armor without a natural proc trigger is out of first-cut scope; start with
  weapons/trinkets, expand by config if desired.

## Acceptance
- Standard DoD (incl. `codestyle-sql.py`). Manual verify: Etch a BoE item with `EssenceCost` Essence →
  Essence is consumed, item becomes BoP and procs your active school; an under-resourced attempt is refused
  without consuming; switching active school makes it dormant; Etching 3 same-cell items applies the
  catalyst DR (1st full, 2nd reduced, 3rd+ heavy); the item cannot be upgraded (#05 refuses) and cannot be
  re-Etched; a never-tradeable BoP item is the only outcome (no trade exploit). Essence is BoP (un-buyable,
  non-mailable). All gated by enrollment.

## Touch points
`src/ItemBranding*.*` (#05, extend), `src/BrandingCommandScript.cpp` (`etch` verb),
`pending_db_world` SQL (Essence `item_template`, entry `190002`), `pending_db_characters` SQL (etch
marker column + soulbind), `conf/mod_branding.conf.dist` (`Branding.Etch.*`). Reuses
`core/branding/catalyst/CatalystStacking`, `ItemBrand`, `CanExpressBrand`, `MasteryPlan` —
**no new `src/core/` logic expected.** Coordinate Essence sourcing with #13/#25/#26.

## Implemented (`feat/branding-item-etch`)
- **Pure core (TDD, verified):**
  - `ItemBrandState::etched`; `ApplyItemUpgrade` refuses an etched item (no-op, no consume) — rank-lock
    enforced in core. Tests `ItemBrand.EtchedItemRefusesUpgrade` + `EtchedItemProcsAtRankZeroAndGatedByAccess`.
  - `CatalystSelfStackMultiplier(count, cfg)` (decision 5) — reuses `CatalystStackWeight`; saturating, bounded
    by `MaxRaidMul`, monotonic in count, 1st source dominates. 5 tests (`CatalystSelfStack.*`).
  - Full standalone suite **296/296 green**.
- **Adapter (multi-slot):** `ItemBrandingMgr` tracks all Etch-eligible slots (main-hand, off-hand, ranged,
  both trinkets). `EtchSlot(player, slot)` validates enrollment → checks/consumes `EssenceCost` Essence →
  writes a rank-0 `etched` state → soulbinds the item. `AggregateEtchedIntensity` counts equipped
  expressible Etched items of the active school and combines them via `CatalystSelfStackMultiplier`
  (decisions 1 & 5 — "unlimited items = flexibility, not stacked power"). `EquippedIntensity` gains the
  active-school-match gate (decision 2). `LoadEquipped` loads every eligible slot at login.
- **Cache coherency:** `LoadEquipped` caches all eligible slots at login; an `OnPlayerEquip` hook caches an
  Etch-eligible item's brand state when equipped mid-session (shared `CacheBrandState`, no-op if cached / no
  row) — so the aggregate and gates stay correct without a relog.
- **Command/data/conf:** `.branding etch [mainhand|offhand|ranged|trinket1|trinket2]` (default main-hand),
  per-failure messaging; aggregate surfaced in `.branding info`. `item_branding` table + `etched` column;
  Essence item `190002` (BoP); `Branding.Etch.{Enable,EssenceItemId,EssenceCost}`. SQL + C++ codestyle clean.
- **Verification limit:** pure core is run-verified; the **adapter/command TUs are not compile-verified**
  (needs a worldserver CMake configure, not run). APIs used (`SetBinding`/`SetState`/`ITEM_CHANGED`, variadic
  `SendErrorMessage`, `LoadoutMgr::GetLoadout`, `CatalystMgr::Config`) were checked against the real headers.

**Deferred / limitations:**
- **Combat proc application** beyond the resolved intensity (turning `AggregateEtchedIntensity` into actual
  in-combat proc behaviour) rides on the effect-application layer (#03, still adapter-deferred per §7.9).

## ARCHITECTURE.md amendments (applied with this draft)
- **§16.1 glossary** — two new rows: **Etch** / *Etched item* (item GUID, BoP, rank-locked) and **Essence**
  (premium BoP Etch-only cost, `Branding.Etch.EssenceItemId`, adapter-consumed — no `Resources` field).
- **§16.2** — **Essence realized** (was reserved): the §7.9 Etch cost, a third resource *item entry* (not a
  `Resources` field), BoP.
- **§16.3 bind model** — Etching soulbinds the item (BoE → BoP), permanent + non-upgradeable; Essence is BoP.
- **§7.9** — new subsection (One-shot Etch): rank-0 proc only, active-mastery gated, **cost-ordering as the
  primary balance lever** (initial craft `<` Etch `<` max-out, paid in Essence), self-stack DR via the §14.9
  catalyst curve, no stat scaling; the deliberately-weaker, endgame-convenience sibling of the §05 upgrade path.
