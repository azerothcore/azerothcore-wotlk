# #30 — Classic-school spell map (§14.4 lattice content)

**Purpose:** concrete, **verified 3.3.5a** spell IDs to reuse as the visual/mechanical shell for each
of the seven classic schools' §14.4 mastery-lattice cells (Def / Off / Support, incl. the §14.4.1
multi-archetype Support secondaries). This delivers the **spell-ID** half of #30 for the classic
schools — the per-cell envelopes / magnitude ceilings / reach rendering remain (see foot). The module
remaps **proc frequency / behaviour** onto these — never flat ±% stats (§1, §7.9). All IDs verified
live against the wowhead `/wotlk/` (WotLK Classic / 3.3.5a) branch.

> **Companion:** `16-exotic-school-spell-map.md` covers the eight exotic schools (§7.10) on the §7.9
> *role* axis. Together the two docs cover the spell-ID deliverable of #30 for all 15 schools.

**Tag legend** (from §14.4): `PW` proc-window · `MT` mechanic-transform · `SM` situational mitigation
(school-matched, DR'd) · `SE` situational exposure (windowed, vs matching invasion school). `FX` =
visual/cast effect only. Tree→`EffectKind`: Def→PersonalSpike, Off→RaidWindow, Support→RaidWindow.

---

## Fire
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | fire AoE proc `PW` | Hellfire Effect | `11681` | NPC/proc | 10yd | self-centered Fire periodic — clean burst-tick template |
| Def | (alt) | Immolation Aura | `50589` (→`50590`) | player | 8yd | periodic-trigger self AoE fire aura |
| Off | fire damage proc `PW` | Fireball | `42833` | player | single | canonical single-target fire bolt |
| Off | (cleave) | Fire Nova Totem | `27623` | player | AoE | detonating fire burst for a cleave proc |
| Support 0 | fire resistance `SM` | Fire Resistance Totem | `25563` / `58739` | player | 30yd | party fire-resist aura (summon tagged Frost internally) |
| Support 1 | flame aura `PW` (sustained) | Totem of Wrath | `30706` | player | 40yd | party-wide constant buff aura, fire-totem visual |
| Support 1 | (true-Fire proc alt) | Flametongue Attack | `8024` | item/proc | single | genuine Fire-school on-hit proc (single-target) |

> **Flag:** no canonical Fire-school **party-wide constant** aura exists in 3.3.5a — resistance/totem
> buffs that read as fire are internally other schools. Pick Totem of Wrath/Flametongue Totem for the
> party-wide *shape*, or Flametongue Attack `8024` for a true Fire-school proc (single-target).
> Consecration `48819` is **Holy**, not Fire — do not use as a fire shell.

## Nature
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | HoT proc `PW`/`MT` | Rejuvenation | `48441` | player | single | canonical green HoT, ticks 3s/15s |
| Def | (heavier) | Regrowth | `48443` | player | single | instant + HoT over 21s |
| Off | poison cloud proc `PW` | Poison Cloud | `57061` | NPC | 5yd | true ground poison cloud, ticks 2s/8s |
| Off | (contagion alt) | Volatile Infection | `59228` | NPC | spread | infection that periodically triggers nature dmg |
| Support 0 | nature resistance `SM` | Nature Resistance Totem | `58749` | player | 30yd | +130 nature resist, party/raid |
| Support 1 | raid-heal `PW`/`MT` (sustained) | Tranquility | `48447` | player | 30yd | channeled raid AoE heal — "constant raid heal" |
| Support 1 | (smart HoT alt) | Wild Growth | `48438` | player | 15yd / 6 tgt | front-loaded smart raid HoT |

> **Flag:** Healing Stream Totem summon is `5394` (not `58758`, which is "Devour Flesh"). Entangling
> Roots max rank is `53308` (`49802` is "Maim").

## Shadow
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | life-steal proc `PW` | Death Coil | `47860` | player | single | shadow nuke that heals caster for dmg dealt |
| Def | (leech aura) | Vampiric Embrace | `15290` | player | 100yd | % shadow dmg → party heal |
| Off | shadow volley proc `PW` | Shadow Bolt Volley | `55850` | NPC | 50yd* | native shadow AoE/cleave (clamp the wide radius) |
| Off | (single) | Shadow Bolt | `686` | player | single | iconic single-target shadow bolt |
| Support 0 | shadow-exposure vs Nature `SE` | Curse of the Elements | `47865` | player | single | magic-resist↓ (Shadow+Nature) windowed debuff |
| Support 1 | shadow resistance `SM` | Shadow Resistance Aura | `48943` | player | 40yd | always-on party shadow-resist aura |
| Support 1 | (priest raid alt) | Prayer of Shadow Protection | `27683` | player | raid | raid shadow-resist buff |

> **Flag:** no standalone shadow-only "Shadow Vulnerability" debuff on the wotlk branch (`17800`/`17794`
> are "Shadow Mastery"). Curse of the Elements `47865` is the exposure shell. Curse of Shadow `17862`
> 404s. Death Coil is `47860` (warlock max rank).

## Frost
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | damage-reduction proc `PW` | Ice Barrier | `11426` | player | self | frost-shell absorb (438 base) |
| Def | (pure ward) | Frost Ward | `6143` | player | self | absorbs + reflects frost |
| Off | Frost Nova proc `PW` | Frost Nova | `122` | player | 10yd | instant frost AoE root — textbook burst |
| Off | (cone) | Cone of Cold | `42931` | player | 10yd cone | frontal frost burst + snare |
| Off | (channel) | Blizzard | `42208` | player | 8yd | sustained ground frost AoE |
| Support 0 | frost-exposure vs Fire `SE` | Winter's Chill | `12579` | player | single | frost debuff, +spell-crit-taken, 5-stack 15s |
| Support 1 | frost resistance `SM` | Frost Resistance Totem | `8181` | player | party | party frost resist, 5min |
| Support 1 | (aura alt) | Frost Resistance Aura | `48945` | player | 40yd | paladin party frost-resist aura (max rank) |

> **Flag:** no WotLK spell flatly increases *frost* damage taken — Winter's Chill (crit-vulnerability)
> is the closest in-school exposure shell. Paladin Frost Resistance Aura max rank is `48945` (`22588`
> is a speed bonus — do not use).

## Physical *(single-archetype Support)*
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | evasion proc `PW` | Evasion | `5277` | player | self | +50% dodge 15s — canonical dodge spike |
| Def | (parry) | Deterrence | `19263` | player | self | +100% parry + spell deflect, 5s |
| Off | cleave proc `PW` | Cleave | `845` | player | **N tgt** (mastery-scaled) | frontal extra-swing visual; reach = **target count**, base 2 → Max N |
| Off | (radius alt) | Whirlwind | `1680` | player | 8yd radius | 360° burst; reach scales by pack density, not count |
| Off | (radius alt) | Fan of Knives | `51723` | player | 8yd / all | rogue spinning cleave, no target cap |
| Support 0 | physical mitigation `SM` (only) | Devotion Aura | `465` | player | 40yd | party armor-style mitigation aura |
| Support 0 | (totem alt) | Stoneskin Totem | `8071` | player | party | melee-dmg-reduction totem aura |

> **Design — Off reach is a target *count*, not a radius.** The base spell is only the swing visual;
> the #03 adapter applies the cleave to *N* nearby targets itself (Cleave's hardcoded 2-target cap in
> 3.3.5a does **not** bind us). So this cell's **reach envelope = cleave target count**: mastery raises
> it from a base (2) toward a per-cell `MaxReach` ceiling (§14.2), rendered in the tooltip as "hits N
> targets" — the §14.4 cleave-count branch. This is preferred over Whirlwind/Fan of Knives because an
> integer count is a controlled, readable, anti-degenerate progression, whereas a radius scales with
> enemy packing rather than mastery. Keep the radius variants only where pack-density scaling is wanted.
>
> Physical is the lone single-archetype Support cell (the §14.4 table lists only physical mitigation).
> Sweeping Strikes `12328` redirects hits rather than self-cleaving — a worse shell than the picks above.

