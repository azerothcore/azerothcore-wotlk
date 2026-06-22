# #16 — Exotic school spell map (reuse table for #03)

> **Relation to GH #30** (concrete lattice content — spell IDs + per-cell envelopes/magnitude
> ceilings, §14.2/§14.4): this doc delivers the **spell-ID** half of #30 for the **exotic-school**
> subset (§7.10), projected on the §7.9 *role* axis (Tank/DPS/Support/Healer). It does **not** yet
> cover the classic-school §14.4 cells, the Def/Off/Support *tree* projection, or the per-cell
> envelopes / magnitude ceilings / reach rendering that #30 also requires. See "Remaining for #30" at
> the foot of this file.

**Purpose:** concrete, **verified 3.3.5a** spell IDs to reuse as the visual/mechanical shell for each
exotic school's per-role behaviour (§7.10). This is the authoring contract for the #03
effect-application adapter — per the §7.10 scope note, *reuse existing WotLK spell visuals rather than
authoring new ones*. The module only remaps **proc frequency / behaviour** onto these — never flat ±%
stats (§1, §7.9). All IDs below were verified live against the wowhead `/wotlk/` (WotLK Classic /
3.3.5a) branch.

**Reuse class legend:** `AURA` = area/self aura template · `PROC` = extra-attack / on-hit / on-tick
proc template · `MT` = mechanic-transform template (heal-jump, dispel, absorb, spread) · `FX` =
visual/cast effect only (mechanic comes from elsewhere). Role→`EffectKind`: Tank→PersonalSpike,
DPS/Support/Control→RaidWindow, Healer→MechanicTransform.

---

## Wind — tempest / motion
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | dodge/evasion spike | Evasion | `5277` | PROC/AURA | +50% dodge 15s — exact spike-window mechanic |
| Tank | (visual) | Cyclone | `33786` | FX | tornado vortex overlay for the spike |
| DPS | Windfury extra-attack proc | Windfury Attack | `25504` | PROC | *is* the extra-attack proc (flagged extra attack) |
| DPS | (driver) | Windfury Weapon | `8232` | AURA | weapon-enchant glow + proc package |
| Support | group haste window | Windfury Totem (passive) | `8515` | AURA | +16% melee haste, 30yd area aura |
| Support | (stronger) | Bloodlust | `2825` | AURA | +30% melee/spell haste, fixed window |
| Healer | spread HoT to 2nd ally | Wild Growth | `48438` | MT | burst HoT lands on nearby allies |
| Healer | (true jump) | Prayer of Mending | `33076` | MT | charge-based heal that relocates to a new ally |

## Lightning — chain arc
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | static shield (reflect/absorb) | Lightning Shield | `324` / `49278` | AURA/PROC | orbiting charges zap attackers; reactive spike |
| DPS | arc to nearby (single→cleave) | Chain Lightning | `421` / `25442` | PROC | canonical arc that leaps target-to-target |
| DPS | (NPC art) | Arc Lightning | `52921` | FX | Halls of Lightning boss arc; non-player look |
| Support | "overload" bonus chain target | Lightning Overload | `30679` | PROC | free second Lightning Bolt/Chain Lightning |
| Healer | overheal jumps to lowest ally | Chain Heal | `1064` | MT | healing arcs ally-to-ally |

## Blood — lifedrain / execute
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | leech window (dmg→HP) | Death Strike | `49998` | PROC | heals based on recent damage taken |
| Tank | (visible CD) | Vampiric Blood | `55233` | AURA | crimson self-buff, boosts incoming heal/HP |
| DPS | execute ramps as HP drops | Drain Soul | `47855` | PROC | 4× damage under 25% HP — literal execute ramp |
| DPS | (proc hit FX) | Death Coil | `47541` | FX | shadowy-red finisher projectile |
| Support | bounded group leech | Vampiric Embrace | `15286` | AURA | converts a bounded fraction of damage→group heal |
| Support | (pet aura) | Blood Pact | `6307` | AURA | 30yd party blood aura, themed red |
| Healer | overkill→raid heal (dmg→heal) | Soul Leech | `30294` | MT | procs a heal off offensive damage |
| Healer | (sacrifice variant) | Death Pact | `48743` | MT | consume→heal transform |

