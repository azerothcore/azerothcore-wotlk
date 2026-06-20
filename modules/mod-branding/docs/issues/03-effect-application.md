# #03 — Effect application layer (§7.9)

**Status:** open · **Deps:** #02 (active-brand/loadout) · **Parallel-safe:** after #02 · **Size:** L

## Context
The effect model is fully specified + tested in `core/effects/` (`PersonalMultiplier`,
`RaidMultiplier`, `WindowUptimeFraction`, `EffectProfile`, `IsPrestige`). Nothing applies it yet.
This is the genuinely adapter-heavy slice and the prerequisite for catalyst (#04) and item
branding (#05).

## Scope
- Define the per-(brand, role) `EffectProfile` table source (config/data): kind (PersonalSpike /
  RaidWindow / MechanicTransform), window/cooldown.
- Window scheduling: drive exposure/burst windows via `EventMap`/`TaskScheduler` (no ad-hoc tick
  counters). Respect `WindowUptimeFraction` < 1.0 (no passive uptime).
- Apply during a window:
  - **PersonalSpike** (tank-flavoured): `PersonalMultiplier` → survivability/outgoing via the same
    `UnitScript::Modify*Damage` plumbing used by scaling (compose: scaling first, branding on top —
    §2.1 ordering).
  - **RaidWindow**: `RaidMultiplier` (bounded, catalyst-DR'd — coordinate with #04).
  - **MechanicTransform** (healer): structural change (overheal→shield etc.) — start with one
    transform behind an `AuraScript`/heal hook; others follow.
- Resolve effect strength via `ProficiencyMgr` (level) + active brand (#02) + anti-P2W gate.

## Acceptance
- Standard DoD. New core only if new decisions arise (most logic exists). Adapter integration-tested
  where possible.
- Manual verify: a branded player shows a bounded, windowed effect (not always-on), inspectable via
  `.branding info`.

## Touch points
`src/Effect*.*` (new), `UnitScript` hooks, possibly `AuraScript`/heal hooks. Compose with
`ScalingMgr` ordering (§2.1). Large — consider splitting PersonalSpike / RaidWindow / Transform into
sub-PRs.
