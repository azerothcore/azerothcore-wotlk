# Branding — client addon (WotLK 3.3.5a)

The in-game UI for the `mod-branding` server system (design §19). It shows the **invasion
schedule**, the **current invasion** in your zone with a live containment bar, your **contribution**
(points + tier), and your **brand proficiency / mastery / loadout / item brand / allegiance**.

The addon is a **pure renderer**: it only *receives* data the server pushes over the native addon
channel (prefix `BRND`). It sends nothing, needs no Eluna/AIO, and works for a solo player.

## Install

Copy the `Branding/` folder into your client's AddOns directory:

```
<WoW 3.3.5a>/Interface/AddOns/Branding/
```

so that `Interface/AddOns/Branding/Branding.toc` exists. Restart the client (or `/reload`) and make
sure **Branding** is enabled on the character-select AddOns list.

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

Both windows are drag-to-move; positions and shown/hidden state are saved per character.

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

## Wire format

The Lua decoder in `Branding/Comms.lua` mirrors the server's pure codec
(`modules/mod-branding/src/core/addon/Protocol.cpp`): tab between fields, `;` between list records,
`:` between sub-fields, floats as permille (×1000). The codec is unit-tested server-side
(`tests/addon/ProtocolTest.cpp`); keep the two in sync if you extend the protocol (bump
`ns.PROTOCOL` / `ProtocolVersion` together).
