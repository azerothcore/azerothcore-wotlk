# Plan 14: build 15595 post-map-insertion client survival

Canonical issue: [#32](https://github.com/trolloks/azerothcore-cata/issues/32)

Status: resolved at the world-entry stopping point on 2026-09-08.

The remaining loading-screen fault was a one-byte aura-flags field where build 15595 expects
two bytes. Two missing guild request registrations then caused the server to disconnect the
client after it entered the world. The shared aura writer and opcode definitions are corrected.

The real client displayed the character and nearby NPCs in Northshire and completed 10 matched
time-sync exchanges with the exact wire corrections applied in a diagnostic relay. No outgoing
packets were dropped. See [the evidence and verification limits](client-automation.md#resolved-loading-screen-hang-aura-flags-2026-09-08).

The source changes have not been rebuilt in this session. Plan 13's two-fresh-generation
acceptance remains open. Movement and gameplay remain separate work.