## Void — phase / gravity
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | blink/displacement phase | Blink | `1953` | FX/AURA | instant teleport, frees stun/root ~1s |
| Tank | (magic phase-out) | Cloak of Shadows | `31224` | AURA | -90% spell hit vs caster — phase out of magic |
| DPS | phase proc / armor-ignore burst | Cloak of Shadows | `31224` | PROC | shadow-phase bypass visual |
| Support | gravity well pull / CDR | Death Grip | `49576` | MT | yanks target to caster — gravity-well control |
| Support | (summoned look) | Black Hole | `46282` / `62169` | FX | singularity / Algalon black-hole area FX |
| Healer | dispel-on-heal | Cleanse / Dispel Magic | `4987` / `527` | MT | removes a magic effect alongside the heal |

## Stone — earth / immovability
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | stoneform armor/HP spike | Stoneform | `20594` | AURA | turn-to-stone, +armor, poison/disease/bleed immune |
| Tank | (totem alt) | Stoneskin Totem | `8155` | AURA | earthen totem, reduces physical dmg taken |
| DPS | tremor/slow cadence | Earthbind Totem | `2484` | PROC | pulsing roots, periodic 50% slow |
| DPS | (tremor FX) | Tremor Totem | `8143` | FX | ground-shaking pulse |
| Support | group dmg-taken reduction | Stoneskin Totem | `8155` | AURA | party earthen aura, reduces physical dmg |
| Healer | overheal→earthen barrier | Earth Shield | `974` | MT | orbiting earthen shield reacts to damage |
| Healer | (true absorb) | Stoneclaw Totem (+glyph) | `5730` / `63929` | MT | glyphed → flat damage-absorb shield |

> **Gap:** no clean 3.3.5a *player-castable* earth interrupt/stun proc. Earth Shock (`8045`) does **not**
> interrupt in 3.3.5a (interrupt removed in 3.2.0) — do not use it for the interrupt role. Use the slow
> (Earthbind) cadence instead, or an NPC stun if a hard interrupt is wanted.

## Venom — contagion / DoT
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | contagion aura (stacking weaken) | Necrotic Plague | `70337` | PROC/AURA | NPC disease that *jumps to a nearby unit* |
| Tank | (amplifier) | Crypt Fever | `49632` | AURA | DK disease-amplifier, green plague flavour |
| DPS | DoT-spread cleave | Pestilence | `50842` | MT | copies caster's diseases to enemies within 10yd |
| DPS | (passive proc) | Wandering Plague | `49655` | PROC | diseases deal AoE to enemies within 8yd on tick |
| Support | brittle (faster periodic ticks) | Ebon Plague | `51735` | AURA | target takes more from magic/periodic effects |
| Healer | cleanse-on-heal | Cleanse / Cleanse Spirit | `4987` / `51886` | MT | purge poison/disease alongside the heal |
| Healer | (over-time purge) | Abolish Disease | `552` | MT | periodic disease-cleanse over 12s |

## Chrono — time / rewind
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | anachronism (HP rewind FX) | Time Stop | `60074` | FX | "frozen instant" cast tell before the snapshot restore |
| Tank | (channel FX) | Temporal Rift | `49592` | FX | channeled temporal-field — pin then snap back |
| DPS | echo proc (repeat a beat later) | Mirror Image | `55342` | PROC/FX | duplicate caster acts again — literal echo |
| Support | bounded time-warp (haste+CDR) | Bloodlust / Heroism | `2825` / `32182` | AURA | canonical group haste window |
| Support | (warp FX layer) | Time Warp (Epoch) | `52766` | FX | arcane time-distortion screen effect (NPC) |
| Healer | "rewind" HoT echo | Riptide | `61301` | MT | instant heal + 15s lingering periodic |
| Healer | (minimal HoT) | Renew / Rejuvenation | `62333` / `48441` | MT | trailing periodic-heal stamp on a landed heal |

