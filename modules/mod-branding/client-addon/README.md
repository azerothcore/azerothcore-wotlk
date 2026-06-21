# Branding — client addon (WotLK 3.3.5a)

The in-game UI for the `mod-branding` server system (design §19). It shows the **invasion
schedule**, the **current invasion** in your zone with a live containment bar, your **contribution**
(points + tier), your **brand proficiency / mastery / loadout / item brand / allegiance**, and the
**§14 Mastery lattice** (5 schools × 3 trees) with per-cell point-buy.

The addon is primarily a **renderer**: it *receives* data the server pushes over the native addon
channel (prefix `BRND`), needs no Eluna/AIO, and works for a solo player. The Mastery panel can also
*send* allocation / archetype / respec **requests** — but only when a server-side client→server
channel is enabled (see [Mastery panel & talent-frame dock](#mastery-panel--talent-frame-dock));
otherwise it is display-only and you allocate via the server's `.branding` commands.

## Files

| File | Role |
|---|---|
| `Branding.toc` | Addon manifest (load order, saved variables). |
| `Comms.lua` | Shared comms layer: decodes `BRND` frames, fires callbacks, sends requests. |
| `Tracker.lua` | Invasion-tracker HUD. |
| `Panel.lua` | Tabbed character panel (Brands · Mastery summary · Loadout · Item · Allegiance). |
| `MasteryPanel.lua` | §14 Mastery lattice frame + the `PlayerTalentFrame` dock button (issue #32). |

## Install (copy, or patch-MPQ)

**Plain copy** — copy the `Branding/` folder into your client's AddOns directory:

```
<WoW 3.3.5a>/Interface/AddOns/Branding/
```

so that `Interface/AddOns/Branding/Branding.toc` exists. Restart the client (or `/reload`) and make
sure **Branding** is enabled on the character-select AddOns list.

**Patch-MPQ packaging (issue #32)** — to ship the Mastery UI to every player without an
opt-in AddOns toggle, package the `Branding/` folder inside a custom `patch-?.MPQ` (e.g.
`patch-B.MPQ`) under `Interface\AddOns\Branding\`, using an MPQ tool (Ladik's MPQ Editor /
`mpq`/`StormLib`). Drop the MPQ into the client's `Data/` directory. MPQ-bundled addons load
automatically (no AddOns-list entry needed). The addon stays 3.3.5a / build 12340 compatible — it
uses only stock 3.3.5a frame APIs and no DBC edits. **Why an MPQ + a docked button instead of a
native talent-frame tab:** a native tab would require client DBC + secure-frame edits and would
**taint** the protected `PlayerTalentFrame`. Instead we dock a plain button onto the talent frame
that toggles a **separate, unprotected** Mastery frame — the talent frame itself is never modified,
so there is no taint.

## Server side

Enable the transport in `mod_branding.conf`:

```
Branding.Addon.Enable = 1
Branding.Addon.PushIntervalSeconds = 5
```

The tracker is only meaningful with the event engine + scheduler running:

```
Branding.Enable = 1
Branding.Event.Enable = 1
Branding.Event.SchedulerEnable = 1
```

…and at least one row in the `branding_event_def` world table (zone / type / goal / active / cooldown).

## Use

- `/branding` (or `/brand`) — toggle the character panel (Brands · Mastery · Loadout · Item · Allegiance).
- `/branding tracker` — toggle the invasion-tracker HUD.
- `/branding mastery` — toggle the §14 Mastery lattice panel (also opens from the **Mastery** button
  docked on the talent frame).

All windows are drag-to-move; positions and shown/hidden state are saved per character.

## Mastery panel & talent-frame dock

The Mastery panel is a **standalone** frame (not a talent-frame tab — see the patch-MPQ note above
for why). When you open the talent frame (`N`), a **Mastery** button appears docked on it; clicking
it toggles the panel. The button is *parented* to `PlayerTalentFrame` but only ever opens a separate
frame, so it never touches the protected talent frame's internals.

The panel renders the **§14 lattice**: 5 damage schools (Fire, Nature, Shadow, Frost, Physical) × 3
trees (Def / Off / Support). Each cell shows its earned mastery level, total points invested, and
its expression family; cell colour flags **active** (green), **invested** (gold) and **selected**
(blue). Click a cell to select it, then the per-cell **point-buy** rows below show only the axes that
cell exposes (§14.10: PPM / Duration / Magnitude / Reach — a single-target cell shows 3, an
area/cleave cell shows 4). `+`/`-` send an allocation request; **Respec cell** refunds it (charging
the §14.5 token server-side).

**Server-authoritative.** The panel never mutates state locally: it displays the server's `MAST`
snapshot and *requests* changes. The server validates the §14.10 budget + caps and pushes a fresh
snapshot. If a client→server channel is not enabled on the realm, the `+`/`-`/respec controls are
disabled and the panel reads "display-only — allocate via the server's branding commands".

### MULTI-MASTERY forward-compat

A character will **later** run **multiple active masteries at once**. The data model is built for
that now: `ns.state.mastery.cells` is a flat **list** and each cell carries its own `active` flag —
there is **no single "active mastery" field** anywhere on the wire or in the UI. The panel always
renders the full lattice and highlights **every** active cell, so enabling multiple simultaneous
masteries later needs no structural change here — the server simply flags more cells `active`.

## What updates when

The server pushes (so the UI refreshes) on: **login**, **zone change**, **event start/stop**, and a
**periodic tick** (`PushIntervalSeconds` — live containment every tick, character + schedule every
6th tick). You never need to click refresh.

## Manual verification checklist (needs a live client + server)

1. `Branding.Addon.Enable = 1`, reload config, log in → the HUD appears; chat shows no protocol-mismatch warning.
2. Start an event in your zone (`.branding event start 0 1000` as GM) → within `PushIntervalSeconds`
   the HUD shows the event type and a containment bar; killing mobs in-zone raises the bar.
3. `.branding event stop` → HUD flips to "No active event in this zone".
4. Open `/branding` → each tab renders; after `.branding knowledge grant fire` + earning XP, the
   Brands tab shows the level/effect on the next CHAR push.
5. Move between zones → the tracker switches to the new zone's event/schedule.
6. Open the talent frame (`N`) → a **Mastery** button is docked on it; click it (or `/branding
   mastery`) → the lattice renders the 5×3 grid. Click a cell → its applicable axes appear below.
7. On a realm with a client→server relay configured (`BrandingDB.sendChannel`), `+`/`-`/respec send
   requests and the lattice updates on the server's next `MAST` push; otherwise those controls are
   disabled (display-only).

## Wire format

The Lua decoder in `Branding/Comms.lua` mirrors the server's pure codec
(`modules/mod-branding/src/core/branding/addon/Protocol.cpp`): tab between fields, `;` between list
records, `:` between sub-fields, floats as permille (×1000). The codec is unit-tested server-side
(`tests/addon/ProtocolTest.cpp`); keep the two in sync if you extend the protocol (bump
`ns.PROTOCOL` / `ProtocolVersion` together — currently **2**).

### Server → client frames

```
BRND\tHELLO\t<version>\t<enabled>
BRND\tEVT\t<zoneId>\t<type>\t<containmentPermille>\t<active>
BRND\tYOU\t<points>\t<tier>
BRND\tSCH\t<rec;rec;…>\t<trunc>            rec = zoneId:type:state:secondsRemaining
BRND\tCHAR\tBRD=<…>\tMST=<…>\tLDT=<…>\tITM=<…>\tALG=<…>
BRND\tMAST\t<pointsAvailable>\t<respecCost>\t<cell;cell;…>\t<trunc>
```

The **MAST** frame (§14, added in protocol v2) carries the full lattice. Each `cell` record is:

```
school:tree:kind:situational:sustained:level:archetype:axisMask:a0:a1:a2:a3:active
```

- `school` — `BrandId` ordinal (0 Fire … 6 Physical).
- `tree` — `MasteryTree` ordinal (0 Def, 1 Off, 2 Support).
- `kind` — `EffectKind` ordinal (0 PersonalSpike, 1 RaidWindow, 2 MechanicTransform).
- `situational` / `sustained` — SM/SE school-matched flag / Support sustained-aura flag (`0`/`1`).
- `level` — **earned** mastery level for the school (§14.11 earned layer; shared across specs).
- `archetype` — selected proc archetype (§7.9 loadout).
- `axisMask` — applicable-axis bitmask, bit *i* set ⇒ axis *i* tunable (§14.10). Axis order matches
  core `ProcAxis`: `0 Ppm, 1 Duration, 2 Magnitude, 3 Reach`.
- `a0..a3` — points spent on each axis (0 for non-applicable axes).
- `active` — `0`/`1`; **a list of flags, never a single active-mastery field** (multi-mastery).

A lattice too large for one 255-byte frame truncates deterministically (`trunc == "T"`), never a
silent split — same contract as `SCH`.

### Client → server requests (§19.3 reserved grammar)

These mirror the server's request encoders (`EncodeAlloc` / `EncodeArchetype` / `EncodeRespec`) and
are parsed by `ParseRequest` + `ParseAlloc` / `ParseArchetype` / `ParseRespec`:

```
BRND\tREQ\tMAST                              request a fresh MAST snapshot
BRND\tALLOC\t<school>\t<tree>\t<axis>\t<points>
BRND\tARCH\t<school>\t<tree>\t<archetype>
BRND\tRESPEC\t<school>\t<tree>
```

Per §19.3 the server adapter does not yet wire a live client→server path on 3.3.5a (no guaranteed
solo addon hook). The grammar is defined and unit-tested so the path lights up with no addon change
once a relay (group/guild/channel or a seeded RBAC perm) is enabled; the addon gates sending behind
`ns.CanSend()` and stays a pure renderer until then.
