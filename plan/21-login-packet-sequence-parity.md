# Plan 21: login packet sequence parity with cata-js

Canonical issue: [#43](https://github.com/trolloks/azerothcore-cata/issues/43)

Status: resolved at the world-entry stopping point on 2026-09-08.

Comparing this fork with cata-js's successful runtime packet trace identified the remaining
boundary faults. The player create-block layout matched the reference. Populated aura packets
used one-byte flags instead of build 15595's two-byte flags, and the client later disconnected
on the unregistered guild requests `0x1225` and `0x1027`.

The shared aura writer now uses `uint16`. The existing guild-bank query handler is registered
at `0x1225`, with its response on `0x5DB4` and an eight-byte signed amount. Guild achievement
tracking at `0x1027` is explicitly unhandled pending that subsystem's implementation.

A final relay test applied these exact wire corrections while retaining every outgoing packet.
The real client displayed the player and nearby NPCs and exchanged 10 time-sync requests and
replies. Earlier packet-order fixes remain; a single socket write is not required, and no
broad packet suppression is retained in the source.

See [the screenshot, evidence, and verification limits](client-automation.md#resolved-loading-screen-hang-aura-flags-2026-09-08).
Subsequent compiled-client acceptance closed Plans 13 and 20. Gameplay validation remains
separate; the conversion roadmap records the current state and next proposed plans.