> **Excluded:** mage Time Warp (`80353`) is Cataclysm-era, **not** in 3.3.5a.

## Spirit — soul / ghostform / spectral
| Role | Behaviour | Spell | ID | Class | Why |
|---|---|---|---|---|---|
| Tank | ghost-walk (damage immunity) | Ice Block | `45438` | AURA | Immunity(All) — reskin to spectral fade |
| Tank | (lighter, mobile) | Cloak of Shadows | `31224` | AURA | -90% spell hit, no stealth break |
| DPS | soul-harvest on kill | Drain Soul | `1120` | PROC | shadow drain, creates Soul Shard on death |
| DPS | (spend payoff FX) | Soulshatter | `29858` | FX | soul-shard spectral pulse |
| Support | spectral veil (threat-drop) | Soulshatter | `29858` | MT | no-threat soul burst — direct threat reduction |
| Support | (stealth-assist) | Shadowmeld / Feign Death | `58984` / `5384` | MT | stealth + threat wipe / drop-combat |
| Healer | overheal→roaming healing wisp | Spirit of Redemption | `27795` / `27827` | MT | spectral healer form/model for the spawned wisp |
| Healer | (wisp model) | Wisp Spirit | `20585` | FX | floating-wisp ghost model for the healing orb |

---

## Notes for #03 wiring
- **Auras/procs reused as-is** (no new mechanic): Evasion, Windfury, Lightning Shield, Chain Lightning,
  Death Strike, Stoneform/Stoneskin, Earthbind, Bloodlust/Heroism, Blood Pact. These cover Tank spikes,
  DPS procs, and Support windows for most schools with **zero from-scratch authoring**.
- **Genuinely new transform hooks** (small set — implement one first, then fan out, per #16 scope):
  DoT-spread (Pestilence `50842` is the closest existing template), heal-jump (Chain Heal `1064` /
  Prayer of Mending `33076`), damage→heal (Soul Leech `30294`), overheal→absorb (Earth Shield `974` /
  Stoneclaw glyph `63929`), HP-rewind snapshot (no existing template — FX only via Time Stop `60074`).
- **NPC abilities** (Necrotic Plague, Black Hole, Time Stop/Warp, Arc Lightning) have no class
  restriction in DBC, so they are safe to reuse as flavour visuals without colliding with player
  spellbooks — prefer these where a non-player-looking effect is wanted.
- All listed IDs are stable on the 3.3.5a / wowhead `wotlk` branch as of this research; re-verify any ID
  against the server's `spell_dbc` before wiring.

## Remaining for #30 (this doc is the exotic-school spell-ID slice)
#30 wants the full **§14.4 lattice content** as data/config. Still open:
1. **Classic-school cells** (the §14.4 table, lines 1034–1042): fire AoE / fire damage / flame aura,
   poison cloud / HoT / raid-heal, life-steal / shadow volley, damage-reduction / Frost Nova, evasion /
   cleave, arcane barrier / arcane explosion / int-mana aura, holy shield / holy nova / circle of
   healing — plus resistances/exposures (`SM`/`SE`). None mapped to spell IDs yet.
2. **Tree projection.** This doc keys on the §7.9 *role* (Tank/DPS/Support/Healer); the lattice keys on
   the *tree* (Def/Off/Support) with §14.4.1 multi-archetype Support secondaries. Re-project the role
   rows onto Def≈Tank-spike, Off≈DPS-proc, Support≈Support-window + the Healer transform.
3. **Per-cell envelopes** — Min/Max ppm, duration, magnitude, reach overrides per cell.
4. **Per-cell magnitude ceilings** — sustained raid buffs (flame aura, circle of healing, int-mana
   aura) carry a *conservative* ceiling (§14.2: `MaxProcMagnitude` is global today).
5. **Reach rendering** — AoE radius (yards) vs cleave target count, per cell, for the tooltip.