## Arcane
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | arcane barrier (absorb) `PW` | Mana Shield | `43020` | player | self | true-Arcane self-absorb aura (~1330) |
| Def | (small) | Mana Shield | `1463` | player | self | same mechanic, low rank (~120) |
| Off | arcane explosion proc `PW` | Arcane Explosion | `42921` | player | 10yd | canonical self-centered arcane AoE burst |
| Off | (channel) | Arcane Missiles | `42846` | player | single | periodic-trigger bolts — good freq-remap proc |
| Support 0 | arcane resistance `SM` | Arcane Resistance | `28770` | NPC/buff | self | dedicated arcane-resist grant (+35) |
| Support 1 | intellect/mana aura `PW` (sustained) | Arcane Brilliance | `43002` | player | 100yd | party-wide +60 Int, constant arcane buff |
| Support 1 | (mana alt) | Mana Spring Totem | `25570` | player | 30yd | sustained party mana regen (Nature totem) |

> **Flag:** no Paladin "Arcane Resistance Aura" exists in 3.3.5a (paladin auras are Fire/Frost/Shadow
> only) — use `28770`/`17175`. `20592` "Arcane Resistance" is a passive spell-hit-reducer, not a
> resistance grant — excluded. Ice Barrier `43039` is a stronger absorb but **Frost** school.

