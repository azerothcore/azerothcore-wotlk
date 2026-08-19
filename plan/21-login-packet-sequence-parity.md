# Plan 21: login packet sequence parity with cata-js

Canonical issue: [#43](https://github.com/trolloks/azerothcore-cata/issues/43)

Status: open, in progress. Two real ordering/presence defects fixed; the loading screen
still does not dismiss. Blocks #27 and #32.

## Approach

A/B our post-`CMSG_PLAYER_LOGIN` `S->C` sequence against cata-js's proven-working 24-packet
flow (`docs/world-login-flow.md`), comparing presence, order and payload shape rather than
opcode identity (opcode values were already corrected in Plan 20 / #41).

## Fixed

- **`SMSG_INIT_WORLD_STATES` was sent after `SMSG_TIME_SYNC_REQ`.** cata-js sends world
  states at #21 and time sync at #22. This fork emitted world states much later, via
  `UpdateZone` further down `SendInitialPacketsAfterAddToMap`. Now sent explicitly before
  time sync so the wire order matches the reference.
- **`SMSG_TUTORIAL_FLAGS` was not in the post-login batch.** cata-js sends it at #8. This
  fork only sent it earlier, during account-data setup before `CMSG_PLAYER_LOGIN`. Now also
  sent in `SendInitialPacketsBeforeAddToMap`.

## Ruled out (each tested individually against the real client)

- `SMSG_CRITERIA_UPDATE` burst — this fork sends ~15 of these, still WotLK-shaped, before the
  core login packets, where cata-js sends none. Suppressing them entirely changed nothing.
  (They remain WotLK-shaped and should still be converted eventually, just not for this.)
- Login cinematic (`SMSG_TRIGGER_CINEMATIC`) — disabled entirely, no change.
- `SMSG_UPDATE_OBJECT` zlib compression — disabled entirely, no change.
- `SMSG_LOGIN_VERIFY_WORLD` ordering relative to the player's create block — no change.

## Current evidence: the client has no player object

This is now tightly bounded by four independent observations:

- The client's own log reports `COP_LOGIN_CHARACTER code=78 result=TRUE` — character login
  succeeds client-side, with no error.
- The loading bar is essentially full (~99% of its track), so the map/terrain loaded.
- `CMSG_OBJECT_UPDATE_FAILED` is now defined and handled, and stays silent every run — the
  client is not rejecting our `SMSG_UPDATE_OBJECT` blocks.
- **The client never sends a single `MSG_MOVE_*` heartbeat.** An in-world client sends these
  periodically. It also never sends `CMSG_TIME_SYNC_RESP`.

Taken together: the client accepts the create block but does not end up with a player object
in the world, so it never fires the transition that dismisses the loading screen. The missing
`CMSG_TIME_SYNC_RESP` is a symptom of that, not the cause — chasing it directly is backwards.

Note this is an *earlier* failure than the one cata-js documented as their 90% hang: their
client was already sending `CMSG_TIME_SYNC_RESP` and `CMSG_PING` while stuck.

## Byte-level verification of the player create block: it is correct

The actual wire bytes were dumped and decoded against cata-js's `docs/smsg-update-object.md`.
Every layer checks out:

```
00 00              u16 mapId = 0                     correct
01 00 00 00        u32 blockCount = 1                correct
02                 u8 updateType = CREATE_OBJECT2    correct
0F 04 03 02 01     packGUID -> 0x01020304            correct
04                 u8 typeId = TYPEID_PLAYER         correct
05 00 00 00 03 69  movement bit header               correct
```

The movement bit header decodes exactly as the reference specifies for a player self-create:

- `0x05` = bits `ThisIsYou` + `MovementUpdate` set, everything else clear
- `00 00 00` = 24 zero bits of PauseTimes count
- `0x03` = `!HasMoveFlags0` and `fuzzyEq(orientation, 0)`
- `0x69` = `guid[3]` and `guid[2]` present, `!HasPitch`, `!HasSplineElevation` — which is
  precisely right for GUID `0x0000000001020304`

Also verified by inspection against the pinned TrinityCore reference:

- `UpdateMask::AppendToPacket` encodes `1 << j` per block, little-endian `uint32`, matching
  the reference's "bit i set -> field i follows" convention.
- `LoginVerifyWorld::Write` writes `int32 MapID` then x/y/z/o, identical to TrinityCore.
- The values block reports `blockCount = 44`, `valuesCount = 1384`, `OBJECT_FIELD_TYPE = 0x19`
  (including `TYPEMASK_UNIT`), `SCALE = 1.0`, `HP = 60/60`.

So the create block is not malformed. Combined with the client reporting
`COP_LOGIN_CHARACTER result=TRUE`, never emitting `CMSG_OBJECT_UPDATE_FAILED`, and finishing
its map load, the packet this plan set out to validate is exonerated.

## Next

The remaining gap is not in the create block's *content* but in whatever makes the client
commit it to the world. Untested avenues, roughly in order of expected value:

1. **Batching.** cata-js sends its entire login batch in a single socket write; this fork
   sends each packet individually. Worth testing whether the client requires the post-map
   packets to arrive together.
2. **The extra packets this fork still sends** that cata-js does not — `SMSG_POWER_UPDATE`,
   `SMSG_SET_PROFICIENCY`, `MSG_SET_DUNGEON_DIFFICULTY`, `SMSG_MOVE_SET_ACTIVE_MOVER`,
   `SMSG_CONTACT_LIST`, `SMSG_SET_FORCED_REACTIONS`, `SMSG_AURA_UPDATE_ALL` — bisect by
   suppressing them as a group and then individually.
3. **`SMSG_COMPRESSED_UPDATE_OBJECT` semantics** — compression was ruled out as a blocker,
   but the opcode/threshold pairing under the realigned table has not been re-examined.
