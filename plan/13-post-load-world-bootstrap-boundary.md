# Plan 13: build 15595 in-world control bootstrap

Canonical issue: [#27](https://github.com/trolloks/azerothcore-cata/issues/27)

Status: blocked. The `SMSG_TIME_SYNC_REQ`/`CMSG_TIME_SYNC_RESP` implementation (opcodes, handler,
new runtime marker) is in place and opcode-audited against the pinned reference, but real-client
evidence shows the client process reliably exits ~30s after world entry -- before a time-sync round
trip can complete -- for reasons unrelated to the time-sync path itself. See [Plan 14](https://github.com/trolloks/azerothcore-cata/issues/32),
which owns diagnosing and resolving that exit. This plan resumes once Plan 14 proves the client
survives past the current post-map-insertion boundary.

## Cinematic mode: a real confound, but NOT the cause (2026-09-08)

**Tested and disproved as the cause.** Seeding `cinematic=1` does remove a genuine
confound -- generation 77 sends zero `SMSG_TRIGGER_CINEMATIC` -- but the client's behaviour is
byte-for-byte unchanged: the same 30 client packets, the same opcode set, and still zero
`CMSG_TIME_SYNC_RESP`. Keep the fix (it removes a variable), but the stall is elsewhere.

What was actually observed:

Ordering the server's world-entry sends out of generation 76's `WorldServer.log` shows
`SMSG_TRIGGER_CINEMATIC` immediately before `SMSG_LOGIN_VERIFY_WORLD`:

```
19  SMSG_FEATURE_SYSTEM_STATUS
20  SMSG_TRIGGER_CINEMATIC      <-- intro cinematic starts here
21  SMSG_LOGIN_VERIFY_WORLD
22  SMSG_UPDATE_OBJECT
...
28  SMSG_TIME_SYNC_REQ
```

`CharacterHandler.cpp` sends it under `if (!pCurrChar->getCinematic())`, matching the pinned
TrinityCore reference. The harness seeds `characters` without a `cinematic` column, and
`characters.cinematic` is `tinyint unsigned NOT NULL DEFAULT '0'` -- so every generation
triggered the level-1 intro cinematic.

The client then answers with **nothing**: no `CMSG_COMPLETE_CINEMATIC`, no
`CMSG_NEXT_CINEMATIC_CAMERA` anywhere in the log. It stays in cinematic mode, never reaches
the normal in-world state, and therefore never answers `SMSG_TIME_SYNC_REQ` -- while still
servicing every other opcode (`CMSG_LFG_GET_STATUS`, `CMSG_BATTLEFIELD_STATUS`,
`CMSG_QUERY_TIME`, ...), which is exactly why it looked like a live client behind a stuck
loading screen.

Fixed by seeding `cinematic=1` in `run_real_client_authentication.py`; the cinematic path is
not what this boundary exercises.

### Why this took so long to find

The "stuck at 90%/99% loading screen" framing was an artifact of `window.xwd`, which never
contained the client's rendering at all. See the retraction in `client-automation.md`. Every
lead chased under that framing (opcode table values, `SMSG_COMPRESSED_UPDATE_OBJECT`,
`UpdateData::BuildPacket`, `OBJECT_UPDATE_TYPE`, `SMSG_LOGIN_VERIFY_WORLD` layout, the
bit-packed movement create block) was verified correct against the pinned reference and none
of them was the bug. The answer was in the ordered opcode log the whole time.

## Generation 77 result and the correct observable

Run on `27e8f3dd933f` with `cinematic=1`: state `observed`, `CMSG_TIME_SYNC_RESP` count **0**.
Client packet set identical to generation 76.

Two things worth carrying forward:

- **`CMSG_LOADING_SCREEN_NOTIFY` is the log-based loading-screen observable** -- use it instead
  of screenshots (see the `window.xwd` retraction in `client-automation.md`). The client sends
  it when the screen is shown and again when it is dismissed, with the map id.
- In generation 77 it appears **exactly once, and at character select** (immediately after
  `SMSG_CHAR_ENUM`, before `CMSG_PLAYER_LOGIN`). After `CMSG_PLAYER_LOGIN` the client never
  announces a world loading screen at all -- neither shown nor dismissed.

Also ruled out this round, all verified byte-identical or equivalent against the pinned
TrinityCore reference: opcode values for every packet actually sent during login (0 of 51 carry
a Cata-absent value), `SMSG_COMPRESSED_UPDATE_OBJECT` (declared but never emitted; this fork has
no compression path), `UpdateData::BuildPacket`, `OBJECT_UPDATE_TYPE`, `SMSG_LOGIN_VERIFY_WORLD`
layout and opcode, the bit-packed movement create block, and the periodic `SendTimeSync` timer.
All 6 `CMSG_GAMEOBJECT_QUERY` calls were answered. No `CMSG_TIME_SYNC_RESP_FAILED` is ever sent,
so the client is not reporting a sync failure -- it simply never reaches the state that answers.

The one still-unexplained client opcode is `0x1225`
(`CMSG_GUILD_BANK_REMAINING_WITHDRAW_MONEY_QUERY`; ours is stale at `0x3FE`), sent twice.
