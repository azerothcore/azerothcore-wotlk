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

## Next

Byte-level comparison of our player `CREATE_OBJECT2` block against cata-js's documented
layout in `docs/smsg-update-object.md` — the outer wrapper (`u16 mapId`, `u32 blockCount`,
`u8 updateType`, packed GUID, `u8 typeId`), then the 57-bit movement header, then the values
block (`u8 blockCount = 44`, `u32[44]` mask, non-zero values ascending). Structure has been
verified field-by-field at the server end; what has *not* been done is dumping the actual
bytes on the wire and diffing them against the reference layout.