## Holy
| Cell | Archetype | Spell | ID | Src | Reach | Why |
|---|---|---|---|---|---|---|
| Def | holy shield (absorb) `PW` | Power Word: Shield | `48066` | player | single | canonical holy absorb bubble (~2230) |
| Def | (block reflect) | Holy Shield | `53601` | player | self | paladin block buff, reflects holy on block |
| Def | (reduction) | Divine Protection | `498` | player | self | 50% dmg reduction, 12s |
| Off | holy nova proc `PW` | Holy Nova | `15237` | player | 10yd | point-blank holy ring (dmg + heal) |
| Off | (ground) | Consecration | `48819` | player | 8yd | persistent holy floor AoE |
| Off | (burst+stun) | Holy Wrath | `48817` | player | 10yd | explosive holy nova + stun |
| Support 0 | holy-exposure vs Undead `SE` | Holy Fire | `48135` | player | single | holy hit + 7s DoT — windowed exposure proxy |
| Support 0 | (anti-undead alt) | Exorcism | `48801` | player | single | thematic anti-undead holy strike |
| Support 1 | circle of healing `PW` (sustained) | Circle of Healing | `48089` | player | 15yd / ~5 | smart always-on raid-heal pulse |
| Support 1 | (group alt) | Prayer of Healing | `48072` | player | 30yd | sustained group heal |

> **Flag:** no dedicated "Holy Vulnerability" debuff on the wotlk branch (`20356` 404s) — Holy Fire's
> DoT is the windowed-exposure proxy. Sacred Shield ID left **unverified** (not invented); `53601` is
> Holy Shield, distinct from Sacred Shield.

---

## Remaining for #30 (after this doc)
This doc + `16-exotic-school-spell-map.md` complete the **spell-ID** deliverable for all 15 schools.
Still open in #30:
1. **Per-cell envelopes** — Min/Max ppm, duration, magnitude, reach overrides per cell, as data/config.
2. **Per-cell magnitude ceilings** — sustained raid buffs (flame aura, circle of healing, int/mana
   aura, raid-heal) carry a *conservative* ceiling (§14.2: `MaxProcMagnitude` is global today; this
   decomposes it per-cell).
3. **Reach rendering** — the AoE radius (yd) / cleave target counts captured in the Reach column above
   wired into the tooltip per cell (AoE radius vs cleave count distinction).
4. **§14.4.1 secondaries authored** — the Support archetype-1 picks above map to `LatticeArchetype(…, 1)`.

**Convention — reach axis is a target *count*, not a radius, wherever a count exists.** The base spell
is only the visual; the #03 adapter applies the effect, so it chooses how many targets/jumps/spreads a
proc reaches regardless of the source spell's hardcoded cap. For any spread/chain/jump cell, model the
**reach envelope as an integer count** (base → per-cell `MaxReach` ceiling, mastery-scaled) and render
it in the tooltip as "hits/jumps to N", reserving a *radius* only for genuinely field-shaped effects
where pack density is the intended scaling. This keeps mastery progression controlled, readable, and
anti-degenerate (§7.9). Cells that follow this rule:

| Cell | Visual shell | Count axis (base → mastery) |
|---|---|---|
| Physical — Off (cleave) | Cleave `845` | targets struck (2 → N) |
| Lightning — DPS (arc) | Chain Lightning `421`/`25442` | arc jumps (1 → N) |
| Venom — DPS (DoT-spread) | Pestilence `50842` | diseases spread to (1 → N) |
| Wind — Healer (HoT spread) | Prayer of Mending `33076` | allies reached (2 → N) |
| Lightning — Healer (overheal jump) | Chain Heal `1064` | heal jumps (1 → N) |

(The Lightning/Venom/Wind entries live in `16-exotic-school-spell-map.md`; recorded here so the
envelope work treats the count axis uniformly across both docs.)

**Verification caveats carried forward** (see per-school flags): Fire has no party-wide Fire-school
aura; Shadow/Frost/Holy have no exact damage-taken "vulnerability" debuff (use the windowed proxies
noted); several resistance providers are internally tagged a different school than their flavour. None
block reuse — the module remaps behaviour — but record them so the adapter doesn't assume an exact
school match. Re-verify every ID against the server's `spell_dbc` before wiring.
